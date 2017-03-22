
# ------------------------------------------------------------------------ #
#
# Descriptif : Awesome Radio
#        via : http://flatlogic.github.io/awesome-bootstrap-checkbox/demo/
#
#
# Auteurs : Victor PERRIER
#
# Date creation : 23/08/2016
# Date modification : 23/08/2016
#
# Version 1.0
#
# ------------------------------------------------------------------------ #




#' @title Awesome Checkbox Input Control
#'
#' @description
#' Create a Font Awesome Bootstrap checkbox that can be used to specify logical values.
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label Input label.
#' @param value Initial value (TRUE or FALSE).
#' @param status Color of the buttons
#' @param width The width of the input
#' @return A checkbox control that can be added to a UI definition.
#'
#' @examples
#' \dontrun{
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'
#' ui <- fluidPage(
#'  awesomeCheckboxGroup(
#'   inputId = "Id001",
#'   label = "Checkboxes with status",
#'   choices = c("A", "B", "C"),
#'   inline = TRUE, status = "danger"
#'  ),
#'  verbatimTextOutput("value")
#' )
#' server <- function(input, output) {
#'   output$value <- renderText({ input$somevalue })
#' }
#' shinyApp(ui, server)
#' }
#' }
#'
#' @import shiny
#' @importFrom htmltools htmlDependency attachDependencies
#'
#' @export

awesomeCheckbox <- function (inputId, label, value = FALSE, status = "primary", width = NULL)
{
  status <- match.arg(arg = status, choices = c("primary", "success", "info", "warning", "danger"))
  inputTag <- tags$input(id = inputId, type = "checkbox")
  if (!is.null(value) && value)
    inputTag$attribs$checked <- "checked"
  awesomeTag <- div(class = "form-group shiny-input-container", style = if (!is.null(width))
    paste0("width: ", validateCssUnit(width), ";"),
    div(class = paste0("checkboxbs checkbox-bs checkbox-bs-", status),
        style = "margin-top: 10px; margin-bottom: 10px;",
        inputTag,
        tags$label(tags$span(label, style = "font-weight: normal; cursor: pointer;"), `for` = inputId)))
  # Dep
  dep <- list(
    htmltools::htmlDependency(
      "awesomeRadioCheckbox", "0.1.0", c(href="shinyWidgets"),
      script = c("awesomeRadioCheckbox/awesomeCheckbox-bindings.js",
                 "awesomeRadioCheckbox/awesomeRadio-bindings.js"),
      stylesheet = "awesomeRadioCheckbox/css/awesome-bootstrap-checkbox-shiny.css"
    ),
    htmltools::htmlDependency(
      "font-awesome",
      "4.6.3", c(href = "shared/font-awesome"), stylesheet = "css/font-awesome.min.css"
    )
  )

  htmltools::attachDependencies(awesomeTag, dep)
}





# Generate several checkbox

generateAwesomeOptions <- function (inputId, choices, selected, inline, status)
{
  options <- mapply(choices, names(choices), FUN = function(value,
                                                            name) {
    inputTag <- tags$input(type = "checkbox", name = inputId, value = value, id = paste0(inputId, value))
    if (value %in% selected)
      inputTag$attribs$checked <- "checked"
    if (inline) {
      # tags$label(class = paste0("checkbox", "-inline"), inputTag,
      #            tags$span(name))
      tags$div(class = paste0("awesome-checkbox checkbox-bs checkbox-bs-inline checkbox-inline checkbox-bs-", status),
               style = "margin-top: -4px;",
               inputTag, tags$label(style = "font-weight: normal;", name, `for` = paste0(inputId, value)))
    }
    else {
      tags$div(class = paste0("awesome-checkbox checkbox-bs checkbox-bs-", status),
               style = "margin-top: -3px;",
               inputTag, tags$label(style = "font-weight: normal;", name, `for` = paste0(inputId, value)))
    }
  }, SIMPLIFY = FALSE, USE.NAMES = FALSE)
  div(class = "shiny-options-group", options)
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
#'
#' @import shiny
#' @importFrom htmltools htmlDependency attachDependencies
#'
#' @export

awesomeCheckboxGroup <- function (inputId, label, choices, selected = NULL, inline = FALSE, status = "primary",
          width = NULL)
{
  choices <- choicesWithNames(choices)
  if (!is.null(selected))
    selected <- validateSelected(selected, choices, inputId)
  options <- generateAwesomeOptions(inputId, choices, selected, inline, status = status)
  divClass <- "form-group shiny-input-checkboxgroup shiny-input-container"
  if (inline)
    divClass <- paste(divClass, "shiny-input-container-inline")
  awesomeTag <- tags$div(id = inputId, style = if (!is.null(width))
    paste0("width: ", validateCssUnit(width), ";"), class = divClass,
    tags$label(label, `for` = inputId, style = "margin-bottom: 10px;"), options)
  # Dep
  dep <- list(
    htmltools::htmlDependency(
      "awesomeRadioCheckbox", "0.1.0", c(href="shinyWidgets"),
      script = c("awesomeRadioCheckbox/awesomeCheckbox-bindings.js",
                 "awesomeRadioCheckbox/awesomeRadio-bindings.js"),
      stylesheet = "awesomeRadioCheckbox/css/awesome-bootstrap-checkbox-shiny.css"
    ),
    htmltools::htmlDependency(
      "font-awesome",
      "4.6.3", c(href = "shared/font-awesome"), stylesheet = "css/font-awesome.min.css"
    )
  )

  htmltools::attachDependencies(awesomeTag, dep)
}









#' @title Change the value of a radio input on the client
#'
#' @description
#' Change the value of a radio input on the client
#'
#'
#' @param session The session object passed to function given to shinyServer.
#' @param inputId The id of the input object.
#' @param label Input label.
#' @param choices List of values to show checkboxes for.
#' @param selected The values that should be initially selected, if any.
#' @param inline If TRUE, render the choices inline (i.e. horizontally)
#' @param status Color of the buttons
#'
#' @export


updateAwesomeCheckboxGroup <- function (session, inputId, label = NULL, choices = NULL, selected = NULL,
          inline = FALSE, status = "primary")
{
  if (is.null(selected) && !is.null(choices))
    selected <- choices[[1]]
  if (!is.null(choices))
    choices <- choicesWithNames(choices)
  if (!is.null(selected))
    selected <- validateSelected(selected, choices, inputId)
  options <- if (!is.null(choices)) {
    format(tagList(generateAwesomeOptions(inputId, choices, selected, inline, status)))
  }
  message <- dropNulls(list(label = label, options = options,
                            value = selected))
  session$sendInputMessage(inputId, message)
}



updateAwesomeCheckbox <- shiny::updateCheckboxInput


