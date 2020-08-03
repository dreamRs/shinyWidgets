#' @title Dollar Input
#'
#' @description A function that returns the HTML to build a dollarInput user interface
#'
#' Based on the shiny text input, the dollar input is
#' useful when one needs to input large sums of money,
#' as it automatically puts a "$" at the beginning of the number and
#' dynamically inserts the commas where they are supposed to be.  On the
#' back-end, the getvalue method for this type of input deletes all non-
#' numeric values in the string and converts it to an integer before
#' sending the value to the shiny server function.
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label Display label for the control, or NULL for no label.
#' @param value the initial value of the input, generally a money value, e.g. '$0'or '$10,000'
#' @param width The width of the input, e.g. '400px', or '100\%'; see validateCssUnit().
#'
#' @return an HTML tag list that when rendered creates the dollarInput.
#' @export
#'
#' @importFrom htmltools tags tagList
#'
#' @examples
#' if (interactive()) {
#'
#' library("shiny")
#' library("shinyWidgets")
#'
#' ui <- fluidPage(
#'   dollarInput(
#'     inputId = "myDollar",
#'     label = "Input a monetary amount",
#'     value = "$140",
#'     width = 150
#'   ),
#'   verbatimTextOutput(outputId = "res")
#' )
#'
#' server <- function(input, output, session) {
#'
#'   output$res <- renderPrint(input$myDollar)
#'
#' }
#'
#' shinyApp(ui = ui, server = server)
#'
#' }
dollarInput <- function(inputId, label, value = "$", width = NULL) {
  dollarInputTag <- tagList(
    ## render the label and the input, with the function arguments
    ## as modifiers
    tags$label(label, `for` = inputId),
    tags$input(
      id = inputId,
      type = "dollar",
      class = "form-control shiny-bound-input",
      value = value,
      style = if (!is.null(width))
        paste0("width:", htmltools::validateCssUnit(width))
    )
  )
  attachShinyWidgetsDep(dollarInputTag, "dollarinput")
}
