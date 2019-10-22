


# Uglify shinyWidgets files -----------------------------------------------

# js ----

# not used
# js_files <- list.files(path = "inst/www/", pattern = "\\.js$", full.names = TRUE, recursive = TRUE)
# js_files <- lapply(js_files, readLines)
# js_files <- lapply(js_files, paste, collapse = "\n")
# js_files <- paste(unlist(js_files), collapse = "\n")
# library("js")
# js_files <- uglify_optimize(text = js_files)
# writeLines(text = js_files, con = "inst/www/shinyWidgets.min.js")



# bindings ----

# create one file with all bindings
bindings_files <- list.files(path = "inst/assets/", pattern = "bindings", full.names = TRUE, recursive = TRUE)
bindings_files <- bindings_files[bindings_files != "inst/assets/shinyWidgets-bindings.min.js"]
bindings_files <- bindings_files[bindings_files != "inst/assets/sweetAlert/sweetalert-bindings.js"]
bindings_files <- bindings_files[bindings_files != "inst/assets/air-datepicker/datepicker-bindings.js"]
bindings_files <- bindings_files[!grepl(pattern = "awesome", bindings_files)]
bindings_files <- lapply(bindings_files, readLines)
bindings_files <- lapply(bindings_files, paste, collapse = "\n")
bindings_files <- paste(unlist(bindings_files), collapse = "\n")

library("js")
bindings_files <- uglify_optimize(text = bindings_files)

writeLines(text = bindings_files, con = "inst/www/shinyWidgets-bindings.min.js")



# css ----

# all files
css_files <- list.files(path = "inst/www/", pattern = "\\.css$", full.names = TRUE, recursive = TRUE)

# keep the ones not integrated via a widgets
css_files <- css_files[
  grepl(pattern = "checkboxGroupButtons", x = css_files, fixed = TRUE) |
    grepl(pattern = "radioGroupButtons", x = css_files) |
    grepl(pattern = "circle-button", x = css_files) |
    grepl(pattern = "material-switch", x = css_files, fixed = TRUE) |
    # grepl(pattern = "multi-shiny", x = css_files) |
    grepl(pattern = "sw-color-selector", x = css_files)
  ]

# read them all
css_files <- lapply(css_files, readLines)
# concat in one string
css_files <- lapply(css_files, paste, collapse = "\n")
css_files <- paste(unlist(css_files), collapse = "\n")

# write them all
writeLines(text = css_files, con = "inst/www/shinyWidgets.css")

# go here to minify the file
# https://cssminifier.com/

