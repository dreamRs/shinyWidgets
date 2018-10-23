
#  ------------------------------------------------------------------------
#
# Title : PickerInput Options
#    By : Victor
#  Date : 23/10/2018
#
#  ------------------------------------------------------------------------



# Packages ----------------------------------------------------------------

library(rvest)


# Scrap options table -----------------------------------------------------

tabOpts <- read_html(x = "https://developer.snapappointments.com/bootstrap-select/options/")
tabOpts <- html_table(tabOpts)[[1]]




# Function ----------------------------------------------------------------

cat(paste0(
  "pickerOptions <- function(",
  paste(sprintf("%s = NULL", tabOpts$Name), collapse = ",\n"),
  ") {}"
))


gsub(pattern = "([A-Z])", replacement = "-\\1", x = "countSelectedText")

convert_names <- function(x) {
  x <- gsub(pattern = "([A-Z])", replacement = "-\\1", x = x)
  tolower(x)
}

convert_names(tabOpts$Name)



# Documentation -----------------------------------------------------------


cat(paste(
  sprintf("#' @param %s %s Type: %s; Default: %s. ", tabOpts$Name, gsub("\\n", " ", tabOpts$Description), tabOpts$Type, tabOpts$Default),
  collapse = "\n"
))





