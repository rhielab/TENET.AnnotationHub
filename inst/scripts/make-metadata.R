## A script to make the metadata.csv file located in the inst/extdata directory.
## See ?AnnotationHubData::makeAnnotationHubMetadata for a description of the
## metadata.csv file, expected fields and data types. This
## AnnotationHubData::makeAnnotationHubMetadata() function can be used to
## validate the metadata.csv file before submitting the package.

## Create a data frame with the metadata
meta <- data.frame(
    Title = c(
        "TENET_10_cancer_panel_enhancer_regions",
        "TENET_10_cancer_panel_open_chromatin_regions",
        "TENET_10_cancer_panel_promoter_regions",
        "TENET_consensus_enhancer_regions",
        "TENET_consensus_open_chromatin_regions",
        "TENET_consensus_promoter_regions",
        "ENCODE_dELS_regions",
        "ENCODE_pELS_regions",
        "ENCODE_PLS_regions"
    ),
    Description = c(
        paste0(
            "A composite GRanges object containing regions of putative ",
            "enhancer elements from 10 different cancer types (BRCA, BLCA, ",
            "COAD, ESCA, HNSC, KIRP, LIHC, LUAD, LUSC, and THCA) primarily ",
            "for use in the TENET Bioconductor package. This dataset is ",
            "composed of H3K27ac and H3K4me1 peaks from ChIP-seq datasets ",
            "collected from Cistrome.org and processed using the ENCODE ",
            "pipelines. For additional information on component datasets, see ",
            "the manifest file hosted at ",
            "https://github.com/rhielab/TENET.AnnotationHub/blob/devel/",
            "data-raw/TENET_10_cancer_panel_enhancer_regions_manifest.tsv"
        ),
        paste0(
            "A composite GRanges object containing regions of open chromatin ",
            "from 10 different cancer types (BRCA, BLCA, COAD, ESCA, HNSC, ",
            "KIRP, LIHC, LUAD, LUSC, and THCA) primarily for use in the ",
            "TENET Bioconductor package. This dataset is composed of peaks ",
            "from DNase I and ATAC-seq datasets collected from Cistrome.org ",
            "and processed using the ENCODE guidelines, along with additional ",
            "TCGA ATAC-seq peaks from cancer samples of these ten types. For ",
            "additional information on component datasets, see the manifest ",
            "file hosted at ",
            "https://github.com/rhielab/TENET.AnnotationHub/blob/devel/",
            "data-raw/TENET_10_cancer_panel_open_chromatin_regions_manifest.tsv"
        ),
        paste0(
            "A composite GRanges object containing regions of putative ",
            "promoter elements from 10 different cancer types (BRCA, BLCA, ",
            "COAD, ESCA, HNSC, KIRP, LIHC, LUAD, LUSC, and THCA) primarily ",
            "for use in the TENET Bioconductor package. This dataset is ",
            "composed of H3K27me3 peaks from ChIP-seq datasets collected from ",
            "Cistrome.org and processed using the ENCODE guidelines. For ",
            "additional information on component datasets, see the manifest ",
            "file hosted at ",
            "https://github.com/rhielab/TENET.AnnotationHub/blob/devel/",
            "data-raw/TENET_10_cancer_panel_promoter_regions_manifest.tsv"
        ),
        paste0(
            "A composite GRanges object containing regions of putative ",
            "enhancer elements from a variety of sources, primarily for use ",
            "in the TENET Bioconductor package. This dataset is composed of ",
            "regions of strong enhancers as annotated by the ",
            "Roadmap Epigenomics ChromHMM expanded 18-state model based on 98 ",
            "reference epigenomes, lifted over to the hg38 genome, as well as ",
            "regions of human permissive enhancers identified by the FANTOM5 ",
            "project. For additional information on component datasets, see ",
            "the manifest file hosted at ",
            "https://github.com/rhielab/TENET.AnnotationHub/blob/devel/",
            "data-raw/TENET_consensus_datasets_manifest.tsv"
        ),
        paste0(
            "A composite GRanges object containing regions of open chromatin ",
            "from a variety of sources, primarily for use in the TENET ",
            "Bioconductor package. This dataset is composed of DNase I ",
            "hypersensitive regions from the master list compiled from 125 ",
            "cell types by ENCODE, lifted over to the hg38 genome, along with ",
            "TCGA ATAC-seq peaks from 410 cancer samples of 23 cancer types. ",
            "For additional information on component datasets, see the ",
            "manifest file hosted at ",
            "https://github.com/rhielab/TENET.AnnotationHub/blob/devel/",
            "data-raw/TENET_consensus_datasets_manifest.tsv"
        ),
        paste0(
            "A composite GRanges object containing regions of putative ",
            "promoter elements from a variety of sources, primarily for use ",
            "in the TENET Bioconductor package. This dataset is composed of ",
            "regions flanking transcription start sites as annotated by the ",
            "Roadmap Epigenomics ChromHMM expanded 18-state model based on 98 ",
            "reference epigenomes, lifted over to the hg38 genome. For ",
            "additional information on component datasets, see the manifest ",
            "file hosted at ",
            "https://github.com/rhielab/TENET.AnnotationHub/blob/devel/",
            "data-raw/TENET_consensus_datasets_manifest.tsv"
        ),
        paste0(
            "A GRanges object containing regions of candidate cis-regulatory ",
            "elements with distal enhancer-like signatures as identified by ",
            "the ENCODE SCREEN project. These consist of regions with high ",
            "H3K27ac and DNase signal, but low H3K4me3 signal, and located ",
            "more than 2kb from GENCODE transcription start sites."
        ),
        paste0(
            "A GRanges object containing regions of candidate cis-regulatory ",
            "elements with proximal enhancer-like signatures as identified by ",
            "the ENCODE SCREEN project. These consist of regions with high ",
            "H3K27ac and DNase signal, but low H3K4me3 signal, and located ",
            "2kb or less from GENCODE transcription start sites."
        ),
        paste0(
            "A GRanges object containing regions of candidate cis-regulatory ",
            "elements with promoter-like signatures as identified by ",
            "the ENCODE SCREEN project. These consist of regions with high ",
            "H3K4me3 and DNase signal, and located within 200 bp of a GENCODE ",
            "transcription start site."
        )
    ),
    BiocVersion = c(
        "3.20", "3.20", "3.20", "3.20", "3.20", "3.20", "3.20", "3.20", "3.20"
    ),
    Genome = c(
        "hg38", "hg38", "hg38", "hg38", "hg38", "hg38", "hg38", "hg38", "hg38"
    ),
    SourceType = c(
        "Multiple", "Multiple", "Multiple",
        "Multiple", "Multiple", "Multiple",
        "BED", "BED", "BED"
    ),
    SourceUrl = c(
        ## Manifest files include sources of all component data
        paste0(
            "https://github.com/rhielab/TENET.AnnotationHub/raw/devel/",
            "data-raw/TENET_10_cancer_panel_enhancer_regions_manifest.tsv"
        ),
        paste0(
            "https://github.com/rhielab/TENET.AnnotationHub/raw/devel/",
            "data-raw/TENET_10_cancer_panel_open_chromatin_regions_manifest.tsv"
        ),
        paste0(
            "https://github.com/rhielab/TENET.AnnotationHub/raw/devel/",
            "data-raw/TENET_10_cancer_panel_promoter_regions_manifest.tsv"
        ),
        paste0(
            "https://github.com/rhielab/TENET.AnnotationHub/raw/devel/",
            "data-raw/TENET_consensus_datasets_manifest.tsv"
        ),
        paste0(
            "https://github.com/rhielab/TENET.AnnotationHub/raw/devel/",
            "data-raw/TENET_consensus_datasets_manifest.tsv"
        ),
        paste0(
            "https://github.com/rhielab/TENET.AnnotationHub/raw/devel/",
            "data-raw/TENET_consensus_datasets_manifest.tsv"
        ),
        "https://screen.encodeproject.org/",
        "https://screen.encodeproject.org/",
        "https://screen.encodeproject.org/"
    ),
    SourceVersion = c(
        NA,
        NA,
        NA,
        NA,
        NA,
        NA,
        "Registry V3",
        "Registry V3",
        "Registry V3"
    ),
    Species = c(
        "Homo sapiens", "Homo sapiens", "Homo sapiens", "Homo sapiens",
        "Homo sapiens", "Homo sapiens", "Homo sapiens", "Homo sapiens",
        "Homo sapiens"
    ),
    TaxonomyId = c(9606, 9606, 9606, 9606, 9606, 9606, 9606, 9606, 9606),
    Coordinate_1_based = c(
        TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE
    ),
    DataProvider = c(
        NA, NA, NA, NA, NA, NA, "ENCODE", "ENCODE", "ENCODE"
    ),
    Maintainer = c(
        "Rhie Lab at the University of Southern California <rhielab@gmail.com>",
        "Rhie Lab at the University of Southern California <rhielab@gmail.com>",
        "Rhie Lab at the University of Southern California <rhielab@gmail.com>",
        "Rhie Lab at the University of Southern California <rhielab@gmail.com>",
        "Rhie Lab at the University of Southern California <rhielab@gmail.com>",
        "Rhie Lab at the University of Southern California <rhielab@gmail.com>",
        "Rhie Lab at the University of Southern California <rhielab@gmail.com>",
        "Rhie Lab at the University of Southern California <rhielab@gmail.com>",
        "Rhie Lab at the University of Southern California <rhielab@gmail.com>"
    ),
    RDataClass = c(
        "GRanges", "GRanges", "GRanges", "GRanges", "GRanges", "GRanges",
        "GRanges", "GRanges", "GRanges"
    ),
    DispatchClass = c(
        "Rda", "Rda", "Rda", "Rda", "Rda", "Rda", "Rda", "Rda", "Rda"
    ),
    RDataPath = c(
        "TENET.AnnotationHub/TENET_10_cancer_panel_enhancer_regions.Rda",
        paste0(
            "TENET.AnnotationHub/",
            "TENET_10_cancer_panel_open_chromatin_regions.Rda"
        ),
        "TENET.AnnotationHub/TENET_10_cancer_panel_promoter_regions.Rda",
        "TENET.AnnotationHub/TENET_consensus_enhancer_regions.Rda",
        "TENET.AnnotationHub/TENET_consensus_open_chromatin_regions.Rda",
        "TENET.AnnotationHub/TENET_consensus_promoter_regions.Rda",
        "TENET.AnnotationHub/ENCODE_dELS_regions.Rda",
        "TENET.AnnotationHub/ENCODE_pELS_regions.Rda",
        "TENET.AnnotationHub/ENCODE_PLS_regions.Rda"
    ),
    Tags = c(
        "ENCODE:GEO:ChipSeq:Homo_sapiens:peaks:TENET",
        "ENCODE:GEO:TCGA:Homo_sapiens:peaks:TENET",
        "ENCODE:GEO:ChipSeq:H3K4me3:Homo_sapiens:peaks:TENET",
        "EpigenomeRoadMap:FANTOM5:Homo_sapiens:TENET",
        "ENCODE:TCGA:Homo_sapiens:TENET",
        "EpigenomeRoadMap:Homo_sapiens:TENET",
        "ENCODE:Homo_sapiens:DnaseSeq:H3K27ac:peaks",
        "ENCODE:Homo_sapiens:DnaseSeq:H3K27ac:peaks",
        "ENCODE:Homo_sapiens:DnaseSeq:H3K4me3:peaks"
    )
)

## Create the inst/extdata directory if it doesn't exist
if (!dir.exists("inst/extdata")) {
    dir.create("inst/extdata")
}

## Write the metadata.csv file
write.csv(meta, file = "inst/extdata/metadata.csv", row.names = FALSE)
