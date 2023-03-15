#' @title Material Design Switch Input Control
#'
#' @description
#' A toggle switch to turn a selection on or off.
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label Input label.
#' @param value TRUE or FALSE.
#' @param status Color, must be a valid Bootstrap status : default, primary, info, success, warning, danger.
#' @param right Should the the label be on the right? default to FALSE.
#' @param inline Display the input inline, if you want to place buttons next to each other.
#' @param width The width of the input, e.g. `400px`, or `100%`.
#'
#' @return A switch control that can be added to a UI definition.
#'
#' @seealso \code{\link{updateMaterialSwitch}}, \code{\link{switchInput}}
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyWidgets)
#'
#'   ui <- fluidPage(
#'     tags$h3("Material switch examples"),
#'
#'     materialSwitch(inputId = "switch1", label = "Night mode"),
#'     verbatimTextOutput("value1"),
#'
#'     materialSwitch(inputId = "switch2", label = "Night mode", status = "danger"),
#'     verbatimTextOutput("value2")
#'   )
#'   server <- function(input, output) {
#'
#'     output$value1 <- renderText({ input$switch1 })
#'
#'     output$value2 <- renderText({ input$switch2 })
#'
#'   }
#'   shinyApp(ui, server)
#' }
#'
#' @importFrom shiny restoreInput
#' @importFrom htmltools tags validateCssUnit
#'
#' @export
materialSwitch <- function(inputId,
                           label = NULL,
                           value = FALSE,
                           status = "default",
                           right = FALSE,
                           inline = FALSE,
                           width = NULL) {
  value <- restoreInput(id = inputId, default = value)
  status <- match.arg(arg = status, choices = c("default", "primary", "success", "info", "warning", "danger"))
  inputTag <- tags$input(id = inputId, type = "checkbox")
  if (!is.null(value) && value)
    inputTag$attribs$checked <- "checked"
  msTag <- tags$div(class = "form-group shiny-input-container", style = if (!is.null(width))
    paste0("width: ", validateCssUnit(width), ";"),
    class = if (inline) "shiny-input-container-inline",
    style = if (inline) "display: inline-block; margin-right: 10px;",
    # if (right) tags$span(label),
    # class = "material-switch",
    tags$div(
      class = "material-switch",
      if (!is.null(label) & !right) {
        tags$label(
          `for` = inputId,
          label,
          style = "padding-right: 10px;"
        )
      },
      inputTag,
      tags$label(
        class = "switch",
        `for` = inputId,
        class = paste0("label-", status),
        class = paste0("bg-", status)
      ),
      if (!is.null(label) & right) {
        tags$label(
          `for` = inputId,
          label,
          style = "padding-left: 5px;"
        )
      }
    )
  )
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
#' @seealso \code{\link{materialSwitch}}
#'
#' @export
updateMaterialSwitch <- function (session, inputId, value = NULL) {
  message <- dropNulls(list(value = value))
  session$sendInputMessage(inputId, message)
}

