
# ------------------------------------------------------------------------ #
#
# Descriptif : Bootstrap Switch : fonctions R
#     Detail : http://www.bootstrap-switch.org/examples.html
#
#
# Auteur : Victor PERRIER
#
# Date creation : 01/07/2016
# Date modification : 01/07/2016
#
# Version 1.0
#
# ------------------------------------------------------------------------ #




#' @title Bootstrap Switch Input Control
#'
#' @description
#' Create a toggle switch.
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label Display a text in the center of the switch.
#' @param value Initial value (TRUE or FALSE).
#' @param onLabel Text on the left side of the switch (TRUE)
#' @param offLabel Text on the right side of the switch (FALSE)
#' @param onStatus Color (bootstrap status) of the left side of the switch (TRUE)
#' @param offStatus Color (bootstrap status) of the right side of the switch (FALSE)
#' @param size Size of the buttons ('default', 'mini', 'small', 'normal', 'large')
#' @param disabled Logical. Disable the switch
#' @return A switch control that can be added to a UI definition.
#'
#'
#' @examples
#' \dontrun{
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'
#' ui <- fluidPage(
#'   switchInput(inputId = "somevalue"),
#'   verbatimTextOutput("value")
#' )
#' server <- function(input, output) {
#'   output$value <- renderPrint({ input$somevalue })
#' }
#' shinyApp(ui, server)
#' }
#' }
#'
#' @import shiny
#' @importFrom htmltools htmlDependency attachDependencies
#'
#' @export


switchInput <- function(inputId, label = NULL, value = FALSE, onLabel = 'ON', offLabel = 'OFF',
                        onStatus = NULL, offStatus = NULL, size = "default", disabled = FALSE) {
  size <- match.arg(arg = size, choices = c('default', 'mini', 'small', 'normal', 'large'))
  switchProps <- dropNulls(
    list(
      id = inputId, type = "checkbox", class = "switchInput", `data-input-id` = inputId,
      `data-on-text` = onLabel, `data-off-text` = offLabel, `data-label-text` = label,
      `data-on-color` = onStatus, `data-off-color` = offStatus, #`data-state` = value,
      `disabled` =  if (!disabled) NULL else disabled,
      `data-size` = if (size == "default") "" else size
    )
  )
  switchProps <- lapply(switchProps, function(x) {
    if (identical(x, TRUE))
      "true"
    else if (identical(x, FALSE))
      "false"
    else x
  })
  inputTag <- do.call(tags$input, switchProps)
  if (!is.null(value) && value)
    inputTag$attribs$checked <- "checked"
  switchInputTag <- tagList(
    tags$div(
      style = "margin: 3px;", class = "shiny-input-container",
      inputTag,
      tags$script(paste0('$("#', inputId, '").bootstrapSwitch();'))
    )
  )
  # Dep
  attachShinyWidgetsDep(switchInputTag, "bsswitch")
}



#' @title Change the value of a switch input on the client
#'
#' @description
#' Change the value of a switch input on the client
#'
#' @param session The session object passed to function given to shinyServer.
#' @param inputId	The id of the input object.
#' @param value TRUE or FALSE.
#'
#' @export


updateSwitchInput <- function(session, inputId, value = NULL) {
  message <- dropNulls(list(value = value))
  session$sendInputMessage(inputId, message)
}


