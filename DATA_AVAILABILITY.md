# Data availability

## Current status

The Git-tracked repository contains two Stata analysis datasets:

- `Stata/dataset/data.dta`: observations used in the subject-level models.
- `Stata/dataset/data_mean.dta`: condition-level means used in the aggregate models.

The R and Python workflows read a processed CSV named `data with bl mean.csv` from the `Analysis/` directory. That CSV is not currently included in the public Git history. It may be requested from Haoran Wan or the article's coauthors, Cyrus Kirkman and Timothy D. Hackenberg.

## Responsible reuse

These data originate from an animal study. Reusers should consult the peer-reviewed article for the experimental design, subject information, procedures, exclusions, and interpretation before conducting secondary analyses.

The repository's MIT License covers code, not datasets by default. Confirm the applicable data-reuse terms with the authors before redistribution.

## Recommended archive upgrade

For full computational reproducibility, a future release should deposit the analysis-ready data in a stable research repository and record:

1. a persistent identifier (for example, a DOI);
2. a data dictionary with units, coding, transformations, and missing-value conventions;
3. checksums for each analysis input;
4. the study's data-reuse license; and
5. links between the archived data, article, and exact software release.
