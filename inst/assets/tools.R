
#  ------------------------------------------------------------------------
#
# Title : Validate JS & CSS and compress
#    By : Victor
#  Date : 2019-10-21
#
#  ------------------------------------------------------------------------




# Packages ----------------------------------------------------------------

library(jstools)




# Validate ----------------------------------------------------------------

# search all bindings files
bindings <- list.files(
  path = "inst/assets",
  pattern = "bindings\\.js$",
  recursive = TRUE,
  full.names = TRUE
)
# add utils
bindings <- c("inst/assets/utils.js", bindings)

# check for errors
jshint_file(input = bindings, options = jshint_options(jquery = TRUE, globals = list("Shiny")))




# Compress ----------------------------------------------------------------

# remove sweet alert
bindings <- setdiff(bindings, grep("/sweetalert-bindings.js", bindings, value = TRUE))
# bindings <- setdiff(bindings, grep("/picker-bindings", bindings, value = TRUE))

# bundle all scripts
terser_file(input = bindings, output = "inst/assets/shinyWidgets-bindings.min.js")




# CSS ---------------------------------------------------------------------

# all files
css_files <- list.files(path = "inst/assets/", pattern = "\\.css$", full.names = TRUE, recursive = TRUE)

# keep the ones not integrated via a widgets
css_files <- css_files[
  grepl(pattern = "checkboxGroupButtons", x = css_files, fixed = TRUE) |
    grepl(pattern = "radioGroupButtons", x = css_files) |
    grepl(pattern = "circle-button", x = css_files) |
    grepl(pattern = "material-switch", x = css_files, fixed = TRUE) |
    # grepl(pattern = "multi-shiny", x = css_files) |
    grepl(pattern = "sw-color-selector", x = css_files)
  ]


jstools::crass_file(input = css_files, output = "inst/assets/shinyWidgets.min.css")

