#' Adds the content of www to shinyWidgets/
#'
#' @importFrom shiny addResourcePath
#'
#' @noRd
#'
.onLoad <- function(...) {
  shiny::addResourcePath('shinyWidgets', system.file('www', package = 'shinyWidgets'))
}
