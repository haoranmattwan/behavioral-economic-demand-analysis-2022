"""Numerical models used in the RatPrice Python reproduction.

The module intentionally depends only on NumPy. It implements the published
ZBEn and cross-price models with a small deterministic Levenberg-Marquardt
solver so the analysis does not depend on a particular high-level fitting
package. The R report provides an independent implementation with minpack.lm.
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import Callable, Iterable

import numpy as np


Array = np.ndarray


def ihs10(quantity: Array | float) -> Array:
    """Base-10 inverse-hyperbolic-sine transformation used by the ZBEn model."""

    q = np.asarray(quantity, dtype=float)
    return np.log10(0.5 * q + np.sqrt(0.25 * q**2 + 1.0))


def inverse_ihs10(value: Array | float) -> Array:
    """Inverse of :func:`ihs10`."""

    z = np.asarray(value, dtype=float)
    return 2.0 * np.sinh(np.log(10.0) * z)


def zben_ihs(price: Array | float, q0: float, alpha: float) -> Array:
    """Normalized zero-bounded exponential model on the IHS scale."""

    p = np.asarray(price, dtype=float)
    q0_ihs = float(ihs10(q0))
    return q0_ihs * np.exp((-alpha / q0_ihs) * q0 * p)


def zben_quantity(price: Array | float, q0: float, alpha: float) -> Array:
    """ZBEn prediction returned to the original consumption scale."""

    return inverse_ihs10(zben_ihs(price, q0, alpha))


def _finite_difference_jacobian(
    model: Callable[[Array, Array], Array], x: Array, theta: Array
) -> Array:
    columns = []
    for index in range(theta.size):
        step = 1e-5 * (abs(theta[index]) + 1.0)
        upper = theta.copy()
        lower = theta.copy()
        upper[index] += step
        lower[index] -= step
        columns.append((model(x, upper) - model(x, lower)) / (2.0 * step))
    return np.column_stack(columns)


@dataclass(frozen=True)
class LeastSquaresResult:
    parameters: Array
    sse: float
    iterations: int
    converged: bool


def levenberg_marquardt(
    model: Callable[[Array, Array], Array],
    x: Iterable[float],
    y: Iterable[float],
    start: Iterable[float],
    max_iterations: int = 2000,
) -> LeastSquaresResult:
    """Fit a nonlinear model by deterministic damped least squares."""

    x_array = np.asarray(x, dtype=float)
    y_array = np.asarray(y, dtype=float)
    theta = np.asarray(start, dtype=float)
    damping = 1e-3
    sse = float(np.sum((y_array - model(x_array, theta)) ** 2))
    converged = False

    for iteration in range(1, max_iterations + 1):
        prediction = model(x_array, theta)
        residual = y_array - prediction
        jacobian = _finite_difference_jacobian(model, x_array, theta)
        information = jacobian.T @ jacobian
        penalty = np.diag(np.diag(information) + 1e-12)
        step = np.linalg.pinv(information + damping * penalty) @ (jacobian.T @ residual)
        candidate = theta + step
        candidate_sse = float(np.sum((y_array - model(x_array, candidate)) ** 2))

        if np.isfinite(candidate_sse) and candidate_sse < sse:
            improvement = sse - candidate_sse
            theta = candidate
            sse = candidate_sse
            damping = max(damping / 3.0, 1e-12)
            if improvement < 1e-12 * (1.0 + sse) or np.linalg.norm(step) < 1e-8 * (
                1.0 + np.linalg.norm(theta)
            ):
                converged = True
                break
        else:
            damping = min(damping * 10.0, 1e12)

    return LeastSquaresResult(theta, sse, iteration, converged)


def calculate_pmax(q0: float, alpha: float, maximum_observed_price: float) -> float:
    """Return the first price at which the published demand slope equals -1."""

    rate = alpha * q0 / float(ihs10(q0))

    def slope_equation(price: float | Array) -> Array:
        p = np.asarray(price, dtype=float)
        return 1.0 - p * np.log(10.0) * alpha * q0 * np.exp(-rate * p)

    grid = np.geomspace(1e-6, maximum_observed_price * 100.0, 10000)
    values = slope_equation(grid)
    crossing = np.flatnonzero(values[:-1] * values[1:] <= 0.0)
    if crossing.size == 0:
        return float("nan")

    low = float(grid[crossing[0]])
    high = float(grid[crossing[0] + 1])
    for _ in range(100):
        midpoint = (low + high) / 2.0
        if float(slope_equation(low)) * float(slope_equation(midpoint)) <= 0.0:
            high = midpoint
        else:
            low = midpoint
        if high - low < 1e-12:
            break
    return (low + high) / 2.0


def fit_zben(price: Iterable[float], quantity: Iterable[float]) -> dict[str, float | bool]:
    """Estimate ZBEn Q0 and alpha and derive EV, Pmax, and legacy R2."""

    x = np.asarray(price, dtype=float)
    q = np.asarray(quantity, dtype=float)
    y = ihs10(q)

    def model(current_price: Array, theta: Array) -> Array:
        q0 = np.exp(np.clip(theta[0], -20.0, 20.0))
        alpha = np.exp(np.clip(theta[1], -30.0, 10.0))
        return zben_ihs(current_price, q0, alpha)

    result = levenberg_marquardt(
        model,
        x,
        y,
        start=(np.log(max(float(q.max()), 1e-6)), np.log(1e-4)),
    )
    q0, alpha = np.exp(result.parameters)
    prediction = model(x, result.parameters)
    legacy_r2 = 1.0 - result.sse / float(np.sum(y**2))
    return {
        "Q0": float(q0),
        "alpha": float(alpha),
        "EV": float(1.0 / (100.0 * alpha)),
        "Pmax": calculate_pmax(float(q0), float(alpha), float(x.max())),
        "R2": float(legacy_r2),
        "converged": result.converged,
    }


def fit_cross_linear(price: Iterable[float], quantity: Iterable[float]) -> dict[str, float]:
    """Fit log10 quantity = kappa * price + mu by ordinary least squares."""

    x = np.asarray(price, dtype=float)
    y = np.log10(np.asarray(quantity, dtype=float))
    design = np.column_stack((np.ones_like(x), x))
    mu, kappa = np.linalg.lstsq(design, y, rcond=None)[0]
    prediction = design @ np.array([mu, kappa])
    sse = float(np.sum((y - prediction) ** 2))
    r2 = 1.0 - sse / float(np.sum((y - y.mean()) ** 2))
    return {"kappa": float(kappa), "mu": float(mu), "R2": float(r2)}


def fit_cross_exponential(
    price: Iterable[float],
    quantity: Iterable[float],
    starts: Iterable[tuple[float, float, float]],
) -> dict[str, float | bool]:
    """Fit the exponential cross-price model and retain the lowest-SSE start."""

    x = np.asarray(price, dtype=float)
    y = np.log10(np.asarray(quantity, dtype=float))

    def model(current_price: Array, theta: Array) -> Array:
        log_qalone, interaction, beta = theta
        return log_qalone / np.log(10.0) + interaction * np.exp(-beta * current_price)

    candidates = []
    for qalone, interaction, beta in starts:
        candidate = levenberg_marquardt(
            model, x, y, (np.log(qalone), interaction, beta)
        )
        candidates.append(candidate)

    result = min(candidates, key=lambda candidate: candidate.sse)
    log_qalone, interaction, beta = result.parameters
    r2 = 1.0 - result.sse / float(np.sum((y - y.mean()) ** 2))
    return {
        "Qalone": float(np.exp(log_qalone)),
        "I": float(interaction),
        "beta": float(beta),
        "R2": float(r2),
        "converged": result.converged,
    }
