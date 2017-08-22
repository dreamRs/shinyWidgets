#' @title Material Design Switch Input Control
#'
#' @description
#' Create buttons grouped that act like radio buttons.
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label Input label.
#' @param value TRUE or FALSE.
#' @param status Color, must be a valid Bootstrap status : default, primary, info, success, warning, danger.
#' @param right Should the the label be on the right ? default to FALSE
#' @param width Width of the container
#' @return A switch control that can be added to a UI definition.
#'
#'
#' @examples
#' materialSwitch(inputId = "somevalue", label = "")
#' \dontrun{
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'
#' ui <- fluidPage(
#'   materialSwitch(inputId = "somevalue", label = ""),
#'   verbatimTextOutput("value")
#' )
#' server <- function(input, output) {
#'   output$value <- renderText({ input$somevalue })
#' }
#' shinyApp(ui, server)
#' }
#' }
#'
#' @import shiny
#' @importFrom htmltools htmlDependency attachDependencies validateCssUnit
#'
#' @export
materialSwitch <- function(inputId, label = NULL, value = FALSE, status = "default", right = FALSE, width = NULL) {
  value <- shiny::restoreInput(id = inputId, default = value)
  status <- match.arg(arg = status, choices = c("default", "primary", "success", "info", "warning", "danger"))
  inputTag <- tags$input(id = inputId, type = "checkbox")
  if (!is.null(value) && value)
    inputTag$attribs$checked <- "checked"
  msTag <- div(class = "form-group shiny-input-container", style = if (!is.null(width))
    paste0("width: ", htmltools::validateCssUnit(width), ";"),
    # if (right) tags$span(label),
    div(class = "material-switch",
        if (!is.null(label) & !right) tags$span(label, style = "padding-right: 10px;"),
        inputTag,
        tags$label(`for`=inputId, class=paste0("label-", status)),
        if (!is.null(label) & right) tags$span(label, style = "padding-left: 10px;")))
  # Dep
  attachShinyWidgetsDep(msTag)
}


#' @title Change the value of a materialSwitch input on the client
#'
#' @description
#' Change the value of a materialSwitch input on the client
#'
#' @param session The session object passed to function given to shinyServer.
#' @param inputId	The id of the input object.
#' @param value The value to set for the input object.
#'
#' @export

updateMaterialSwitch <- function (session, inputId, value = NULL) {
  message <- dropNulls(list(value = value))
  session$sendInputMessage(inputId, message)
}

