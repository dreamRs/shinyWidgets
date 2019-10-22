#' @title Awesome Checkbox Input Control
#'
#' @description
#' Create a Font Awesome Bootstrap checkbox that can be used to specify logical values.
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label Input label.
#' @param value Initial value (TRUE or FALSE).
#' @param status Color of the buttons, a valid Bootstrap status : default, primary, info, success, warning, danger.
#' @param width The width of the input
#' @return A checkbox control that can be added to a UI definition.
#'
#' @seealso \code{\link{updateAwesomeCheckbox}}
#'
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'
#' ui <- fluidPage(
#'  awesomeCheckbox(inputId = "somevalue",
#'                  label = "A single checkbox",
#'                  value = TRUE,
#'                  status = "danger"),
#'  verbatimTextOutput("value")
#' )
#' server <- function(input, output) {
#'   output$value <- renderText({ input$somevalue })
#' }
#' shinyApp(ui, server)
#' }
#'
#' @importFrom shiny restoreInput
#' @importFrom htmltools htmlDependency attachDependencies
#'
#' @export
awesomeCheckbox <- function (inputId, label, value = FALSE, status = "primary", width = NULL)
{
  value <- shiny::restoreInput(id = inputId, default = value)
  status <- match.arg(arg = status, choices = c("primary", "success", "info", "warning", "danger"))
  inputTag <- htmltools::tags$input(id = inputId, type = "checkbox")
  if (!is.null(value) && value)
    inputTag$attribs$checked <- "checked"
  awesomeTag <- htmltools::tags$div(class = "form-group shiny-input-container", style = if (!is.null(width))
    paste0("width: ", htmltools::validateCssUnit(width), ";"),
    htmltools::tags$div(class = paste0("checkboxbs checkbox-bs checkbox-bs-", status),
        style = "margin-top: 10px; margin-bottom: 10px;",
        inputTag,
        htmltools::tags$label(tags$span(label, style = "font-weight: normal; cursor: pointer;"), `for` = inputId)))
  # Dep
  attachShinyWidgetsDep(awesomeTag, "awesome")
}





# Generate several checkbox

generateAwesomeOptions <- function(inputId, choices, selected, inline, status)
{
  options <- mapply(choices, names(choices), FUN = function(value,
                                                            name) {
    inputTag <- htmltools::tags$input(type = "checkbox", name = inputId, value = value, id = paste0(inputId, value))
    if (value %in% selected)
      inputTag$attribs$checked <- "checked"
    if (inline) {
      # tags$label(class = paste0("checkbox", "-inline"), inputTag,
      #            tags$span(name))
      htmltools::tags$div(class = paste0("awesome-checkbox checkbox-bs checkbox-bs-inline checkbox-inline checkbox-bs-", status),
               style = "margin-top: -4px;",
               inputTag, tags$label(style = "font-weight: normal;", name, `for` = paste0(inputId, value)))
    }
    else {
      htmltools::tags$div(class = paste0("awesome-checkbox checkbox-bs checkbox-bs-", status),
               style = "margin-top: -3px;",
               inputTag, tags$label(style = "font-weight: normal;", name, `for` = paste0(inputId, value)))
    }
  }, SIMPLIFY = FALSE, USE.NAMES = FALSE)
  htmltools::tags$div(class = "shiny-options-group", options)
}





#' @title Awesome Checkbox Group Input Control
#'
#' @description
#' Create a Font Awesome Bootstrap checkbox that can be used to specify logical values.
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label Input label.
#' @param choices List of values to show checkboxes for.
#' @param selected The values that should be initially selected, if any.
#' @param inline If TRUE, render the choices inline (i.e. horizontally)
#' @param status Color of the buttons
#' @param width The width of the input
#' @return A checkbox control that can be added to a UI definition.
#'
#' @seealso \code{\link{updateAwesomeCheckboxGroup}}
#'
#' @importFrom shiny restoreInput
#' @importFrom htmltools tags validateCssUnit
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'
#'
#' ui <- fluidPage(
#'   br(),
#'   awesomeCheckboxGroup(
#'     inputId = "id1", label = "Make a choice:",
#'     choices = c("graphics", "ggplot2")
#'   ),
#'   verbatimTextOutput(outputId = "res1"),
#'   br(),
#'   awesomeCheckboxGroup(
#'     inputId = "id2", label = "Make a choice:",
#'     choices = c("base", "dplyr", "data.table"),
#'     inline = TRUE, status = "danger"
#'   ),
#'   verbatimTextOutput(outputId = "res2")
#' )
#'
#' server <- function(input, output, session) {
#'
#'   output$res1 <- renderPrint({
#'     input$id1
#'   })
#'
#'   output$res2 <- renderPrint({
#'     input$id2
#'   })
#'
#' }
#'
#' shinyApp(ui = ui, server = server)
#'
#'
#' }
awesomeCheckboxGroup <- function (inputId, label, choices, selected = NULL, inline = FALSE, status = "primary",
          width = NULL) {
  choices <- choicesWithNames(choices)
  selected <- shiny::restoreInput(id = inputId, default = selected)
  if (!is.null(selected))
    selected <- validateSelected(selected, choices, inputId)
  options <- generateAwesomeOptions(inputId, choices, selected, inline, status = status)
  divClass <- "form-group shiny-input-container shiny-input-checkboxgroup"
  if (inline)
    divClass <- paste(divClass, "shiny-input-container-inline")
  awesomeTag <- htmltools::tags$div(id = inputId, style = if (!is.null(width))
    paste0("width: ", htmltools::validateCssUnit(width), ";"), class = divClass,
    htmltools::tags$label(label, `for` = inputId, style = "margin-bottom: 10px;"), options)
  # Dep
  attachShinyWidgetsDep(awesomeTag, "awesome")
}









#' @title Change the value of a \code{\link{awesomeCheckboxGroup}} input on the client
#'
#' @description
#' Change the value of a \code{\link{awesomeCheckboxGroup}} input on the client
#'
#'
#' @param session The session object passed to function given to shinyServer.
#' @param inputId The id of the input object.
#' @param label Input label.
#' @param choices List of values to show checkboxes for.
#' @param selected The values that should be initially selected, if any.
#' @param inline If TRUE, render the choices inline (i.e. horizontally)
#' @param status Color of the buttons.
#'
#' @seealso \code{\link{awesomeCheckboxGroup}}
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'
#' library("shiny")
#' library("shinyWidgets")
#'
#'
#' ui <- fluidPage(
#'   awesomeCheckboxGroup(
#'     inputId = "somevalue",
#'     choices = c("A", "B", "C"),
#'     label = "My label"
#'   ),
#'
#'   verbatimTextOutput(outputId = "res"),
#'
#'   actionButton(inputId = "updatechoices", label = "Random choices"),
#'   textInput(inputId = "updatelabel", label = "Update label")
#' )
#'
#' server <- function(input, output, session) {
#'
#'   output$res <- renderPrint({
#'     input$somevalue
#'   })
#'
#'   observeEvent(input$updatechoices, {
#'     updateAwesomeCheckboxGroup(
#'       session = session, inputId = "somevalue",
#'       choices = sample(letters, sample(2:6))
#'     )
#'   })
#'
#'   observeEvent(input$updatelabel, {
#'     updateAwesomeCheckboxGroup(
#'       session = session, inputId = "somevalue",
#'       label = input$updatelabel
#'     )
#'   }, ignoreInit = TRUE)
#'
#' }
#'
#' shinyApp(ui = ui, server = server)
#'
#' }
updateAwesomeCheckboxGroup <- function (session, inputId, label = NULL, choices = NULL, selected = NULL,
          inline = FALSE, status = "primary") {
  if (!is.null(choices))
    choices <- choicesWithNames(choices)
  if (!is.null(selected))
    selected <- validateSelected(selected, choices, inputId)
  options <- if (!is.null(choices)) {
    format(tagList(generateAwesomeOptions(session$ns(inputId), choices, selected, inline, status)))
  }
  message <- dropNulls(list(label = label, options = options,
                            value = selected))
  session$sendInputMessage(inputId, message)
}



#' Change the value of an awesome checkbox input on the client
#'
#' @param session standard \code{shiny} session
#' @param inputId The id of the input object.
#' @param label The label to set for the input object.
#' @param value The value to set for the input object.
#'
#' @export
#'
#' @seealso \code{\link{awesomeCheckbox}}
#'
#' @examples
#' if (interactive()) {
#'
#' library("shiny")
#' library("shinyWidgets")
#'
#'
#' ui <- fluidPage(
#'   awesomeCheckbox(
#'     inputId = "somevalue",
#'     label = "My label",
#'     value = FALSE
#'   ),
#'
#'   verbatimTextOutput(outputId = "res"),
#'
#'   actionButton(inputId = "updatevalue", label = "Toggle value"),
#'   textInput(inputId = "updatelabel", label = "Update label")
#' )
#'
#' server <- function(input, output, session) {
#'
#'   output$res <- renderPrint({
#'     input$somevalue
#'   })
#'
#'   observeEvent(input$updatevalue, {
#'     updateAwesomeCheckbox(
#'       session = session, inputId = "somevalue",
#'       value = as.logical(input$updatevalue %%2)
#'     )
#'   })
#'
#'   observeEvent(input$updatelabel, {
#'     updateAwesomeCheckbox(
#'       session = session, inputId = "somevalue",
#'       label = input$updatelabel
#'     )
#'   }, ignoreInit = TRUE)
#'
#' }
#'
#' shinyApp(ui = ui, server = server)
#'
#' }
updateAwesomeCheckbox <- function (session, inputId, label = NULL, value = NULL) {
  message <- dropNulls(list(label = label, value = value))
  session$sendInputMessage(inputId, message)
}


