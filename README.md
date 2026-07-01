# Demand and Preference for Social and Food Reinforcement in Rats

[![Published in Learning and Motivation](https://img.shields.io/badge/Article-Learning%20and%20Motivation-1f5a94)](https://doi.org/10.1016/j.lmot.2021.101780)
[![DOI](https://img.shields.io/badge/DOI-10.1016%2Fj.lmot.2021.101780-5b3f8c)](https://doi.org/10.1016/j.lmot.2021.101780)
[![Code license: MIT](https://img.shields.io/badge/Code%20license-MIT-2f6b4f)](LICENSE)

Reproducible research materials for:

> Kirkman, C., Wan, H., & Hackenberg, T. D. (2022). A behavioral-economic analysis of demand and preference for social and food reinforcement in rats. *Learning and Motivation, 77*, 101780. https://doi.org/10.1016/j.lmot.2021.101780

## Research question

How does the price of one reinforcer affect demand for another? This study used a behavioral-economic framework to compare rats' demand for food and social interaction. Own-price and cross-price analyses test whether the two outcomes function as substitutes, complements, or independent goods under different experimental conditions.

## Analytical approach

- **Own-price demand:** The zero-bounded exponential (ZBEn) model estimates demand intensity (Q₀) and elasticity (α).
- **Cross-price demand:** Linear and exponential models estimate how consumption of a constant-price reinforcer changes as the alternative becomes more costly.
- **Computational reproducibility:** Parallel R, Python, and Stata implementations make the model specifications and parameter estimates easier to inspect and reproduce.

The repository is a computational companion to the article. The article remains the authoritative source for the study design, inferential claims, and interpretation.

## Repository guide

| Location | Contents |
| --- | --- |
| [`Analysis/analysis_R.qmd`](Analysis/analysis_R.qmd) | Annotated R/Quarto analysis |
| [`Analysis/analysis_R.html`](Analysis/analysis_R.html) | Rendered R analysis |
| [`Analysis/analysis_Py.ipynb`](Analysis/analysis_Py.ipynb) | Annotated Python/Jupyter analysis |
| [`Analysis/analysis_Py.html`](Analysis/analysis_Py.html) | Rendered Python analysis |
| [`Analysis/demand_models.py`](Analysis/demand_models.py) | Dependency-light Python implementations of the published demand models |
| [`Stata/code/`](Stata/code) | Stata model specifications for condition-level and subject-level analyses |
| [`Stata/dataset/`](Stata/dataset) | Stata analysis datasets |
| [`Figure/`](Figure) | Publication figures and editable source files |
| [`Presentation/`](Presentation) | Conference poster, presentation, and abstracts |
| [`renv.lock`](renv.lock) | Locked R package environment |
| [`requirements.txt`](requirements.txt) | Pinned Python environment |

## Reproduce the analyses

Clone the repository and run all commands from its root directory.

### R

The R workflow was developed with R 4.4.1. Install [Quarto](https://quarto.org/), restore the package environment, and render the analysis:

```r
install.packages("renv")
renv::restore()
```

```bash
cd Analysis
quarto render analysis_R.qmd
```

### Python

Create an isolated environment and install the pinned dependencies:

```bash
python3 -m venv .venv
source .venv/bin/activate
python3 -m pip install -r requirements.txt
cd Analysis
jupyter lab analysis_Py.ipynb
```

### Stata

The Stata scripts use repository-relative paths. With the repository root as Stata's working directory, run:

```stata
do "Stata/code/model mean.do"
do "Stata/code/model subj cond1.do"
do "Stata/code/model subj cond2.do"
do "Stata/code/model subj cond3.do"
do "Stata/code/model subj cond4.do"
```

## Data availability

The version-controlled Stata datasets support inspection of the Stata analyses. The R and Python workflows use the processed file `data with bl mean.csv`; this file is not part of the public Git history and may be requested from the authors. See [DATA_AVAILABILITY.md](DATA_AVAILABILITY.md) for the repository's data inventory and access details.

## Open-science practices

- Human-readable analysis notebooks are provided alongside rendered outputs.
- R and Python dependencies are recorded for environment reconstruction.
- Equivalent model specifications are available across three statistical platforms.
- The repository includes machine-readable citation metadata in [`CITATION.cff`](CITATION.cff).
- Contributions and reproducibility reports are welcome under [`CONTRIBUTING.md`](CONTRIBUTING.md).

## Citation

Please cite the peer-reviewed article when using the study's methods, results, or materials. GitHub's **Cite this repository** menu can read the included citation metadata.

```text
Kirkman, C., Wan, H., & Hackenberg, T. D. (2022). A behavioral-economic
analysis of demand and preference for social and food reinforcement in rats.
Learning and Motivation, 77, 101780.
https://doi.org/10.1016/j.lmot.2021.101780
```

## License

Code in this repository is available under the [MIT License](LICENSE). The published article, figures, presentations, datasets, and third-party materials may be subject to separate copyright or reuse terms; the MIT License should not be interpreted as applying to those materials unless explicitly stated.
