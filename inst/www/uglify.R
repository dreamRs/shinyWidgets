


# Uglify shinyWidgets files -----------------------------------------------

# js
js_files <- list.files(path = "inst/www/", pattern = "\\.js$", full.names = TRUE, recursive = TRUE)

js_files <- lapply(js_files, readLines)
js_files <- lapply(js_files, paste, collapse = "\n")
js_files <- paste(unlist(js_files), collapse = "\n")


library("js")
js_files <- uglify_optimize(text = js_files)


writeLines(text = js_files, con = "inst/www/shinyWidgets.min.js")



# bindings
bindings_files <- list.files(path = "inst/www/", pattern = "bindings", full.names = TRUE, recursive = TRUE)
bindings_files <- lapply(bindings_files, readLines)
bindings_files <- lapply(bindings_files, paste, collapse = "\n")
bindings_files <- paste(unlist(bindings_files), collapse = "\n")

library("js")
bindings_files <- uglify_optimize(text = bindings_files)

writeLines(text = bindings_files, con = "inst/www/shinyWidgets-bindings.min.js")



# css

css_files <- list.files(path = "inst/www/", pattern = "\\.css$", full.names = TRUE, recursive = TRUE)
css_files <- css_files[!grepl(pattern = "shinyWidgets", x = css_files)]
css_files <- css_files[!grepl(pattern = "bootstrap-select", x = css_files)]
css_files <- css_files[!grepl(pattern = "bootstrap-switch", x = css_files)]
css_files <- lapply(css_files, readLines)
css_files <- lapply(css_files, paste, collapse = "\n")
css_files <- paste(unlist(css_files), collapse = "\n")

writeLines(text = css_files, con = "inst/www/shinyWidgets.css")
# https://cssminifier.com/

