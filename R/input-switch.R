#' @title Bootstrap Switch Input Control
#'
#' @description
#' Create a toggle switch.
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label Display a text in the center of the switch.
#' @param value Initial value (TRUE or FALSE).
#' @param onLabel Text on the left side of the switch (TRUE).
#' @param offLabel Text on the right side of the switch (FALSE).
#' @param onStatus Color (bootstrap status) of the left side of the switch (TRUE).
#' @param offStatus Color (bootstrap status) of the right side of the switch (FALSE).
#' @param size Size of the buttons ('default', 'mini', 'small', 'normal', 'large').
#' @param labelWidth Width of the center handle in pixels.
#' @param handleWidth Width of the left and right sides in pixels.
#' @param disabled Logical, display the toggle switch in disabled state?.
#' @param inline Logical, display the toggle switch inline?
#' @param width The width of the input : 'auto', 'fit', '100px', '75%'.
#'
#' @return A switch control that can be added to a UI definition.
#'
#'
#' @importFrom shiny restoreInput
#' @importFrom htmltools tags validateCssUnit attachDependencies findDependencies
#'
#' @export
#'
#'
#' @note For more information, see the project on Github
#'  \url{https://github.com/Bttstrp/bootstrap-switch}.
#'
#' @seealso \code{\link{updateSwitchInput}}, \code{\link{materialSwitch}}
#'
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'
#' # Examples in the gallery :
#' shinyWidgets::shinyWidgetsGallery()
#'
#' # Basic usage :
#' ui <- fluidPage(
#'   switchInput(inputId = "somevalue"),
#'   verbatimTextOutput("value")
#' )
#' server <- function(input, output) {
#'   output$value <- renderPrint({ input$somevalue })
#' }
#' shinyApp(ui, server)
#' }
switchInput <- function(inputId,
                        label = NULL,
                        value = FALSE,
                        onLabel = "ON",
                        offLabel = "OFF",
                        onStatus = NULL,
                        offStatus = NULL,
                        size = "default",
                        labelWidth = "auto",
                        handleWidth = "auto",
                        disabled = FALSE,
                        inline = FALSE,
                        width = NULL) {
  value <- shiny::restoreInput(id = inputId, default = value)
  size <- match.arg(arg = size, choices = c('default', 'mini', 'small', 'normal', 'large'))
  switchProps <- dropNulls(
    list(
      id = inputId,
      type = "checkbox",
      class = "sw-switchInput",
      `data-input-id` = inputId,
      `data-on-text` = onLabel,
      `data-off-text` = offLabel,
      `data-label-text` = label,
      `data-on-color` = onStatus,
      `data-off-color` = offStatus,
      #`data-state` = value,
      `data-label-width` = labelWidth,
      `data-handle-width` = handleWidth,
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
  inputTag <- do.call(htmltools::tags$input, switchProps)
  if (!is.null(value) && value)
    inputTag$attribs$checked <- "checked"
  switchInputTag <- htmltools::tags$div(
    class = "form-group shiny-input-container",
    class = if (inline) "shiny-input-container-inline",
    style = if (inline) "display: inline-block;",
    style = if (!is.null(width)) paste0("width: ", htmltools::validateCssUnit(width), ";"),
    inputTag
  )
  # Dependencies
  switchInputTag <- attachDependencies(
    switchInputTag,
    htmltools::findDependencies(tagList(label, offLabel, onLabel))
  )
  attachShinyWidgetsDep(switchInputTag, "bsswitch")
}



#' @title Change the value of a switch input on the client
#'
#' @description
#' Change the value of a switch input on the client
#'
#' @param session The session object passed to function given to shinyServer.
#' @param inputId    The id of the input object.
#' @param value The value to set for the input object.
#' @param label The label to set for the input object.
#' @param onLabel The onLabel to set for the input object.
#' @param offLabel The offLabel to set for the input object.
#' @param onStatus The onStatus to set for the input object.
#' @param offStatus The offStatus to set for the input object.
#' @param disabled Logical, disable state.
#'
#' @export
#'
#' @seealso \code{\link{switchInput}}
#'
#' @examples
#' if (interactive()) {
#'   library("shiny")
#'   library("shinyWidgets")
#'
#'
#'   ui <- fluidPage(
#'     tags$h1("Update", tags$code("switchInput")),
#'     br(),
#'     fluidRow(
#'       column(
#'         width = 4,
#'         panel(
#'           switchInput(inputId = "switch1"),
#'           verbatimTextOutput(outputId = "resup1"),
#'           tags$div(
#'             class = "btn-group",
#'             actionButton(
#'               inputId = "updatevaluetrue",
#'               label = "Set to TRUE"
#'             ),
#'             actionButton(
#'               inputId = "updatevaluefalse",
#'               label = "Set to FALSE"
#'             )
#'           ),
#'           heading = "Update value"
#'         )
#'       ),
#'
#'       column(
#'         width = 4,
#'         panel(
#'           switchInput(inputId = "switch2",
#'                       label = "My label"),
#'           verbatimTextOutput(outputId = "resup2"),
#'           textInput(inputId = "updatelabeltext",
#'                     label = "Update label:"),
#'           heading = "Update label"
#'         )
#'       ),
#'
#'       column(
#'         width = 4,
#'         panel(
#'           switchInput(
#'             inputId = "switch3",
#'             onLabel = "Yeaah",
#'             offLabel = "Noooo"
#'           ),
#'           verbatimTextOutput(outputId = "resup3"),
#'           fluidRow(column(
#'             width = 6,
#'             textInput(inputId = "updateonLabel",
#'                       label = "Update onLabel:")
#'           ),
#'           column(
#'             width = 6,
#'             textInput(inputId = "updateoffLabel",
#'                       label = "Update offLabel:")
#'           )),
#'           heading = "Update onLabel & offLabel"
#'         )
#'       )
#'     ),
#'
#'     fluidRow(column(
#'       width = 4,
#'       panel(
#'         switchInput(inputId = "switch4"),
#'         verbatimTextOutput(outputId = "resup4"),
#'         fluidRow(
#'           column(
#'             width = 6,
#'             pickerInput(
#'               inputId = "updateonStatus",
#'               label = "Update onStatus:",
#'               choices = c("default", "primary", "success",
#'                           "info", "warning", "danger")
#'             )
#'           ),
#'           column(
#'             width = 6,
#'             pickerInput(
#'               inputId = "updateoffStatus",
#'               label = "Update offStatus:",
#'               choices = c("default", "primary", "success",
#'                           "info", "warning", "danger")
#'             )
#'           )
#'         ),
#'         heading = "Update onStatus & offStatusr"
#'       )
#'     ),
#'
#'     column(
#'       width = 4,
#'       panel(
#'         switchInput(inputId = "switch5"),
#'         verbatimTextOutput(outputId = "resup5"),
#'         checkboxInput(
#'           inputId = "disabled",
#'           label = "Disabled",
#'           value = FALSE
#'         ),
#'         heading = "Disabled"
#'       )
#'     ))
#'
#'   )
#'
#'   server <- function(input, output, session) {
#'     # Update value
#'     observeEvent(input$updatevaluetrue, {
#'       updateSwitchInput(session = session,
#'                         inputId = "switch1",
#'                         value = TRUE)
#'     })
#'     observeEvent(input$updatevaluefalse, {
#'       updateSwitchInput(session = session,
#'                         inputId = "switch1",
#'                         value = FALSE)
#'     })
#'     output$resup1 <- renderPrint({
#'       input$switch1
#'     })
#'
#'
#'     # Update label
#'     observeEvent(input$updatelabeltext, {
#'       updateSwitchInput(
#'         session = session,
#'         inputId = "switch2",
#'         label = input$updatelabeltext
#'       )
#'     }, ignoreInit = TRUE)
#'     output$resup2 <- renderPrint({
#'       input$switch2
#'     })
#'
#'
#'     # Update onLabel & offLabel
#'     observeEvent(input$updateonLabel, {
#'       updateSwitchInput(
#'         session = session,
#'         inputId = "switch3",
#'         onLabel = input$updateonLabel
#'       )
#'     }, ignoreInit = TRUE)
#'     observeEvent(input$updateoffLabel, {
#'       updateSwitchInput(
#'         session = session,
#'         inputId = "switch3",
#'         offLabel = input$updateoffLabel
#'       )
#'     }, ignoreInit = TRUE)
#'     output$resup3 <- renderPrint({
#'       input$switch3
#'     })
#'
#'
#'     # Update onStatus & offStatus
#'     observeEvent(input$updateonStatus, {
#'       updateSwitchInput(
#'         session = session,
#'         inputId = "switch4",
#'         onStatus = input$updateonStatus
#'       )
#'     }, ignoreInit = TRUE)
#'     observeEvent(input$updateoffStatus, {
#'       updateSwitchInput(
#'         session = session,
#'         inputId = "switch4",
#'         offStatus = input$updateoffStatus
#'       )
#'     }, ignoreInit = TRUE)
#'     output$resup4 <- renderPrint({
#'       input$switch4
#'     })
#'
#'
#'     # Disabled
#'     observeEvent(input$disabled, {
#'       updateSwitchInput(
#'         session = session,
#'         inputId = "switch5",
#'         disabled = input$disabled
#'       )
#'     }, ignoreInit = TRUE)
#'     output$resup5 <- renderPrint({
#'       input$switch5
#'     })
#'
#'   }
#'
#'   shinyApp(ui = ui, server = server)
#'
#' }
updateSwitchInput <- function(session = getDefaultReactiveDomain(),
                              inputId,
                              value = NULL, label = NULL,
                              onLabel = NULL, offLabel = NULL,
                              onStatus = NULL, offStatus = NULL,
                              disabled = NULL) {
  message <- dropNulls(
    list(value = value, label = label,
         onLabel = onLabel, offLabel = offLabel,
         onStatus = onStatus, offStatus = offStatus,
         disabled = disabled)
  )
  session$sendInputMessage(inputId, message)
}
