# Prepare the internal datasets
#
# This function will create and save the datasets in the \code{R/systada.rda}
# file.
#
# param force If TRUE, the inst/extdata file will be created, even if it
#             exists. Default: \code{FALSE}.
#
# examples
#  prepare_internal_datasets
prepare_internal_datasets <- function(force = FALSE) {
  sysdata <- "R/sysdata.rda"
  exp_description <- data_fantom_exp_description(force = force)
  enhancers <- data_fantom_enhancers(force = force)
  devtools::use_data(exp_description, enhancers, internal = TRUE,
    overwrite = TRUE)
}

# Prepare the enhancers dataset
#
# This will download the Fantom's enhancers file and convert it into
# \code{GRanges} format The file will be downloaded in the \code{inst/extdata/}
# directory.
#
# Download url:
#  "http://fantom.gsc.riken.jp/5/datafiles/latest/extra/Enhancers/"
# Filename:
#  "human_permissive_enhancers_phase_1_and_2_expression_tpm_matrix.txt.gz"
#
# param force If TRUE, the inst/extdata file will be created, even if it
#             exists. Default: \code{FALSE}.
#
# return The \code{GRanges} produced.
#
# examples
# BiologicalInsights::data_fantom_enhancers()
data_fantom_enhancers <- function(force = FALSE) {
  data_fantom_exp_description()

  # Download enhancers
  filename <-
    "human_permissive_enhancers_phase_1_and_2_expression_tpm_matrix.txt.gz"
  url <- "http://fantom.gsc.riken.jp/5/datafiles/latest/extra/Enhancers/"
  url <- paste0(url, filename)
  filename <- paste0("inst/extdata/", filename)
  download_file(url, filename, force = force)

  # Import the enhancer file
  enhancers <- read.table(gzfile(filename), header = TRUE,
                          stringsAsFactors = FALSE)

  # Convert to GRanges
  df <- data.frame(do.call("rbind", strsplit(enhancers$Id, "[:-]")))
  colnames(df) <- c("seqnames", "start", "end")
  df[["start"]] <- as.numeric(as.character(df[["start"]]))
  df[["end"]] <- as.numeric(as.character(df[["end"]]))
  df[["strand"]] <- "*"
  df <- cbind(df, enhancers[,-1])
  GenomicRanges::makeGRangesFromDataFrame(df, keep.extra.columns = TRUE)
}

# Prepare the exp_description dataset
#
# This will download the Fantom's experiment description file and import it as
# a data.frame. The file will be downloaded in the \code{inst/extdata/}
# directory.
#
# Download url:
#  "http://fantom.gsc.riken.jp/5/datafiles/latest/basic/human.cell_line.hCAGE/"
# Filename:
#  "inst/extdata/00_human.cell_line.hCAGE.hg19.assay_sdrf.txt"
#
# param force If TRUE, the inst/extdata file will be created, even if it
#             exists. Default: \code{FALSE}.
#
# return The \code{data.frame} produced.
#
# examples
# BiologicalInsights::data_fantom_enhancers()
data_fantom_exp_description <- function(force = FALSE) {
  # Download TSS
  filename <- "00_human.cell_line.hCAGE.hg19.assay_sdrf.txt"
  url <-
    "http://fantom.gsc.riken.jp/5/datafiles/latest/basic/human.cell_line.hCAGE/"
  url <- paste0(url, filename)
  filename <- paste0("inst/extdata/", filename)
  download_file(url, filename, force = force)

  # Prepare the data.frame
  read.table(filename, header = TRUE, sep = "\t", quote = "",
             stringsAsFactors = FALSE)
}
