
#' @title Launch the shinyWidget Gallery
#'
#' @description
#' A gallery of widgets available in the package
#'
#'
#' @importFrom shiny runApp
#' @export


shinyWidgetsGallery <- function() {
  if (!requireNamespace(package = "shinydashboard"))
    message("Package 'shinydashboard' is required to run this function")
  if (!requireNamespace(package = "formatR"))
    message("Package 'formatR' is required to run this function")
  shiny::runApp(system.file('examples/shinyWidgets', package='shinyWidgets', mustWork=TRUE))
}
