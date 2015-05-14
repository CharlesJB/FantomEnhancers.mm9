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
