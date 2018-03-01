#' Some examples on how to use noUiSliderInput
#'
#' @param example Name of the example : \code{"color"},
#'  \code{"update"}, \code{"behaviour"}, \code{"more"},
#'  \code{"format"}.
#'
#' @export
#'
#' @importFrom shiny shinyAppFile
#'
#' @examples
#' \dontrun{
#'
#' if (interactive()) {
#'
#' demoNoUiSlider("color")
#'
#' }
#'
#' }
demoNoUiSlider <- function(example = "color") {
  example <- match.arg(arg = example, choices = c("color", "update", "behaviour", "more", "format"))
  if (example == "color") {
    shiny::shinyAppFile(
      appFile = system.file("examples/nouislider/colorpicker.R", package = "shinyWidgets"),
      options = list("display.mode" = "showcase")
    )
  } else {
    shiny::shinyAppFile(
      appFile = system.file(sprintf("examples/nouislider/%s.R", example), package = "shinyWidgets"),
      options = list("display.mode" = "showcase")
    )
  }
}
