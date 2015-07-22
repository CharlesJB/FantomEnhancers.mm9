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
#    filename <- "00_human.cell_line.hCAGE.mm9.assay_sdrf.txt"
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

#' Get a vector of Fantom's libraries ID matching a cell_type
#'
#' Will check in Fantom's sample names for names that contains the
#' \code{cell_line} param, ignoring case and will return the results as a
#' vector of IDs.
#'
#' @param cell_line A string corresponding to the name of the cell line.
#'
#' @return
#'   A vector with the fantom's libraries ID(s) matching filename
#'
#' @examples
#'    get_fantom_fantom_library_name("GM12878")
#'
#' @export
get_fantom_fantom_library_name <- function(cell_line) {
  i <- grepl(cell_line, exp_description[["Comment..sample_name."]],
             ignore.case = TRUE)
  as.character(exp_description[i,][["Library.Name"]])
}

#' Get a GRanges object with all the enhancers from Fantom.
#'
#' Produce a GRanges object containing all the enhancers from Fantom but
#' without the expression values for every experiments.
#'
#' @seealso  \code{\link{get_fantom_enhancers_tpm}}
#'
#' @return A \code{GRanges} object representing every enhancers from Fantom in
#'   mm9.
#'
#' @examples
#'   get_fantom_enhancers()
#'
#' @import GenomicRanges
#' @export
get_fantom_enhancers <- function() {
  to_return <- enhancers
  S4Vectors::mcols(to_return) <- NULL
  to_return
}

#' Get a GRanges object with the TPM values for specific cell types
#'
#' Returns a GRanges with metadata columns corresponding to the requested
#' cell type enhancer expression (in TPM).
#'
#' @seealso \code{\link{get_fantom_enhancers}}
#' @seealso \code{\link{get_fantom_fantom_library_name}}
#'
#' @param cell_lines The cell line(s) to fetch. Must be a vector of character.
#'                   The function will look for the pattern (with \code{grepl})
#'                   to find case-insensitive match(es) with this param in the
#'                   Fantom's experiments sample names.
#'
#'                   If \code{NULL}, this will return a \code{GRanges} object
#'                   with all the Fantom's experiments.
#'
#'                   The metadata columns will be named using the
#'                   \code{cell_type} param. When \code{merge.FUN} is
#'                   \code{NULL} and there is multiple experiment for the same
#'                   cell line, a counter will be added after each name to
#'                   ensure all metadata colnames are unique (i.e.: A549_1,
#'                   A549_2, A549_3). If \code{NULL}, the experiment names will
#'                   be used for each metadata colnames.
#'
#'                   Default: \code{NULL}.
#' @param merge.FUN  A function to merge the TPM when there is more than one
#'                   column for the same cell type. Must take a vector of
#'                   numeric as input and returns a single numeric value.
#'
#'                   Default: \code{NULL}
#'
#' @return A \code{GRanges} object with the metadata columns containing the
#'   expression value in TMP for the requested cell line(s), all 1827
#'   experiments expression values are returned if \code{cell_line} is
#'   \code{NULL}. If the cell line(s) is not found, an empty \code{GRanges} is
#'   returned.
#'
#' @examples
#'   # To get the TPM in A549 cell lines
#'   get_fantom_enhancers_tpm(cell_lines = "A549")
#'
#'   # To get the TPM in A549 and in K562 cell lines
#'   get_fantom_enhancers_tpm(cell_lines = c("A549", "K562"))
#'
#'   # To get the TPM K562 cell lines and merge metadata columns by returning
#'   # their mean value
#'   get_fantom_enhancers_tpm(cell_lines = "K562", merge.FUN = mean)
#'
#' @export
get_fantom_enhancers_tpm <- function(cell_lines = NULL, merge.FUN = NULL) {
  if (is.null(cell_lines)) {
    enhancers_tpm
  } else {
    clean_and_subset_enhancers(enhancers_tpm, cell_lines, merge.FUN = merge.FUN)
  }
}

#' Get a GRanges object with the counts values for specific cell types
#'
#' Returns a GRanges with metadata columns corresponding to the requested
#' cell type enhancer expression (in counts).
#'
#' @seealso \code{\link{get_fantom_enhancers}}
#' @seealso \code{\link{get_fantom_enhancers_tpm}}
#' @seealso \code{\link{get_fantom_fantom_library_name}}
#'
#' @param cell_lines The cell line(s) to fetch. Must be a vector of character.
#'                   The function will look for the pattern (with \code{grepl})
#'                   to find case-insensitive match(es) with this param in the
#'                   Fantom's experiments sample names.
#'
#'                   If \code{NULL}, this will return a \code{GRanges} object
#'                   with all the Fantom's experiments.
#'
#'                   The metadata columns will be named using the
#'                   \code{cell_type} param. When \code{merge.FUN} is
#'                   \code{NULL} and there is multiple experiment for the same
#'                   cell line, a counter will be added after each name to
#'                   ensure all metadata colnames are unique (i.e.: A549_1,
#'                   A549_2, A549_3). If \code{NULL}, the experiment names will
#'                   be used for each metadata colnames.
#'
#'                   Default: \code{NULL}.
#' @param merge.FUN  A function to merge the TPM when there is more than one
#'                   column for the same cell type. Must take a vector of
#'                   numeric as input and returns a single numeric value.
#'
#'                   Default: \code{NULL}
#'
#' @return A \code{GRanges} object with the metadata columns containing the
#'   expression value in counts for the requested cell line(s), all
#'   experiments expression values are returned if \code{cell_line} is
#'   \code{NULL}. If the cell line(s) is not found, an empty \code{GRanges} is
#'   returned.
#'
#' @examples
#'   # To get the counts in lung
#'   get_fantom_enhancers_counts(cell_lines = "lung")
#'
#'   # To get the counts in lung and heart
#'   get_fantom_enhancers_counts(cell_lines = c("lung", "heart"))
#'
#'   # To get the counts lung and merge metadata columns by returning
#'   # their mean value
#'   get_fantom_enhancers_counts(cell_lines = "lung", merge.FUN = mean)
#'
#' @export
get_fantom_enhancers_counts <- function(cell_lines = NULL, merge.FUN = NULL) {
  if (is.null(cell_lines)) {
    enhancers_counts
  } else {
    clean_and_subset_enhancers(enhancers_counts, cell_lines, merge.FUN = merge.FUN)
  }
}

clean_and_subset_enhancers <- function(enhancers, cell_lines, merge.FUN) {
    # Get libraries IDs
    cell_line <- unique(cell_lines)
    ids <- lapply(cell_lines, get_fantom_fantom_library_name)
    names(ids) <- cell_lines

    # Fetch columns
    idx <- lapply(ids, function(x) colnames(S4Vectors::mcols(enhancers)) %in% x)
    metadata <- lapply(idx, function(i)
                         S4Vectors::DataFrame(S4Vectors::mcols(enhancers)[,i]))

    # Merge the columns
    if (!is.null(merge.FUN)) {
      metadata <- lapply(metadata,
			 function(x) apply(as.data.frame(x), 1, merge.FUN))
      names
    } else {
      get_fantom_names <- function(basename) {
        id <- ids[[basename]]
        names <- rep(basename, length(id))
        paste(names, 1:length(names), sep = "_")
      }
      metadata <- lapply(metadata, as.data.frame)
      metadata <- do.call("cbind", metadata)
      colnames(metadata) <- unlist(lapply(cell_lines, get_fantom_names))
    }

    # Add the metadata to the gr to return
    gr <- enhancers
    S4Vectors::mcols(gr) <- metadata
    gr
}

#' Get Fantom's experiment metadata
#'
#' This function returns the library names and the sample names for every
#' experiment from Fantom.
#'
#' @seealso get_fantom_fantom_library_name
#'
#' @return A \code{data.frame} with 2 columns: "library_name" and
#' "sample_name". One row per Fantom experiment.
#'
#' @examples
#'   head(get_fantom_experiment_infos())
#'
#' @export
get_fantom_experiment_infos <- function() {
  to_return <- exp_description[,c("Library.Name", "Comment..sample_name.")]
  colnames(to_return) <- c("library_name", "sample_name")
  to_return
}
