#' @title Numeric Range Input
#'
#' @description Create an input group of numeric inputs that function as a range
#' input.
#'
#' @param value The initial value(s) for the range. A
#' numeric vector of length one will be duplicated to represent the minimum and
#' maximum of the range; a numeric vector of two or more will have its minimum
#' and maximum set the minimum and maximum of the range.
#' @inheritParams shiny::sliderInput
#' @inheritParams shiny::dateRangeInput
#'
#' @importFrom htmltools tags tagList singleton findDependencies attachDependencies validateCssUnit
#' @importFrom shiny sliderInput restoreInput
#' @importFrom utils packageVersion
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
#'     inputId = "noui1", label = "Numeric Range Input:",
#'     value = c(100, 400)
#'   ),
#'   verbatimTextOutput(outputId = "res1")
#'
#' )
#'
#' server <- function(input, output, session) {
#'
#'   output$res1 <- renderPrint(input$noui1)
#'
#' }
#'
#' shinyApp(ui, server)
#'
#'
#' }
#' @export

numericRangeInput <- function(inputId, label, value,
                              width = NULL, separator = " to ") {

  value <- shiny::restoreInput(id = inputId, default = value)

  value <- c(min(value),max(value))

  #build tag
  rangeTag <- htmltools::tags$div(
      id = inputId,
      class = "shiny-numeric-range-input form-group shiny-input-container",
      style = if (!is.null(width)) paste0("width: ", htmltools::validateCssUnit(width), ";"),

      controlLabel(inputId, label),
      # input-daterange class is needed for dropdown behavior
      htmltools::tags$div(
        class = "input-numeric-range input-group",
        htmltools::tags$input(
          type = "number",
          class = "form-control",
          value = formatNoSci(min(value))
        ),
        htmltools::tags$span(class = "input-group-addon", separator),
        htmltools::tags$input(
          type = "number",
          class = "form-control",
          value = formatNoSci(max(value))
        )
      )
    )

  attachShinyWidgetsDep(rangeTag)
}

#' Change the value of a numeric range input
#'
#' @param session The session object passed to function given to shinyServer.
#' @inheritParams numericRangeInput
#' @export
#'
updateNumericRangeInput <- function(session, inputId, label, value) {

  value <- c(min(value),max(value))

  message <- dropNulls(list(
    label = label,
    value = value
  ))

  session$sendInputMessage(inputId, message)

}
