### Necessary packages to create datasets

## BiocManager is required to install GenomicRanges and rtracklayer
if (!require("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

## GenomicRanges is required to assemble the datasets
if (!require("GenomicRanges", quietly = TRUE)) {
    BiocManager::install("GenomicRanges")
}

## GenomeInfoDb is required to remove nonstandard chromosomes
if (!require("GenomeInfoDb", quietly = TRUE)) {
    BiocManager::install("GenomeInfoDb")
}

## rtracklayer is required to do liftover for some datasets
if (!require("rtracklayer", quietly = TRUE)) {
    BiocManager::install("rtracklayer")
}

## R.utils is required to uncompress .gz files
if (!require("R.utils", quietly = TRUE)) {
    install.packages("R.utils")
}

### Dataset descriptions

## TENET_10_cancer_panel datasets
## (TENET_10_cancer_panel_enhancer_regions,
## TENET_10_cancer_panel_open_chromatin_regions,
## TENET_10_cancer_panel_promoter_regions)

## Component datasets were first identified using the Cistrome Data Browser v2.0
## (http://cistrome.org/db/). Homo sapiens was selected as the species, while
## H3K4me1 and H3K27ac (for enhancers), H3K4me3 (for promoters), or ATAC-seq and
## DNase-seq (for open chromatin) were selected as factors of interest. For each
## of 10 cancer types (BLCA, BRCA, COAD, ESCA, HNSC, KIRP, LIHC, LUAD, LUSC, and
## THCA; see https://gdc.cancer.gov/resources-tcga-users/tcga-code-tables/tcga-study-abbreviations),
## an initial search was performed using the organ each cancer type arose from
## as the search term.

## First, we removed datasets which were derived from biological sources which
## were not directly relevant to the cancer type of interest (e.g. lung
## fibroblasts and A549 cells, a LUAD cell line, from the LUSC relevant
## dataset). We also removed datasets which failed at least three of the six
## quality control metrics recorded by Cistrome (sequence quality, mapping
## quality, library complexity, ChIP enrichment, signal to noise ratio, and
## regulatory region ratio). Samples that had a chemical, siRNA, or genetic
## alteration performed on them were also removed, though we elected to keep
## samples which had mild control treatments (e.g., EtOH or vehicle control)
## applied to them. Finally, we removed samples with fewer than 10 million
## reads, as well as as any samples for which we were unable to acquire the
## FASTQ files to perform peak calling.

## Peak calling was performed using the ENCODE ChIP-seq pipeline
## (https://github.com/ENCODE-DCC/chip-seq-pipeline) for H3K4me1, H3K4me3, and
## H3K27ac datasets, and the ENCODE ATAC-seq pipeline
## (https://github.com/ENCODE-DCC/atac-seq-pipeline) for ATAC-seq and DNase-seq
## datasets. All datasets were aligned to the hg38 human genome.

## After peaks had been called, we performed a second round of curation, where
## we removed datasets with fewer than 10,000 called peaks. Finally, for each
## combination of biological source and data type (i.e. MCF7 cells and H3K27ac),
## we collected all datasets that passed other curation criteria, then kept all
## datasets tied for the most Cistrome quality control metrics passed and
## removed datasets which had fewer. Experimental replicates were considered as
## individual datasets, though input replicates from those experiments were
## pooled into single datasets for use in peak calling.

## The enhancer and promoter datasets use only these peak files, while the open
## chromatin dataset also includes ATAC-seq peaks from TCGA for the 10 cancer
## types of interest (see: https://www.science.org/doi/10.1126/science.aav1898).

## The raw .bed.gz and .narrowPeak.gz files we downloaded/processed,
## respectively, are available in a separate TENET.AnnotationHub_files
## repository at https://github.com/rhielab/TENET.AnnotationHub_files. Manifests
## for these files detailing, among other information, the ENCODE/GEO
## experiments where the files originate, are available as .tsv files in the
## data-raw subdirectory of this repository and in the TENET.AnnotationHub_files
## repository.

## TENET_consensus datasets
## (TENET_consensus_enhancer_regions,
## TENET_consensus_open_chromatin_regions,
## TENET_consensus_promoter_regions)

## TENET consensus datasets are GRanges objects containing regions representing
## potential enhancer, open chromatin, or promoter regions from a broad variety
## of sources.

## The TENET_consensus_enhancer_regions dataset is composed of ChromHMM
## annotated enhancer regions, as well as FANTOM5 enhancers. The
## TENET_consensus_open_chromatin_regions dataset is composed of peaks from the
## ENCODE DNaseI Hypersensitive Site Master List (lifted over from hg19 to
## hg38), along with ATAC-seq peaks from TCGA from all 23 cancer types
## available. The TENET_consensus_promoter_regions dataset is composed of
## ChromHMM annotated promoter regions.

## ENCODE cCRE regions datasets
## (ENCODE_dELS_regions, ENCODE_pELS_regions, ENCODE_PLS_regions)

## These datasets are composed of human candidate cis-regulatory elements
## (cCREs) identified by the ENCODE Registry of cCREs project, and acquired from
## their website. These include cCREs with promoter-like signatures (PLS), which
## fall within 200 bp of annnotated GENCODE transcription start sites (TSS) and
## have high DNase and H3K4me3 signals, and cCREs with enhancer-like signatures,
## which have high DNase and H3K27ac signals and low H3K4me3 signal. ELS cCREs
## are split between those elements within 2kb of an annotated TSS, called
## proximal ELS (pELS), and those further than 2kb from an annotated TSS, called
## distal ELS (dELS).

## These regions are separate from other datasets, since they represent regions
## with overlapping regulatory element marks and open chromatin, so they are
## used slightly differently in our prospective package.

### Code to prepare datasets

## First, we will need to create a "data" subdirectory if one doesn't already
## exist. This is because the AzureStor package functions, which will be used
## to upload these datasets to the Bioconductor Data Lake, look for the .Rda
## objects in the data subdirectory.
if(!dir.exists("data")) {
    dir.create("data")
}

## Code to prepare the `TENET_10_cancer_panel_enhancer_regions`,
## `TENET_10_cancer_panel_promoter_regions`, and
## `TENET_10_cancer_panel_open_chromatin_regions` datasets

## For each dataset, peaks from files (and the TCGA ATAC-seq dataset for the
## open_chromatin_regions dataset) from a given cancer type are loaded, combined
## and reduced, then combined with similarly combined and reduced peaks from the
## other cancer types, with an added metadata column noting which cancer type
## each peak was derived from.

## Define a variable for the directory containing the processed HM/NDR files.
## These files are available in a separate repository at
## https://github.com/rhielab/TENET.AnnotationHub_files but are not currently
## present in the package due to size (>1.5 GB in total). The predefined path
## assumes that a copy of the TENET.AnnotationHub_files repository is present
## in the parent directory of the directory containing the source code of the
## TENET.AnnotationHub package.
directory_with_peaks <- "../TENET.AnnotationHub_files"

## Define a vector of the cancers in the panel
cancers <- c(
    "BLCA", "BRCA", "COAD", "ESCA", "HNSC",
    "KIRP", "LIHC", "LUAD", "LUSC", "THCA"
)

## Load the TCGA ATAC-seq data for use when creating the open_chromatin dataset.
## Data are already annotated to hg38 according to aav1898_corces_sm.pdf
## under "Resources" at
## https://www.science.org/doi/10.1126/science.aav1898
## Direct link:
## https://www.science.org/doi/suppl/10.1126/science.aav1898/suppl_file/aav1898_corces_sm.pdf

## Define the TCGA ATAC-seq peak file URL. This is the "Pan-cancer peak set"
TCGA_ATAC_seq_peaks_url <- "https://api.gdc.cancer.gov/data/116ebba2-d284-485b-9121-faf73ce0a4ec"

## Load the file.
## It is indeed 0-indexed, despite the start and end being 501 apart; the
## authors state that they added 250bp to each side of the peaks, which were of
## width 1 to begin with, resulting in a width of 501bp.
TCGA_ATAC_seq_peaks_df <- utils::read.delim(
    url(TCGA_ATAC_seq_peaks_url),
    header = TRUE,
    sep = "\t",
    stringsAsFactors = FALSE
)

## Keep only the chromosome, start, end, and name columns
TCGA_ATAC_seq_peaks_df <- TCGA_ATAC_seq_peaks_df[seq_len(4)]

for (type in c("Enhancer", "Promoter", "Open_chromatin")) {
    ## Create an empty list to store reduced GRanges objects from each cancer
    ## type
    gr_reduced_list <- list()

    for (j in cancers) {
        ## List files for the given cancer and dataset type
        files <- list.files(
            file.path(
                directory_with_peaks,
                type,
                j
            ),
            pattern = "\\.(bed|(narrow|broad|gapped)Peak)(\\.gz)?$",
            ignore.case = TRUE,
            full.names = TRUE
        )

        ## Generate a list of data frames for each .bed file, keeping only the
        ## chromosome, start, and end columns, adding source and strand columns,
        ## and changing the column names so they can be recognized by
        ## GenomicRanges
        bed_list <- lapply(files, function(x) {
            dat <- read.table(x)
            dat <- subset(dat, select = c(1, 2, 3))
            dat$SOURCE <- basename(x)
            colnames(dat) <- c("chr", "start", "end", "SOURCE")
            return(dat)
        })

        ## If the open chromatin dataset is being created, add in the data from
        ## TCGA_ATAC_seq_peaks_df for the cancer type
        if(type == "Open_chromatin") {
            ## Get data for just the cancer type of interest
            TCGA_sub_NDR <- TCGA_ATAC_seq_peaks_df[
                grep(paste0("^", j, "_"), TCGA_ATAC_seq_peaks_df$name),
            ]

            ## Add a source column
            TCGA_sub_NDR$SOURCE <- paste0("TCGA-ATAC-", j)

            ## Remove the now unneeded name column
            TCGA_sub_NDR$name <- NULL

            ## Change the column names so they can be recognized by
            ## GenomicRanges and harmonized with other peak data
            colnames(TCGA_sub_NDR) <- c("chr", "start", "end", "SOURCE")

            ## Add the ATAC-seq peaks to bed_list
            bed_list[[length(bed_list) + 1]] <- TCGA_sub_NDR
        }

        ## Combine the data frames in the list into a single data frame for that
        ## cancer type
        merged_bed <- Reduce(rbind, bed_list)

        if (!is.null(merged_bed)) {
            ## Convert the combined data frame into a GRanges object if it has
            ## data
            gr_merged_meta <- GenomicRanges::makeGRangesFromDataFrame(
                df = merged_bed,
                keep.extra.columns = TRUE,
                starts.in.df.are.0based = TRUE
            )

            ## Note: Component sample files include various nonstandard
            ## chromosome contigs and scaffolds, so we remove those to prevent a
            ## warning message later while merging datasets from different
            ## cancer types, as these regions won't be relevant for TENET
            ## analyses.
            gr_merged_meta <- GenomeInfoDb::keepStandardChromosomes(
                gr_merged_meta, pruning.mode = "coarse"
            )

            ## Reduce the GRanges object for the individual cancer type
            gr_reduced <- GenomicRanges::reduce(gr_merged_meta)

            ## Add the cancer type as a metadata column
            GenomicRanges::mcols(gr_reduced)$TYPE <- j

            ## Add the reduced object to gr_reduced_list
            gr_reduced_list[[length(gr_reduced_list) + 1]] <- gr_reduced
        }
    }

    ## Combine all reduced GRanges objects.
    ## Note: We are not reducing the combined object because we want regions
    ## that overlap *between* cancer types to stay separate.
    public_regions <- unique(unlist(as(gr_reduced_list, "GRangesList")))

    var_name <- paste0("TENET_10_cancer_panel_", tolower(type), "_regions")

    ## Save the dataset. assign() is used because save() embeds the variable
    ## name into the .rda file, and the variable will assume that name when
    ## loaded, even if the file has a different name.
    assign(var_name, public_regions)

    ## Save the object
    save(
        list = var_name,
        file = file.path("data", paste0(var_name, ".Rda"))
    )
}

## Code to prepare the `TENET_consensus_enhancer_regions` and
## `TENET_consensus_promoter_regions` datasets

## For each dataset, 18-state ChromHMM annotations which are already lifted over
## to the hg38 genome are acquired from the Roadmap Epigenomics Consortium's
## website for all 98 epigenomes which were analyzed. For each dataset, either
## peaks for the 4 descriptions representing strong enhancers (7: Genic
## enhancer1, 8: Genic enhancer2, 9: Active Enhancer 1, and 10: Active Enhancer
## 2) or transcription start sites (1: Active TSS, 2: Flanking TSS, 3: Flanking
## TSS Upstream, and 4: Flanking TSS Downstream), respectively, are kept.
## Additionally, for the consensus_enhancer_regions dataset, FANTOM5 annotated
## human permissive enhancer regions, which are downloaded from their site and
## then lifted over to the hg38 genome here, are added to the ChromHMM annotated
## regions. For each dataset, the final peaks are reduced and saved as GRanges
## objects. More info on this dataset can be seen here:
## https://egg2.wustl.edu/roadmap/web_portal/chr_state_learning.html

## First, get ChromHMM annotations from the Roadmap site. For this we are using
## the files from the 18-state model which are already lifted over to the hg38
## genome, and we are using data from all 98 epigenomes analyzed.

## Define the URL containing the mnemonics files with hg38 liftover
## for ChromHMM annotations (and other files not wanted)
directory_url <- "https://egg2.wustl.edu/roadmap/data/byFileType/chromhmmSegmentations/ChmmModels/core_K27ac/jointModel/final/bed_hg38_lifted_over/"

## Read the HTML directory listing from the URL
read_lines <- readLines(directory_url)

## Get the lines of HTML code containing the annotations we want
read_lines_mnemonics <- grep("mnemonics", read_lines, value = TRUE)

## Extract the file names from the HTML code
read_lines_mnemonics <- sub(".*href=\"", "", read_lines_mnemonics)
read_lines_mnemonics <- sub('\">.*', "", read_lines_mnemonics)

## Create complete URLs to each of the mnemonics files
mnemonics_urls <- paste0(directory_url, read_lines_mnemonics)

## Define the types of ChromHMM annotations we are interested in.
## See https://egg2.wustl.edu/roadmap/web_portal/chr_state_learning.html
chromHMM_of_interest_enh <- c("7_EnhG1", "8_EnhG2", "9_EnhA1", "10_EnhA2")
chromHMM_of_interest_pro <- c("1_TssA", "2_TssFlnk", "3_TssFlnkU", "4_TssFlnkD")

## Create data frames to store peaks of interest
peaks_df_enh <- NULL
peaks_df_pro <- NULL

## Load each of the mnemonics .bed files and add them to the data frames
for (i in mnemonics_urls) {
    ## Load the .bed file
    raw_bed_df <- utils::read.delim(
        gzcon(url(i), text = TRUE),
        header = FALSE,
        stringsAsFactors = FALSE
    )

    ## Get just the regions that correspond to the annotations of interest
    ## and combine those regions with the existing data frames
    peaks_df_enh <- rbind(
        peaks_df_enh,
        raw_bed_df[
            raw_bed_df$V4 %in% chromHMM_of_interest_enh,
        ]
    )

    peaks_df_pro <- rbind(
        peaks_df_pro,
        raw_bed_df[
            raw_bed_df$V4 %in% chromHMM_of_interest_pro,
        ]
    )
}

## Remove the column with the enhancer info from the final data frames and add
## a dummy strand column in its place
peaks_df_enh$V4 <- rep("*", nrow(peaks_df_enh))
peaks_df_pro$V4 <- rep("*", nrow(peaks_df_pro))

## Change the column names so they can be recognized by GenomicRanges
colnames(peaks_df_enh) <- c("chr", "start", "end", "strand")
colnames(peaks_df_pro) <- c("chr", "start", "end", "strand")

## Convert the data frames into GRanges objects with the final dataset names.
## Since these are .bed files, they are 0-indexed.
TENET_consensus_enhancer_regions <- GenomicRanges::makeGRangesFromDataFrame(
    df = peaks_df_enh,
    keep.extra.columns = FALSE,
    starts.in.df.are.0based = TRUE
)

TENET_consensus_promoter_regions <- GenomicRanges::makeGRangesFromDataFrame(
    df = peaks_df_pro,
    keep.extra.columns = FALSE,
    starts.in.df.are.0based = TRUE
)

## Get the FANTOM5 enhancer regions for the hg38 genome from the FANTOM5
## website. The annotatr package also has these exact same regions, but it
## requires a local download of the dataset, and keeping this code in place
## ensures we know the exact day files are accessed. However, files on the
## website are annotated to the hg19 genome, so we will need to lift them over
## here. More on this dataset can be seen at: https://fantom.gsc.riken.jp/5/

## Define the URL containing the gzipped .bed file with the FANTOM5 enhancer
## dataset for phase 1 and 2
human_permissive_enhancers_directory_url <- "https://fantom.gsc.riken.jp/5/datafiles/latest/extra/Enhancers/human_permissive_enhancers_phase_1_and_2.bed.gz"

## Load the .bed file from the URL
hg19_human_permissive_enhancers_df <- utils::read.delim(
    gzcon(url(human_permissive_enhancers_directory_url), text = TRUE),
    header = FALSE,
    stringsAsFactors = FALSE
)

## Keep only the chromosome, start, and end columns
hg19_human_permissive_enhancers_df <- hg19_human_permissive_enhancers_df[
    seq_len(3)
]

## Change the column names so they can be recognized by GenomicRanges
colnames(hg19_human_permissive_enhancers_df) <- c("chr", "start", "end")

## Convert the data frame into a GRanges object
hg19_human_permissive_enhancers_GRanges <-
    GenomicRanges::makeGRangesFromDataFrame(
        df = hg19_human_permissive_enhancers_df,
        keep.extra.columns = FALSE,
        starts.in.df.are.0based = TRUE
    )

## Download the hg19 to hg38 chain to the current directory.
## rtracklayer::import.chain can't handle compressed files or URLs directly.
download.file(
    "https://hgdownload.cse.ucsc.edu/goldenPath/hg19/liftOver/hg19ToHg38.over.chain.gz",
    "hg19.hg38.chain.gz"
)

## Uncompress the chain file. If it already exists, it needs to be removed so
## that gunzip does not fail.
if (file.exists("hg19.hg38.chain")) {
    file.remove("hg19.hg38.chain")
}
R.utils::gunzip("hg19.hg38.chain.gz")

## Import the chain file
hg19_to_hg38_chain <- rtracklayer::import.chain("hg19.hg38.chain")

## Remove the downloaded chain file
file.remove("hg19.hg38.chain")

## Perform the liftover of the enhancer peaks to hg38
hg38_human_permissive_enhancers_GRanges <- rtracklayer::liftOver(
    hg19_human_permissive_enhancers_GRanges,
    hg19_to_hg38_chain
)

## Convert the GRanges list object into a normal GRanges object
hg38_human_permissive_enhancers_GRanges <- unlist(
    hg38_human_permissive_enhancers_GRanges
)

## Combine the regions from ChromHMM predicted enhancers with the FANTOM5
## enhancer regions
TENET_consensus_enhancer_regions <- c(
    TENET_consensus_enhancer_regions,
    hg38_human_permissive_enhancers_GRanges
)

## Reduce the ranges in the GRanges objects
TENET_consensus_enhancer_regions <- GenomicRanges::reduce(
    TENET_consensus_enhancer_regions
)
TENET_consensus_promoter_regions <- GenomicRanges::reduce(
    TENET_consensus_promoter_regions
)

## Save the datasets
save(
    list = "TENET_consensus_enhancer_regions",
    file = "data/TENET_consensus_enhancer_regions.Rda"
)

save(
    list = "TENET_consensus_promoter_regions",
    file = "data/TENET_consensus_promoter_regions.Rda"
)

## Code to prepare the `TENET_consensus_open_chromatin_regions` dataset

## This dataset consists of DNase I hypersensitive sites from 125 different
## human tissues/cell lines compiled by the ENCODE Consortium, which are lifted
## over from hg19 to hg38 here, along with ATAC-seq peaks collected from 410
## tumor samples from 23 cancer types by TCGA (this is the same dataset used
## for TENET_10_cancer_panel_open_chromatin_regions, except all available data
## are used here, as this dataset includes broad open chromatin regions as
## opposed to those of the ten cancer types specifically).

## Acquire the .bed file for the hg19 DNaseI Hypersensitive Site Master List
## (125 cell types) from the ENCODE Analysis Working Group.
## https://genome.ucsc.edu/cgi-bin/hgTrackUi?db=hg19&g=wgEncodeAwgDnaseMasterSites

## Define the URL of interest containing the DNase I hypersensitive sites
DNaseI_file_url <- "https://hgdownload.soe.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeAwgDnaseMasterSites/wgEncodeAwgDnaseMasterSites.bed.gz"

## Load the DNase I hypersensitive sites .bed file
hg19_DNase_I_hypersensitive_sites_df <- utils::read.table(
    gzcon(url(DNaseI_file_url), text = TRUE),
    sep = "\t",
    header = FALSE,
    stringsAsFactors = FALSE,
    skipNul = TRUE,
    fill = TRUE
)

## Keep only the chromosome, start, and end columns
hg19_DNase_I_hypersensitive_sites_df <- hg19_DNase_I_hypersensitive_sites_df[
    seq_len(3)
]

## Change the column names so they can be recognized by GenomicRanges
colnames(hg19_DNase_I_hypersensitive_sites_df) <- c("chr", "start", "end")

## Convert the data frame into a GRanges object
hg19_DNase_I_hypersensitive_sites_GRanges <-
    GenomicRanges::makeGRangesFromDataFrame(
        df = hg19_DNase_I_hypersensitive_sites_df,
        keep.extra.columns = FALSE,
        starts.in.df.are.0based = TRUE
    )

## Perform the liftover of the open chromatin peaks to hg38 using the chain
## imported above
hg38_DNase_I_hypersensitive_sites_GRanges <- rtracklayer::liftOver(
    hg19_DNase_I_hypersensitive_sites_GRanges,
    hg19_to_hg38_chain
)

## Convert the GRanges list object into a normal GRanges object
hg38_DNase_I_hypersensitive_sites_GRanges <- unlist(
    hg38_DNase_I_hypersensitive_sites_GRanges
)

## Add data from the TCGA ATAC-seq datasets from 410 tumor samples spanning 23
## cancer types

## This dataset is loaded earlier from the creation of the
## TENET_10_cancer_panel_open_chromatin_regions dataset, so we can work using
## the TCGA_ATAC_seq_peaks_df object

## To recap, data are already annotated to hg38 according to
## aav1898_corces_sm.pdf under "Resources" at
## https://www.science.org/doi/10.1126/science.aav1898
## Direct link: https://www.science.org/doi/suppl/10.1126/science.aav1898/suppl_file/aav1898_corces_sm.pdf

## Convert the TCGA ATAC-seq peaks from all 23 cancer types into into a GRanges
## object.
## This dataset is indeed 0-indexed, despite the start and end being 501 apart;
## the authors state that they added 250bp to each side of the peaks, which were
## of width 1 to begin with, resulting in a width of 501bp.
TCGA_ATAC_seq_peaks_GRanges <- GenomicRanges::makeGRangesFromDataFrame(
    df = TCGA_ATAC_seq_peaks_df,
    keep.extra.columns = FALSE,
    starts.in.df.are.0based = TRUE
)

## Combine the regions from the ENCODE DNase I hypersensitive sites with the
## TCGA ATAC-seq peaks to form the final dataset
TENET_consensus_open_chromatin_regions <- c(
    hg38_DNase_I_hypersensitive_sites_GRanges,
    TCGA_ATAC_seq_peaks_GRanges
)

## Reduce the ranges in the GRanges object
TENET_consensus_open_chromatin_regions <- GenomicRanges::reduce(
    TENET_consensus_open_chromatin_regions
)

## Save the dataset
save(
    list = "TENET_consensus_open_chromatin_regions",
    file = "data/TENET_consensus_open_chromatin_regions.Rda"
)

## Code to prepare the `ENCODE_dELS_regions`, `ENCODE_pELS_regions`, and
## `ENCODE_PLS_regions` datasets

## For each dataset type, download the V3 GRCh38 human genome regions from the
## ENCODE Registry of cCREs website https://screen.encodeproject.org/, convert
## them into GRanges objects, and reduce the regions before saving the final
## datasets.

for (type in c("PLS", "pELS", "dELS")) {
    ## Define the name of the variable to save
    var_name <- paste0("ENCODE_", type, "_regions")

    ## Define the URL for the appropriate .bed file
    ## (from https://screen.encodeproject.org, click "Detailed Elements")
    file_url <- paste0(
        "https://downloads.wenglab.org/Registry-V3/GRCh38-cCREs.", type, ".bed"
    )

    ## Load the .bed file as a data frame
    ENCODE_cCRE_regions <- utils::read.table(
        url(file_url),
        sep = "\t",
        header = FALSE,
        stringsAsFactors = FALSE
    )

    ## Keep only the chromosome, start, and end columns
    ENCODE_cCRE_regions <- ENCODE_cCRE_regions[seq_len(3)]

    ## Change the column names so they can be recognized by GenomicRanges
    colnames(ENCODE_cCRE_regions) <- c("chr", "start", "end")

    ## Convert the data frame into a GRanges object
    ENCODE_cCRE_regions <- GenomicRanges::makeGRangesFromDataFrame(
        df = ENCODE_cCRE_regions,
        keep.extra.columns = FALSE,
        starts.in.df.are.0based = TRUE
    )

    ## Reduce the regions
    ENCODE_cCRE_regions <- GenomicRanges::reduce(ENCODE_cCRE_regions)

    ## Save the dataset. assign() is used because save() embeds the variable
    ## name into the .rda file, and the variable will assume that name when
    ## loaded, even if the file has a different name.
    assign(var_name, ENCODE_cCRE_regions)

    ## Save the object
    save(
        list = var_name,
        file = file.path("data", paste0(var_name, ".Rda"))
    )
}
