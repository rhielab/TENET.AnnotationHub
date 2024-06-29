#!/usr/bin/env Rscript
check_over_80_char_lines <- function(files) {
    for (f in files) {
        lines <- readLines(f)
        over_80 <- (nchar(lines) > 80)
        if (any(over_80)) {
            message(f)
            message(gsub(".", "=", f))
            for (l in which(over_80)) {
                message(l, ":", lines[l])
            }
            message("")
        }
    }
    invisible(NULL)
}

## If not running in Rscript just define the function so it can be run
if (!interactive()) {
    check_over_80_char_lines(commandArgs(trailingOnly = TRUE))
}
