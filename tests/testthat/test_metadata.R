## This is based on code generated by HubPub::create_pkg()

context("metadata validity")

test_that("metadata is valid", {
    if (!requireNamespace("AnnotationHubData", quietly = TRUE)) {
        BiocManager::install("AnnotationHubData")
    }

    path <- find.package("TENET.AnnotationHub")
    metadata <- system.file(
        "extdata", "metadata.csv",
        package = "TENET.AnnotationHub"
    )
    expect_true(AnnotationHubData::makeAnnotationHubMetadata(path, metadata))
})
