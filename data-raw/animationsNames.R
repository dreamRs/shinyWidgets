
# Animation names

animations <- jsonlite::fromJSON(txt = "inst/www/animate/animate-config.json", simplifyVector = FALSE)

animations <- purrr::map(animations, function(x) {
  setNames(x, purrr::flatten_chr(x))
})


devtools::use_data(animations, overwrite = TRUE)
