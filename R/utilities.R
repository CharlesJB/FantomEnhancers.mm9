# Download a file
#
# If file already exist, it won't be downloaded unless \code{force} param is
# set to \code{TRUE}.
#
# param url Complete url (including file name) to download.
# dest_file The destination (including file name) for the downloaded file.
# force Download file even if it already exists? Default: \code{FALSE}.
#
# examples
#  \dontrun{
#    filename <- "00_human.cell_line.hCAGE.hg19.assay_sdrf.txt"
#    url <- "http://fantom.gsc.riken.jp/5/datafiles/latest/basic/human.cell_line.hCAGE/"
#    url <- paste0(url, filename)
#    filename <- paste0("inst/extdata/", filename)
#    download_file(url, filename)
#  }
download_file <- function(url, dest_file, force = FALSE) {
  if (force == TRUE | !file.exists(dest_file)) {
    download.file(url, dest_file)
  }
}

#' Get a vector of Fantom's ID matching a cell_type
#'
#' Will check in Fantom's sample names for names that contains the
#' \code{cell_line} param, ignoring case and will return the results as a
#' vector of IDs.
#'
#' @param cell_line A string corresponding to the name of the cell line.
#' @param filename The path to the Fantom's TSS file
#'
#' @return
#'   A vector with the fantom's ID(s) matching filename
#'
#' @examples
#'    get_fantom_id("GM12878")
#'
#' @export
get_fantom_id <- function(cell_line) {
  i <- grepl(cell_line, exp_description[["Comment..sample_name."]],
             ignore.case = TRUE)
  as.character(exp_description[i,][["Library.Name"]])
}
