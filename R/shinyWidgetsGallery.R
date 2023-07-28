
#' @title Launch the shinyWidget Gallery
#'
#' @description
#' A gallery of widgets available in the package.
#'
#'
#' @importFrom shiny shinyAppDir
#' @export
#'
#' @examples
#' if (interactive()) {
#'
#'  shinyWidgetsGallery()
#'
#' }
shinyWidgetsGallery <- function() { # nocov start
  shiny::shinyAppDir(system.file("examples/shinyWidgets", package = "shinyWidgets", mustWork = TRUE))
}
# nocov end
