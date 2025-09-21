# A Behavioral-Economic Analysis of Demand and Preference for Social and Food Reinforcement in Rats

This repository contains the full set of analytical code, figures, and supplementary materials for the peer-reviewed publication:

> Kirkman, C., Wan, H., & Hackenberg, T. D. (2022). A behavioral-economic analysis of demand and preference for social and food reinforcement in rats. *Learning and Motivation*, *77*, 101780. https://doi.org/10.1016/j.lmot.2021.101780

---

## Project Overview

This research used a behavioral-economic approach to analyze the demand for, and interactions between, food and social reinforcement in rats. By systematically varying the price (fixed-ratio schedule) of each reinforcer, we were able to generate demand curves to quantify own-price and cross-price elasticity.

The analysis demonstrates a robust, multi-language approach to fitting complex nonlinear models, with code provided in **R**, **Python**, and **Stata**.

The data can be requested from me or from my coauthors, Cyrus Kirkman and Tim Hackenberg.

## Repository Structure

The project materials are organized into the following folders:

* **`/Analysis`**: Contains the primary analysis scripts.
    * `analysis.qmd`: A Quarto document with the complete **R** code for fitting the demand models using the `minpack.lm` package.
    * `analysis.ipynb`: A Jupyter Notebook with the corresponding **Python** code, replicating the analysis using the `pandas`, `numpy`, and `lmfit` libraries.

* **`/Figure`**: Contains the figures as they appear in the final publication.

* **`/Poster`**: Includes a conference poster summarizing the study's methods and findings.

* **`/Prism`**: Contains GraphPad Prism project files used for creating some of the manuscript figures.

* **`/Stata`**: Includes the `.do` files with the **Stata** code used to fit the nonlinear demand models (`nl` command), validating the results across multiple statistical platforms.

---

## Methodology Snapshot

The core of this project is the application of specialized behavioral-economic models to quantify reinforcer value:

1.  **Own-Price Demand**: The **Zero-Bounded Exponential (ZBEn) model** (Gilroy et al., 2021) was used to model consumption as a function of its own price.
2.  **Cross-Price Demand**: Both a **simple linear model** and an **exponential cross-price elasticity model** (Hursh, 2014) were used to assess the substitutability between food and social reinforcers.

The fitting of these nonlinear models was successfully replicated across R, Python, and Stata, ensuring the robustness of the findings.

---

## Software and Execution

To run the analyses, you will need the appropriate software environment for your chosen language.

### R Environment (`/Analysis/analysis.qmd`)

* **Required Packages**: `readr`, `dplyr`, `minpack.lm`.
* **Installation**:
    ```R
    install.packages(c("readr", "dplyr", "minpack.lm"))
    ```

### Python Environment (`/Analysis/analysis.ipynb`)

* **Required Packages**: `pandas`, `numpy`, `lmfit`.
* **Installation**:
    ```bash
    pip install pandas numpy lmfit
    ```

### Stata Environment (`/Stata/*.do`)

* **Required Software**: A licensed version of Stata.
* **Execution**: The `.do` files can be run directly within the Stata console. You may need to update the file path to the data in the first line of each script.