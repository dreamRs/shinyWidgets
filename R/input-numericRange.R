#' @title Numeric Range Input
#'
#' @description Create an input group of numeric inputs that function as a range
#' input.
#'
#' @param value The initial value(s) for the range. A
#' numeric vector of length one will be duplicated to represent the minimum and
#' maximum of the range; a numeric vector of two or more will have its minimum
#' and maximum set the minimum and maximum of the range.
#' @inheritParams shiny::numericInput
#' @inheritParams shiny::sliderInput
#' @inheritParams shiny::dateRangeInput
#'
#' @importFrom htmltools tags tagList singleton findDependencies attachDependencies validateCssUnit
#' @importFrom shiny sliderInput restoreInput
#' @importFrom utils packageVersion
#'
#' @seealso [updateNumericRangeInput()]
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'
#' ### examples ----
#'
#' # see ?demoNumericRange
#' demoNumericRange()
#'
#'
#' ###  basic usage ----
#'
#' library( shiny )
#' library( shinyWidgets )
#'
#'
#' ui <- fluidPage(
#'
#'   tags$br(),
#'
#'   numericRangeInput(
#'     inputId = "my_id", label = "Numeric Range Input:",
#'     value = c(100, 400)
#'   ),
#'   verbatimTextOutput(outputId = "res1")
#'
#' )
#'
#' server <- function(input, output, session) {
#'
#'   output$res1 <- renderPrint(input$my_id)
#'
#' }
#'
#' shinyApp(ui, server)
#'
#'
#' }
numericRangeInput <- function(inputId,
                              label,
                              value,
                              width = NULL,
                              separator = " to ",
                              min = NA,
                              max = NA,
                              step = NA) {

  value <- shiny::restoreInput(id = inputId, default = value)

  value <- c(min(value), max(value))

  if (!is.na(min) && length(min) == 1)
    min <- rep(min, 2)
  if (!is.na(max) && length(max) == 1)
    max <- rep(max, 2)
  if (!is.na(step) && length(step) == 1)
    step <- rep(step, 2)

  input_tag <- function(value, min, max, step) {
    inputTag <- tags$input(
      type = "number",
      class = "form-control",
      value = formatNoSci(value)
    )
    if (!is.na(min))
      inputTag$attribs$min <- min
    if (!is.na(max))
      inputTag$attribs$max <- max
    if (!is.na(step))
      inputTag$attribs$step <- step
    inputTag
  }

  fromTag <- input_tag(value[1], min[1], max[1], step[1])
  toTag <- input_tag(value[2], min[2], max[2], step[2])

  rangeTag <- tags$div(
      id = inputId,
      class = "shiny-numeric-range-input form-group shiny-input-container",
      style = if (!is.null(width)) paste0("width: ", htmltools::validateCssUnit(width), ";"),
      tags$label(
        class = "control-label",
        `for` = inputId,
        label,
        class = if (is.null(label)) "shiny-label-null"
      ),
      tags$div(
        class = "input-numeric-range input-group",
        fromTag,
        tags$span(class = "input-group-addon input-group-text rounded-0", separator),
        toTag
      )
    )

  attachShinyWidgetsDep(rangeTag)
}

#' Change the value of a numeric range input
#'
#' @param session The session object passed to function given to shinyServer.
#' @inheritParams numericRangeInput
#'
#' @seealso [numericRangeInput()]
#'
#' @export
#'
#' @example examples/updateNumericRangeInput.R
updateNumericRangeInput <- function(session = getDefaultReactiveDomain(),
                                    inputId,
                                    label = NULL,
                                    value = NULL) {

  if (!is.null(value))
    value <- c(min(value), max(value))
  message <- list(
    label = label,
    value = value
  )
  session$sendInputMessage(inputId, dropNulls(message))
}
