#' @title Create a multiselect input control
#'
#' @description A user-friendly replacement for select boxes with the multiple attribute
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label Display label for the control, or \code{NULL} for no label.
#' @param choices List of values to select from.
#' @param selected The initially selected value.
#' @param width The width of the input, e.g. `400px`, or `100%`.
#' @param choiceNames List of names to display to the user.
#' @param choiceValues List of values corresponding to \code{choiceNames}.
#' @param options List of options passed to multi (\code{enable_search = FALSE} for disabling the search bar for example).
#'
#' @return A multiselect control that can be added to the UI of a shiny app.
#'
#' @references Fabian Lindfors, "A user-friendly replacement for select boxes with multiple attribute enabled",
#'  \url{https://github.com/fabianlindfors/multi.js}.
#'
#' @importFrom jsonlite toJSON
#' @importFrom htmltools validateCssUnit tags
#'
#' @export
#'
#' @seealso \link{updateMultiInput} to update value server-side.
#'
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'
#' library("shiny")
#' library("shinyWidgets")
#'
#'
#' # simple use
#'
#' ui <- fluidPage(
#'   multiInput(
#'     inputId = "id", label = "Fruits :",
#'     choices = c("Banana", "Blueberry", "Cherry",
#'                 "Coconut", "Grapefruit", "Kiwi",
#'                 "Lemon", "Lime", "Mango", "Orange",
#'                 "Papaya"),
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
#'
#'
#' # with options
#'
#' ui <- fluidPage(
#'   multiInput(
#'     inputId = "id", label = "Fruits :",
#'     choices = c("Banana", "Blueberry", "Cherry",
#'                 "Coconut", "Grapefruit", "Kiwi",
#'                 "Lemon", "Lime", "Mango", "Orange",
#'                 "Papaya"),
#'     selected = "Banana", width = "400px",
#'     options = list(
#'       enable_search = FALSE,
#'       non_selected_header = "Choose between:",
#'       selected_header = "You have selected:"
#'     )
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
#'
#' }
multiInput <- function(inputId,
                       label,
                       choices = NULL,
                       selected = NULL,
                       options = NULL,
                       width = NULL,
                       choiceNames = NULL,
                       choiceValues = NULL) {
  selected <- shiny::restoreInput(id = inputId, default = selected)
  selectTag <- tags$select(
    id = inputId, multiple = "multiple", class= "form-control multijs",
    makeChoices(
      choices = choices,
      choiceNames = choiceNames,
      choiceValues = choiceValues,
      selected = selected
    )
  )
  tags$div(
    class = "form-group shiny-input-container",
    style = if (!is.null(width)) paste("width:", validateCssUnit(width)),
    tags$label(
      id = paste0(inputId, "-label"),
      class = "control-label",
      class = if (is.null(label)) "shiny-label-null",
      `for` = inputId,
      label
    ),
    selectTag,
    tags$script(
      type = "application/json",
      `data-for` = inputId,
      jsonlite::toJSON(options, auto_unbox = TRUE, json_verbatim = TRUE)
    ),
    html_dependency_shinyWidgets(),
    html_dependency_multi()
  )
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
          htmltools::tags$option(
            value = choiceValues[[i]],
            as.character(choiceNames[[i]]),
            selected = if(choiceValues[[i]] %in% selected) "selected"
          )
        }
      )
    )
  } else {
    choices <- choicesWithNames(choices)
    tagList(
      lapply(
        X = seq_along(choices), FUN = function(i) {
          htmltools::tags$option(
            value = choices[[i]],
            names(choices)[i],
            selected = if(choices[[i]] %in% selected) "selected"
          )
        }
      )
    )
  }
}



#' @title Change the value of a multi input on the client
#'
#' @description Change the value of a multi input on the client
#'
#' @param session The session object passed to function given to shinyServer.
#' @param inputId The id of the input object.
#' @param label The label to set.
#' @param selected The values selected. To select none, use \code{character(0)}.
#' @param choices The new choices for the input.
#'
#' @seealso \code{\link{multiInput}}
#'
#' @note Thanks to \href{https://github.com/ifellows}{Ian Fellows} for this one !
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'
#' library(shiny)
#' library(shinyWidgets)
#'
#' fruits <- c("Banana", "Blueberry", "Cherry",
#'             "Coconut", "Grapefruit", "Kiwi",
#'             "Lemon", "Lime", "Mango", "Orange",
#'             "Papaya")
#'
#' ui <- fluidPage(
#'   tags$h2("Multi update"),
#'   multiInput(
#'     inputId = "my_multi",
#'     label = "Fruits :",
#'     choices = fruits,
#'     selected = "Banana",
#'     width = "350px"
#'   ),
#'   verbatimTextOutput(outputId = "res"),
#'   selectInput(
#'     inputId = "selected",
#'     label = "Update selected:",
#'     choices = fruits,
#'     multiple = TRUE
#'   ),
#'   textInput(inputId = "label", label = "Update label:")
#' )
#'
#' server <- function(input, output, session) {
#'
#'   output$res <- renderPrint(input$my_multi)
#'
#'   observeEvent(input$selected, {
#'     updateMultiInput(
#'       session = session,
#'       inputId = "my_multi",
#'       selected = input$selected
#'     )
#'   })
#'
#'   observeEvent(input$label, {
#'     updateMultiInput(
#'       session = session,
#'       inputId = "my_multi",
#'       label = input$label
#'     )
#'   }, ignoreInit = TRUE)
#' }
#'
#' shinyApp(ui, server)
#'
#' }
updateMultiInput <- function (session, inputId, label = NULL, selected = NULL, choices = NULL) {
  choices <- if (!is.null(choices))
    choicesWithNames(choices)
  if (!is.null(selected))
    selected <- validateSelected(selected, choices, inputId)
  options <- if (!is.null(choices))
    as.character(makeChoices(choices, selected = selected))
  message <- dropNulls(list(label = label, options = options, value = selected))
  session$sendInputMessage(inputId, message)
}


