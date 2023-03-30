# Pandera Nyhackr Talk 03/30/2023

## Env Setup

Create a virtual environment using [miniconda](https://docs.conda.io/en/main/miniconda.html)/[mamba](https://mamba.readthedocs.io/en/latest/installation.html). This makes installing both Python and R dependencies a little easier.

```bash
conda create -y -n pandera-nyhackr python=3.10
conda activate pandera-nyhackr
conda install -y -c conda-forge \
    pandera \
    pandera-strategies \
    r-base \
    r-essentials \
    r-reticulate
```

## Usage

Run the `simple.R` script:

```bash
Rscript src/simple.R
```

Render the `simple.Rmd` markdown file:

```bash
R -e 'rmarkdown::render("src/simple.Rmd", "html_document", output_dir = ".")'
```

This will produce a file called `simple.html` in the root of your repo.
