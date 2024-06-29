# TENET.AnnotationHub

### AnnotationHub package containing datasets for use in the TENET package

# Introduction

The TENET.AnnotationHub package contains 9 GenomicRanges datasets for use in the [TENET](https://github.com/rhielab/TENET) package, which are all aligned to the hg38 human genome. These datasets include regions of putative enhancers, promoters, and open chromatin such as the ENCODE Registry of cCREs V3 datasets, consensus datasets derived from a wide variety of tissues, cells, and patient samples from sources including Roadmap Epigenomics ChromHMM annotations, FANTOM5 putative enhancers, the ENCODE DNaseI Hypersensitive Site Master List, and TCGA tumor samples, as well as datasets relevant to 10 unique cancer types (BLCA, BRCA, COAD, ESCA, HNSC, KIRP, LIHC, LUAD, LUSC, and THCA) we personally curated from hundreds of GEO datasets and relevant TCGA tumor samples (see Mullen et al).

Manifests for the last two categories of datasets, which are derived from a variety of different sources instead of a single source, are available in the data-raw subdirectory of this GitHub repository. These manifests detail, among other information, the ENCODE/GEO experiments where the files originate.

The raw .bed.gz and .narrowPeak.gz files we downloaded/processed, respectively, are available in a separate [TENET.AnnotationHub_files repository](https://github.com/rhielab/TENET.AnnotationHub_files), which also contains copies of the manifests for the datasets containing these files.

# Acquiring and installing TENET.AnnotationHub

R 4.4 or a newer version is required.

On Ubuntu 22.04, installation was successful in a fresh R environment after adding the official R Ubuntu repository using the instructions at <https://cran.r-project.org/bin/linux/ubuntu/> and running:

`sudo apt-get install r-base-core r-base-dev libcurl4-openssl-dev libfreetype6-dev libfribidi-dev libfontconfig1-dev libharfbuzz-dev libtiff5-dev libxml2-dev`

No dependencies other than R are required on macOS or Windows.

Two versions of this package are available.

To install the stable version from Bioconductor, run:

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("TENET.AnnotationHub")
```
The development version containing the most recent updates is available from our GitHub repository.

To install the development version from GitHub, run:

```r
## Install prerequisite packages to install the development version from GitHub
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
if (!requireNamespace("remotes", quietly = TRUE)) {
    install.packages("remotes")
}

BiocManager::install("rhielab/TENET.AnnotationHub")
```

# Loading TENET.AnnotationHub

To load the TENET.AnnotationHub package, run:

```r
library(TENET.AnnotationHub)
```

# Using the included datasets

Wrapper functions are provided to allow easy access to all included datasets. See the vignette for more details.

## [Package documentation](https://github.com/rhielab/TENET.AnnotationHub/raw/devel/TENET.AnnotationHub.pdf)

## [Vignette](https://github.com/rhielab/TENET.AnnotationHub/raw/devel/doc/TENET.AnnotationHub_vignette.pdf)
