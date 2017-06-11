#' Create a multiselect input control
#'
#' @description A user-friendly replacement for select boxes with the multiple attribute
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label Display label for the control, or \code{NULL} for no label.
#' @param choices List of values to select from.
#' @param selected The initially selected value
#' @param width The width of the input, e.g. \code{400px}, or \code{100\%}
#' @param choiceNames List of names to display
#' @param choiceValues List of value to retrieve in server
#' @param options List of options passed to multi (\code{enable_search = FALSE} for disabling the search bar for example)
#'
#' @return A multiselect control
#' @importFrom jsonlite toJSON
#' @importFrom htmltools validateCssUnit tags
#' @export
#'
#' @examples
#' \dontrun{
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#' library("shiny")
#' library("shinyWidgets")
#' ui <- fluidPage(
#'   multiInput(
#'     inputId = "id", label = "Fruits :",
#'     choices = c("Banana", "Blueberry", "Cherry", "Coconut", "Grapefruit",
#'                 "Kiwi", "Lemon", "Lime", "Mango", "Orange", "Papaya"),
#'     selected = "Banana", width = "350px"
#'   ),
#'   verbatimTextOutput(outputId = "res")
#' )
#'
#' server <- function(input, output, session) {
#'   output$res <- renderPrint({
#'     input$id
#'   })
#' }
#'
#' shinyApp(ui = ui, server = server)
#' }
#' }
multiInput <- function(inputId, label, choices = NULL, selected = NULL, options = NULL, width = NULL, choiceNames = NULL, choiceValues = NULL) {
  selectTag <- tags$select(
    id = inputId, multiple = "multiple",
    makeChoices(choices = choices, choiceNames = choiceNames, choiceValues = choiceValues, selected = selected)
  )
  multiTag <- tags$div(
    class = "form-group shiny-input-containe",
    style = if(!is.null(width)) paste("width:", htmltools::validateCssUnit(width)),
    tags$label(class = "control-label", `for` = inputId, label),
    selectTag, tags$script(sprintf("$('#%s').multi(%s);", inputId, jsonlite::toJSON(options, auto_unbox = TRUE)))
  )
  attachShinyWidgetsDep(multiTag, "multi")
}




makeChoices <- function(choices = NULL, choiceNames = NULL, choiceValues = NULL, selected = NULL) {
  if (is.null(choices)) {
    if (is.null(choiceValues))
      stop("If choices = NULL, choiceValues must be not NULL")
    if (length(choiceNames) != length(choiceValues)) {
      stop("`choiceNames` and `choiceValues` must have the same length.")
    }
    choiceValues <- as.list(choiceValues)
    choiceNames <- as.list(choiceNames)
    tagList(
      lapply(
        X = seq_along(choiceNames),
        FUN = function(i) {
          tags$option(value = choiceValues[[i]], as.character(choiceNames[[i]]), selected = if(choiceValues[[i]] %in% selected) "selected")
        }
      )
    )
  } else {
    choices <- choicesWithNames(choices)
    tagList(
      lapply(
        X = seq_along(choices), FUN = function(i) {
          tags$option(value = choices[[i]], names(choices)[i], selected = if(choices[[i]] %in% selected) "selected")
        }
      )
    )
  }
}



