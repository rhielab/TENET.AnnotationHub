## ----echo = FALSE, message = FALSE--------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
options(tibble.print_min = 4, tibble.print_max = 4)

## ----eval = FALSE-------------------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly = TRUE)) {
#      install.packages("BiocManager")
#  }
#  
#  BiocManager::install("TENET.AnnotationHub")

## ----eval = FALSE-------------------------------------------------------------
#  ## Install prerequisite packages to install the development version from GitHub
#  if (!requireNamespace("BiocManager", quietly = TRUE)) {
#      install.packages("BiocManager")
#  }
#  if (!requireNamespace("remotes", quietly = TRUE)) {
#      install.packages("remotes")
#  }
#  
#  BiocManager::install("rhielab/TENET.AnnotationHub")

## ----message = FALSE----------------------------------------------------------
library(TENET.AnnotationHub)

## -----------------------------------------------------------------------------
## Retrieve the AnnotationHub metadata for the object
ENCODE_dELS_regions(metadata = TRUE)

## Retrieve the object itself
ENCODE_dELS_regions()

## -----------------------------------------------------------------------------
## Retrieve the AnnotationHub metadata for the object
ENCODE_pELS_regions(metadata = TRUE)

## Retrieve the object itself
ENCODE_pELS_regions()

## -----------------------------------------------------------------------------
## Retrieve the AnnotationHub metadata for the object
ENCODE_PLS_regions(metadata = TRUE)

## Retrieve the object itself
ENCODE_PLS_regions()

## -----------------------------------------------------------------------------
## Retrieve the AnnotationHub metadata for the object
TENET_10_cancer_panel_enhancer_regions(metadata = TRUE)

## Retrieve the object itself
TENET_10_cancer_panel_enhancer_regions()

## -----------------------------------------------------------------------------
## Retrieve the AnnotationHub metadata for the object
TENET_10_cancer_panel_open_chromatin_regions(metadata = TRUE)

## Retrieve the object itself
TENET_10_cancer_panel_open_chromatin_regions()

## -----------------------------------------------------------------------------
## Retrieve the AnnotationHub metadata for the object
TENET_10_cancer_panel_promoter_regions(metadata = TRUE)

## Retrieve the object itself
TENET_10_cancer_panel_promoter_regions()

## -----------------------------------------------------------------------------
## Retrieve the AnnotationHub metadata for the object
TENET_consensus_enhancer_regions(metadata = TRUE)

## Retrieve the object itself
TENET_consensus_enhancer_regions()

## -----------------------------------------------------------------------------
## Retrieve the AnnotationHub metadata for the object
TENET_consensus_open_chromatin_regions(metadata = TRUE)

## Retrieve the object itself
TENET_consensus_open_chromatin_regions()

## -----------------------------------------------------------------------------
## Retrieve the AnnotationHub metadata for the object
TENET_consensus_promoter_regions(metadata = TRUE)

## Retrieve the object itself
TENET_consensus_promoter_regions()

## -----------------------------------------------------------------------------
sessionInfo()

