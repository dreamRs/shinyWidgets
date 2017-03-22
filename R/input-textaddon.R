#' @title Text with Add-on Input Control
#'
#' @description
#' Create text field with add-on.
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label Input label.
#' @param value TRUE or FALSE.
#' @param placeholder A character string giving the user a hint as to what can be entered into the control.
#' @param addon An icon
#' @param width The width of the input : 'auto', 'fit', '100px', '75\%'
#' @return A switch control that can be added to a UI definition.
#'
#' @examples
#' \dontrun{
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
#' }
#'
#' @import shiny
#' @importFrom htmltools htmlDependency attachDependencies validateCssUnit
#'
#' @export



textInputAddon <- function (inputId, label, value = "", placeholder = NULL, addon, width = NULL)
{
  tagList(
    label %AND% tags$label(label, `for` = inputId),
    div(
      class = "input-group shiny-input-container", style = if (!is.null(width))
        paste0("width: ", htmltools::validateCssUnit(width), ";"),
      style = "margin-bottom: 5px;",
      addon %AND% tags$span(class="input-group-addon", addon),
      tags$input(
        id = inputId, type = "text", class = "form-control",
        value = value, placeholder = placeholder
      )
    )
  )
}
