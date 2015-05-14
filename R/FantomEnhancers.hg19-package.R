#' FantomEnhancers.hg19
#'
#' @name FantomEnhancers.hg19
#' @docType package
NULL

# Description of Fantom's datasets
#
# A \code{data.frame} with the metadata of Fantom's dataset. Used to fetch IDs
# that match specific cell lines.
#
# Created with the \code{BiologicalInsights::data_fantom_exp_description}
# function.
#
# @format A \code{data.frame} with 25 columns and 266 rows.
# @source \url{ "http://fantom.gsc.riken.jp/5/datafiles/latest/basic/human.cell_line.hCAGE/00_human.cell_line.hCAGE.hg19.assay_sdrf.txt"}
#
# @name exp_description
NULL

# List of Fantom's enhancers
#
# A \code{GRanges} with the TPM value for each IDs.
#
# Created with the \code{BiologicalInsights::data_fantom_enhancers} function.
#
# @format A \code{data.frame} with 25 columns and 266 rows.
# @source \url{ "http://fantom.gsc.riken.jp/5/datafiles/latest/basic/human.cell_line.hCAGE/00_human.cell_line.hCAGE.hg19.assay_sdrf.txt"}
#
# @name enhancers
NULL
