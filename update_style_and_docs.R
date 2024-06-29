#!/usr/bin/env Rscript

## Create the user R library if it doesn't exist; if the script is not running
## interactively, install.packages will fail instead of asking to create it.
## This code is based on the code of install.packages() in R 4.4.0.
userdir <- unlist(strsplit(Sys.getenv("R_LIBS_USER"), .Platform$path.sep))[1L]
if (!dir.exists(userdir)) {
    dir.create(userdir, recursive = TRUE)
}

if (!requireNamespace("here", quietly = TRUE)) {
    install.packages("here", repos = "https://cloud.r-project.org")
}
if (!requireNamespace("devtools", quietly = TRUE)) {
    install.packages("devtools", repos = "https://cloud.r-project.org")
}
if (!requireNamespace("styler", quietly = TRUE)) {
    install.packages("styler", repos = "https://cloud.r-project.org")
}
## Change to the directory of this script, even if it was not run from there
oldwd <- getwd()
setwd(here::here())
styler::style_pkg(indent_by = 4)
styler::style_file("update_style_and_docs.R", indent_by = 4)
styler::style_file("check_over_80_char_lines.R", indent_by = 4)
devtools::document()
args <- commandArgs(trailingOnly = TRUE)
if (!("skip_vignettes" %in% args)) {
    devtools::build_vignettes()
}
## .Rhistory causes package check warnings
file.remove(
    list.files(pattern = "\\.Rhistory$", recursive = TRUE, all.files = TRUE)
)
## Change back to the old working directory, since the script might be sourced
setwd(oldwd)
rm(oldwd)
invisible(NULL)
