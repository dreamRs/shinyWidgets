
#' @title Launch the shinyWidget Gallery
#'
#' @description
#' A gallery of widgets available in the package
#'
#'
#' @importFrom shiny runApp
#' @export


shinyWidgetsGallery <- function() {
  runApp(system.file('examples/shinyWidgets', package='shinyWidgets', mustWork=TRUE))
}
