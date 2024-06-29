#' @title ENCODE dELS regions
#'
#' @description A GRanges object containing regions of candidate cis-regulatory
#' elements with distal enhancer-like signatures as identified by the ENCODE
#' SCREEN project. These consist of regions with high H3K27ac and DNase signal,
#' but low H3K4me3 signal, and located more than 2kb from GENCODE transcription
#' start sites. **Citation:** ENCODE Project Consortium; Moore JE, Purcaro MJ,
#' Pratt HE, et al. Expanded encyclopaedias of DNA elements in the human and
#' mouse genomes. Nature. 2020 Jul;583(7818):699-710. doi:
#' 10.1038/s41586-020-2493-4. Epub 2020 Jul 29. Erratum in: Nature. 2022
#' May;605(7909):E3. PMID: 32728249; PMCID: PMC7410828.
#'
#' @param metadata If TRUE, retrieve the AnnotationHub metadata instead of the
#' object itself. Defaults to FALSE.
#'
#' @examplesIf interactive()
#' ENCODE_dELS_regions()
#'
#' @export
#'
#' @return A GRanges object with 786,756 ranges and no metadata.
#'
#' @source{
#'     \url{https://screen.encodeproject.org}
#' }
ENCODE_dELS_regions <- function(metadata = FALSE) {
    ah <- AnnotationHub::AnnotationHub()
    if (metadata) {
        return(ah["AH116727", verbose = FALSE])
    } else {
        return(ah[["AH116727", verbose = FALSE]])
    }
}

#' @title ENCODE pELS regions
#'
#' @description A GRanges object containing regions of candidate cis-regulatory
#' elements with proximal enhancer-like signatures as identified by the ENCODE
#' SCREEN project. These consist of regions with high H3K27ac and DNase signal,
#' but low H3K4me3 signal, and located 2kb or less from GENCODE transcription
#' start sites. **Citation:** ENCODE Project Consortium; Moore JE, Purcaro MJ,
#' Pratt HE, et al. Expanded encyclopaedias of DNA elements in the human and
#' mouse genomes. Nature. 2020 Jul;583(7818):699-710. doi:
#' 10.1038/s41586-020-2493-4. Epub 2020 Jul 29. Erratum in: Nature. 2022
#' May;605(7909):E3. PMID: 32728249; PMCID: PMC7410828.
#'
#' @param metadata If TRUE, retrieve the AnnotationHub metadata instead of the
#' object itself. Defaults to FALSE.
#'
#' @examplesIf interactive()
#' ENCODE_pELS_regions()
#'
#' @export
#'
#' @return A GRanges object with 171,292 ranges and no metadata.
#'
#' @source{
#'     \url{https://screen.encodeproject.org}
#' }
ENCODE_pELS_regions <- function(metadata = FALSE) {
    ah <- AnnotationHub::AnnotationHub()
    if (metadata) {
        return(ah["AH116728", verbose = FALSE])
    } else {
        return(ah[["AH116728", verbose = FALSE]])
    }
}

#' @title ENCODE PLS regions
#'
#' @description A GRanges object containing regions of candidate cis-regulatory
#' elements with promoter-like signatures as identified by the ENCODE SCREEN
#' project. These consist of regions with high H3K4me3 and DNase signal, and
#' located within 200 bp of a GENCODE transcription start site. **Citation:**
#' ENCODE Project Consortium; Moore JE, Purcaro MJ, Pratt HE, et al. Expanded
#' encyclopaedias of DNA elements in the human and mouse genomes. Nature.
#' 2020 Jul;583(7818):699-710. doi: 10.1038/s41586-020-2493-4. Epub 2020 Jul 29.
#' Erratum in: Nature. 2022 May;605(7909):E3. PMID: 32728249; PMCID: PMC7410828.
#'
#' @param metadata If TRUE, retrieve the AnnotationHub metadata instead of the
#' object itself. Defaults to FALSE.
#'
#' @examplesIf interactive()
#' ENCODE_PLS_regions()
#'
#' @export
#'
#' @return A GRanges object with 40,734 ranges and no metadata.
#'
#' @source{
#'     \url{https://screen.encodeproject.org}
#' }
ENCODE_PLS_regions <- function(metadata = FALSE) {
    ah <- AnnotationHub::AnnotationHub()
    if (metadata) {
        return(ah["AH116729", verbose = FALSE])
    } else {
        return(ah[["AH116729", verbose = FALSE]])
    }
}

#' @title TENET 10 cancer panel enhancer regions
#'
#' @description A composite GRanges object containing regions of putative
#' enhancer elements from 10 different cancer types (BRCA, BLCA, COAD, ESCA,
#' HNSC, KIRP, LIHC, LUAD, LUSC, and THCA) primarily for use in the TENET
#' Bioconductor package. This dataset is composed of H3K27ac and H3K4me1 peaks
#' from ChIP-seq datasets collected from Cistrome.org and processed using the
#' ENCODE pipelines. For additional information on component datasets, see the
#' manifest file hosted at
#' <https://github.com/rhielab/TENET.AnnotationHub/blob/devel/data-raw/TENET_10_cancer_panel_enhancer_regions_manifest.tsv>.
#'
#' @param metadata If TRUE, retrieve the AnnotationHub metadata instead of the
#' object itself. Defaults to FALSE.
#'
#' @examplesIf interactive()
#' TENET_10_cancer_panel_enhancer_regions()
#'
#' @export
#'
#' @return A GRanges object with 4,798,784 non-reduced ranges and metadata
#' consisting of 1 variable. The peaks within each cancer type are reduced, but
#' the final dataset with peaks across all 10 cancer types is not reduced.
#' \describe{
#'   \item{\code{TYPE}}{(character) Lists which of the ten cancer types (BLCA, BRCA, COAD, ESCA, HNSC, KIRP, LIHC, LUAD, LUSC, or THCA) each region is relevant to}
#' }
TENET_10_cancer_panel_enhancer_regions <- function(metadata = FALSE) {
    ah <- AnnotationHub::AnnotationHub()
    if (metadata) {
        return(ah["AH116721", verbose = FALSE])
    } else {
        return(ah[["AH116721", verbose = FALSE]])
    }
}

#' @title TENET 10 cancer panel open chromatin regions
#'
#' @description A composite GRanges object containing regions of open chromatin
#' from 10 different cancer types (BRCA, BLCA, COAD, ESCA, HNSC, KIRP, LIHC,
#' LUAD, LUSC, and THCA) primarily for use in the TENET Bioconductor package.
#' This dataset is composed of peaks from DNase I and ATAC-seq datasets
#' collected from Cistrome.org and processed using the ENCODE guidelines, along
#' with additional TCGA ATAC-seq peaks from cancer samples of these ten types.
#' For additional information on component datasets, see the manifest file
#' hosted at
#' <https://github.com/rhielab/TENET.AnnotationHub/blob/devel/data-raw/TENET_10_cancer_panel_open_chromatin_regions_manifest.tsv>.
#'
#' @param metadata If TRUE, retrieve the AnnotationHub metadata instead of the
#' object itself. Defaults to FALSE.
#'
#' @examplesIf interactive()
#' TENET_10_cancer_panel_open_chromatin_regions()
#'
#' @export
#'
#' @return A GRanges object with 7,514,441 non-reduced ranges and metadata
#' consisting of 1 variable. The peaks within each cancer type are reduced, but
#' the final dataset with peaks across all 10 cancer types is not reduced.
#' \describe{
#'   \item{\code{TYPE}}{(character) Lists which of the ten cancer types (BLCA, BRCA, COAD, ESCA, HNSC, KIRP, LIHC, LUAD, LUSC, or THCA) each region is relevant to}
#' }
TENET_10_cancer_panel_open_chromatin_regions <- function(metadata = FALSE) {
    ah <- AnnotationHub::AnnotationHub()
    if (metadata) {
        return(ah["AH116722", verbose = FALSE])
    } else {
        return(ah[["AH116722", verbose = FALSE]])
    }
}

#' @title TENET 10 cancer panel promoter regions
#'
#' @description A composite GRanges object containing regions of putative
#' promoter elements from 10 different cancer types (BRCA, BLCA, COAD, ESCA,
#' HNSC, KIRP, LIHC, LUAD, LUSC, and THCA) primarily for use in the TENET
#' Bioconductor package. This dataset is composed of H3K27me3 peaks from
#' ChIP-seq datasets collected from Cistrome.org and processed using the ENCODE
#' guidelines. For additional information on component datasets, see the
#' manifest file hosted at
#' <https://github.com/rhielab/TENET.AnnotationHub/blob/devel/data-raw/TENET_10_cancer_panel_promoter_regions_manifest.tsv>.
#'
#' @param metadata If TRUE, retrieve the AnnotationHub metadata instead of the
#' object itself. Defaults to FALSE.
#'
#' @examplesIf interactive()
#' TENET_10_cancer_panel_promoter_regions()
#'
#' @export
#'
#' @return A GRanges object with 2,627,647 non-reduced ranges and metadata
#' consisting of 1 variable. The peaks within each cancer type are reduced, but
#' the final dataset with peaks across all 10 cancer types is not reduced.
#' \describe{
#'   \item{\code{TYPE}}{(character) Lists which of the ten cancer types (BLCA, BRCA, COAD, ESCA, HNSC, KIRP, LIHC, LUAD, LUSC, or THCA) each region is relevant to}
#' }
TENET_10_cancer_panel_promoter_regions <- function(metadata = FALSE) {
    ah <- AnnotationHub::AnnotationHub()
    if (metadata) {
        return(ah["AH116723", verbose = FALSE])
    } else {
        return(ah[["AH116723", verbose = FALSE]])
    }
}

#' @title TENET consensus enhancer regions
#'
#' @description A composite GRanges object containing regions of putative
#' enhancer elements from a variety of sources, primarily for use in the TENET
#' Bioconductor package. This dataset is composed of regions of strong enhancers
#' as annotated by the Roadmap Epigenomics ChromHMM expanded 18-state model
#' based on 98 reference epigenomes, lifted over to the hg38 genome (the
#' following 4 states represent strong enhancers: 7: Genic enhancer1, 8: Genic
#' enhancer2, 9: Active Enhancer 1, and 10: Active Enhancer 2), as well as
#' regions of human permissive enhancers identified by the FANTOM5 project in
#' phase 1 and phase 2. For additional information on component datasets, see
#' the manifest file hosted at
#' <https://github.com/rhielab/TENET.AnnotationHub/blob/devel/data-raw/TENET_consensus_datasets_manifest.tsv>.
#' **Citations:** Roadmap Epigenomics Consortium; Kundaje A, Meuleman W,
#' Ernst J, et al. Integrative analysis of 111 reference human epigenomes.
#' Nature. 2015 Feb 19;518(7539):317-30. doi: 10.1038/nature14248. PMID:
#' 25693563; PMCID: PMC4530010. Lizio M, Harshbarger J, Shimoji H, et al.
#' Gateways to the FANTOM5 promoter level mammalian expression atlas. Genome
#' Biol 16(1), 22 (2015). Abugessaisa I, Ramilowski JA, Lizio M, et al. FANTOM
#' enters 20th year: expansion of transcriptomic atlases and functional
#' annotation of non-coding RNAs. Nucleic Acids Res. 2021 Jan
#' 8;49(D1):D892-D898. doi: 10.1093/nar/gkaa1054. PMID: 33211864; PMCID:
#' PMC7779024.
#'
#' @param metadata If TRUE, retrieve the AnnotationHub metadata instead of the
#' object itself. Defaults to FALSE.
#'
#' @examplesIf interactive()
#' TENET_consensus_enhancer_regions()
#'
#' @export
#'
#' @return A GRanges object with 403,602 ranges and no metadata.
#'
#' @source{
#'   \url{https://egg2.wustl.edu/roadmap/web_portal/chr_state_learning.html}
#'   \cr
#'   \url{https://fantom.gsc.riken.jp/5/data/}
#' }
TENET_consensus_enhancer_regions <- function(metadata = FALSE) {
    ah <- AnnotationHub::AnnotationHub()
    if (metadata) {
        return(ah["AH116724", verbose = FALSE])
    } else {
        return(ah[["AH116724", verbose = FALSE]])
    }
}

#' @title TENET consensus open chromatin regions
#'
#' @description A composite GRanges object containing regions of open chromatin
#' from a variety of sources, primarily for use in the TENET Bioconductor
#' package. This dataset is composed of DNase I hypersensitive regions from the
#' master list compiled from 125 cell types by ENCODE, lifted over to the hg38
#' genome, along with TCGA ATAC-seq peaks from 410 cancer samples of 23 cancer
#' types. For additional information on component datasets, see the manifest
#' file hosted at
#' <https://github.com/rhielab/TENET.AnnotationHub/blob/devel/data-raw/TENET_consensus_datasets_manifest.tsv>.
#' **Citations:** ENCODE Project Consortium. An
#' integrated encyclopedia of DNA elements in the human genome. Nature. 2012 Sep
#' 6;489(7414):57-74. doi: 10.1038/nature11247. PMID: 22955616; PMCID:
#' PMC3439153. Thurman RE, Rynes E, Humbert R, et al. The accessible chromatin
#' landscape of the human genome. Nature. 2012 Sep 6;489(7414):75-82. doi:
#' 10.1038/nature11232. PMID: 22955617; PMCID: PMC3721348. Corces MR, Granja JM,
#' Shams S, et al. The chromatin accessibility landscape of primary human
#' cancers. Science. 2018 Oct 26;362(6413):eaav1898. doi:
#' 10.1126/science.aav1898. PMID: 30361341; PMCID: PMC6408149.
#'
#' @param metadata If TRUE, retrieve the AnnotationHub metadata instead of the
#' object itself. Defaults to FALSE.
#'
#' @examplesIf interactive()
#' TENET_consensus_open_chromatin_regions()
#'
#' @export
#'
#' @return A GRanges object with 2,525,827 ranges and no metadata.
#'
#' @source{
#'   \url{https://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeAwgDnaseMasterSites/}
#'   \cr
#'   \url{https://genome.ucsc.edu/cgi-bin/hgTrackUi?db=hg19&g=wgEncodeAwgDnaseMasterSites}
#'   \cr
#'   \url{https://gdc.cancer.gov/about-data/publications/ATACseq-AWG}
#' }
TENET_consensus_open_chromatin_regions <- function(metadata = FALSE) {
    ah <- AnnotationHub::AnnotationHub()
    if (metadata) {
        return(ah["AH116725", verbose = FALSE])
    } else {
        return(ah[["AH116725", verbose = FALSE]])
    }
}

#' @title TENET consensus promoter regions
#'
#' @description A composite GRanges object containing regions of putative
#' promoter elements from a variety of sources, primarily for use in the TENET
#' Bioconductor package. This dataset is composed of regions flanking
#' transcription start sites as annotated by the Roadmap Epigenomics ChromHMM
#' expanded 18-state model based on 98 reference epigenomes, lifted over to the
#' hg38 genome (the following 4 states represent regions flanking transcription
#' start sites: 1: Active TSS, 2: Flanking TSS, 3: Flanking TSS Upstream, and
#' 4: Flanking TSS Downstream). For additional information on component
#' datasets, see the manifest file hosted at
#' <https://github.com/rhielab/TENET.AnnotationHub/blob/devel/data-raw/TENET_consensus_datasets_manifest.tsv>.
#' **Citation:** Roadmap Epigenomics Consortium;
#' Kundaje A, Meuleman W, Ernst J, et al. Integrative analysis of 111 reference
#' human epigenomes. Nature. 2015 Feb 19;518(7539):317-30. doi:
#' 10.1038/nature14248. PMID: 25693563; PMCID: PMC4530010.
#'
#' @param metadata If TRUE, retrieve the AnnotationHub metadata instead of the
#' object itself. Defaults to FALSE.
#'
#' @examplesIf interactive()
#' TENET_consensus_promoter_regions()
#'
#' @export
#'
#' @return A GRanges object with 361,315 ranges and no metadata.
#'
#' @source{
#'     \url{https://egg2.wustl.edu/roadmap/web_portal/chr_state_learning.html}
#' }
TENET_consensus_promoter_regions <- function(metadata = FALSE) {
    ah <- AnnotationHub::AnnotationHub()
    if (metadata) {
        return(ah["AH116726", verbose = FALSE])
    } else {
        return(ah[["AH116726", verbose = FALSE]])
    }
}
