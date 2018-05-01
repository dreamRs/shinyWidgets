
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
  shiny::shinyAppFile(
    appFile = system.file(sprintf("examples/nouislider/%s/app.R", example), package = "shinyWidgets"),
    options = list("display.mode" = "showcase")
  )
}



#' Some examples on how to use airDatepickerInput
#'
#' @param example Name of the example : \code{"datepicker"},
#'  \code{"timepicker"}, \code{"months"}, \code{"years"},
#'  \code{"update"}.
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
#' demoAirDatepicker("datepicker")
#'
#' }
#'
#' }
demoAirDatepicker <- function(example = "datepicker") {
  example <- match.arg(arg = example, choices = c("datepicker", "timepicker", "months", "years", "update"))
  shiny::shinyAppFile(
    appFile = system.file(sprintf("examples/airDatepicker/%s/app.R", example), package = "shinyWidgets"),
    options = list("display.mode" = "showcase")
  )
}
