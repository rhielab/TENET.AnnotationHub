% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\name{TENET_consensus_enhancer_regions}
\alias{TENET_consensus_enhancer_regions}
\title{TENET consensus enhancer regions}
\source{
{
\url{https://egg2.wustl.edu/roadmap/web_portal/chr_state_learning.html}
\cr
\url{https://fantom.gsc.riken.jp/5/data/}
}
}
\usage{
TENET_consensus_enhancer_regions(metadata = FALSE)
}
\arguments{
\item{metadata}{If TRUE, retrieve the AnnotationHub metadata instead of the
object itself. Defaults to FALSE.}
}
\value{
A GRanges object with 403,602 ranges and no metadata.
}
\description{
A composite GRanges object containing regions of putative
enhancer elements from a variety of sources, primarily for use in the TENET
Bioconductor package. This dataset is composed of regions of strong enhancers
as annotated by the Roadmap Epigenomics ChromHMM expanded 18-state model
based on 98 reference epigenomes, lifted over to the hg38 genome (the
following 4 states represent strong enhancers: 7: Genic enhancer1, 8: Genic
enhancer2, 9: Active Enhancer 1, and 10: Active Enhancer 2), as well as
regions of human permissive enhancers identified by the FANTOM5 project in
phase 1 and phase 2. For additional information on component datasets, see
the manifest file hosted at
\url{https://github.com/rhielab/TENET.AnnotationHub/blob/devel/data-raw/TENET_consensus_datasets_manifest.tsv}.
\strong{Citations:} Roadmap Epigenomics Consortium; Kundaje A, Meuleman W,
Ernst J, et al. Integrative analysis of 111 reference human epigenomes.
Nature. 2015 Feb 19;518(7539):317-30. doi: 10.1038/nature14248. PMID:
25693563; PMCID: PMC4530010. Lizio M, Harshbarger J, Shimoji H, et al.
Gateways to the FANTOM5 promoter level mammalian expression atlas. Genome
Biol 16(1), 22 (2015). Abugessaisa I, Ramilowski JA, Lizio M, et al. FANTOM
enters 20th year: expansion of transcriptomic atlases and functional
annotation of non-coding RNAs. Nucleic Acids Res. 2021 Jan
8;49(D1):D892-D898. doi: 10.1093/nar/gkaa1054. PMID: 33211864; PMCID:
PMC7779024.
}
\examples{
\dontshow{if (interactive()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
TENET_consensus_enhancer_regions()
\dontshow{\}) # examplesIf}
}
