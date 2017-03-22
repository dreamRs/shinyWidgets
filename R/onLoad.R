#' Adds the content of www to shinyWidgets/
#'
#' @import shiny
#'
#' @noRd
#'

.onLoad <- function(...) {
  addResourcePath('shinyWidgets', system.file('www', package = 'shinyWidgets'))
}
