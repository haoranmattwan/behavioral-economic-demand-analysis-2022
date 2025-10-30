# Behavioral-Economic Demand Analysis of Qualitatively Different Goods
### An R, Python, and Stata Replication of Kirkman et al. (2022)

This repository contains the complete, reproducible analysis scripts and supporting materials for the peer-reviewed publication:

> Kirkman, C., Wan, H., & Hackenberg, T. D. (2022). A behavioral-economic analysis of demand and preference for social and food reinforcement in rats. *Learning and Motivation*, *77*, 101780. https://doi.org/10.1016/j.lmot.2021.101780

**Note on Data:** The data for this study can be requested from me or from my coauthors, Cyrus Kirkman and Tim Hackenberg. For a fully reproducible portfolio, it is recommended to include the data file in the repository (e.g., in a `/Data` folder).

---

## Project Objective

The goal of this project is to apply a behavioral-economic framework to quantify the value of two qualitatively different goods (food and social interaction). The analysis demonstrates how to model consumption as a function of price to determine **own-price elasticity** and **cross-price elasticity**, allowing for a quantitative assessment of whether the goods function as economic substitutes, complements, or are independent.

A core feature of this repository is the validation of the nonlinear model fitting process across three major statistical platforms—**R**, **Python**, and **Stata**—demonstrating the robustness of the findings and technical versatility.

## Repository Contents

| File / Folder | Description |
| :--- | :--- |
| **`/Analysis/`** | Contains the primary scripts that replicate all findings in the paper. |
| `analysis.qmd` | A Quarto document with the complete **R** workflow, using `minpack.lm` for model fitting. |
| `analysis.ipynb` | A Jupyter Notebook providing a **Python** translation of the analysis, using `lmfit`. |
| **`/Figure/`** | All figures as they appear in the final publication. |
| **`/Presentation/`** | A conference poster and abstracts summarizing the research. |
| **`/Stata/`** | Contains `.do` files with the complete **Stata** workflow, using the `nl` command for validation. |

---

## Methodological Approach

The analysis applies a behavioral-economic framework to quantify reinforcer value by fitting specialized nonlinear models to consumption data using nonlinear least-squares:

* **Own-Price Demand**: The **Zero-Bounded Exponential (ZBEn) model** was fit to characterize demand intensity ($Q_0$) and elasticity ($\alpha$) as a function of a good's own price.
* **Cross-Price Demand**: Both a **linear model** and **Hursh's (2014) exponential cross-price model** were used to quantify the interaction between the two goods (i.e., substitutability or complementarity).
* **Cross-Platform Validation**: To ensure the robustness of the parameter estimates, the entire model-fitting process was replicated across three major statistical platforms: R (`minpack.lm`), Python (`lmfit`), and Stata (`nl`).

---

## How to Reproduce This Analysis

First, obtain the data file (`data with bl mean.csv`) and place it in a `/Data` subdirectory within the project folder. Then, set up the appropriate software environment.

### R Environment (`/Analysis/analysis.qmd`)

* **Required Packages**: `readr`, `dplyr`, `minpack.lm`.
* **Installation**:
    ```R
    install.packages(c("readr", "dplyr", "minpack.lm"))
    ```

### Python Environment (`/Analysis/analysis.ipynb`)

* **Required Packages**: `pandas`, `numpy`, `scipy`, `lmfit`.
* **Installation**:
    ```bash
    pip install pandas numpy scipy lmfit
    ```

### Stata Environment (`/Stata/*.do`)

* **Required Software**: A licensed version of Stata.
* **Execution**: The `.do` files can be run directly within the Stata console after updating the file path to the data in the first line of each script.