# FantomEnhancers.hg19

The goal of this package is to easily extract the genomic positions and the normalized expression of Fantom's enhancers (in TPM) in hg19.

## Installation

```
require(devtools)
devtools::install_github("CharlesJB/FantomEnhancers.hg19")
```

## Main functions

The `get_fantom_enhancers` functions returns a `GRanges` object with all the enhancers and no metadata columns:
```
get_fantom_enhancers()
```

The `get_fantom_enhancers_tpm` returns a `GRanges` object with all the enhancers and selected metadata columns:
```
# To get the expression of enhancers in A549
get_fantom_enhancers_tpm(cell_lines = "A549")

# To get the expression of enhancers in A549 and K562
get_fantom_enhancers_tpm(cell_lines = c("A549", "K562"))

# To merge all the columns for a cell line by calculating the mean value for
# each enhancers
get_fantom_enhancers_tpm(cell_lines = c("A549", "K562"), merge.FUN = mean)

# To merge all the columns for a cell line by calculating the sum for each
# enhancers
get_fantom_enhancers_tpm(cell_lines = c("A549", "K562"), merge.FUN = sum)
