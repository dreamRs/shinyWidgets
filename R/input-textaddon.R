#' @title Text with Add-on Input Control
#'
#' @description
#' Create text field with add-on.
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label Display label for the control, or \code{NULL} for no label.
#' @param value Initial value..
#' @param placeholder A character string giving the user a hint as to what can be entered into the control.
#' @param addon An icon tag, created by \link[shiny]{icon}.
#' @param width The width of the input : 'auto', 'fit', '100px', '75\%'
#' @return A switch control that can be added to a UI definition.
#'
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#' shinyApp(
#'   ui = fluidPage(
#'     textInputAddon(inputId = "id", label = "Label", placeholder = "Username", addon = icon("at")),
#'     verbatimTextOutput(outputId = "out")
#'   ),
#'   server = function(input, output) {
#'     output$out <- renderPrint({
#'       input$id
#'     })
#'   }
#' )
#' }
#'
#' @importFrom shiny restoreInput
#' @importFrom htmltools tags htmlDependency attachDependencies validateCssUnit
#'
#' @export
textInputAddon <- function (inputId, label, value = "", placeholder = NULL, addon, width = NULL)
{
  value <- shiny::restoreInput(id = inputId, default = value)
  htmltools::tags$div(
    class = "form-group shiny-input-container",
    label %AND% htmltools::tags$label(label, `for` = inputId),
    style = if (!is.null(width)) paste0("width: ", htmltools::validateCssUnit(width), ";"),
    htmltools::tags$div(
      style = "margin-bottom: 5px;", class="input-group",
      addon %AND% htmltools::tags$span(class="input-group-addon", addon),
      htmltools::tags$input(
        id = inputId, type = "text", class = "form-control",
        value = value, placeholder = placeholder
      )
    )
  )
}
