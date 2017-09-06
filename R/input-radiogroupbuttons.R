#' @title Buttons Group Radio Input Control
#'
#' @description
#' Create buttons grouped that act like radio buttons.
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label Input label.
#' @param choices List of values to select from (if elements of the list are named then that name rather than the value is displayed to the user).
#' @param selected The initially selected value.
#' @param status Color of the buttons
#' @param size Size of the buttons ('xs', 'sm', 'normal', 'lg')
#' @param direction Horizontal or vertical
#' @param justified If TRUE, fill the width of the parent div
#' @param individual If TRUE, buttons are separated.
#' @param checkIcon A list, if no empty must contain at least one element named 'yes'
#'  corresponding to an icon to display if the button is checked.
#' @param width The width of the input, e.g. '400px', or '100\%'.
#'
#'
#' @return A buttons group control that can be added to a UI definition.
#'
#'
#' @examples
#' \dontrun{
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'
#' ui <- fluidPage(
#'   radioGroupButtons(inputId = "somevalue", choices = c("A", "B", "C")),
#'   verbatimTextOutput("value")
#' )
#' server <- function(input, output) {
#'   output$value <- renderText({ input$somevalue })
#' }
#' shinyApp(ui, server)
#' }
#' }
#'
#' @importFrom shiny restoreInput
#' @importFrom htmltools tags HTML validateCssUnit
#'
#' @export


radioGroupButtons <- function(
  inputId, label = NULL, choices, selected = NULL, status = "default", size = "normal",
  direction = "horizontal", justified = FALSE, individual = FALSE, checkIcon = list(),
  width = NULL
) {
  choices <- choicesWithNames(choices)
  selected <- shiny::restoreInput(id = inputId, default = selected)
  if (!is.null(selected) && length(selected) > 1)
    stop("selected must be length 1")
  if (is.null(selected))
    selected <- choices[1]
  size <- match.arg(arg = size, choices = c("xs", "sm", "normal", "lg"))
  direction <- match.arg(arg = direction, choices = c("horizontal", "vertical"))
  status <- match.arg(arg = status, choices = c("default", "primary", "success", "info", "warning", "danger"))

  divClass <- if (individual) "" else "btn-group"
  if (!individual & direction == "vertical") {
    divClass <- paste0(divClass, "-vertical")
  }
  if (justified) {
    divClass <- paste(divClass, "btn-group-justified")
  }
  if (size != "normal") {
    divClass <- paste0(divClass, " btn-group-", size)
  }

  radioGroupButtonsTag <- htmltools::tags$div(
    class="form-group shiny-input-container shiny-input-radiogroup shiny-input-container-inline",
    style = if(!is.null(width)) paste("width:", htmltools::validateCssUnit(width)),
    if (!is.null(label)) htmltools::tags$label(class="control-label", `for`=inputId, label),
    if (!is.null(label)) htmltools::tags$br(),
    htmltools::tags$div(
      id=inputId, class="radioGroupButtons",
      style="margin-top: 3px; margin-bottom: 3px; ",
      style=if (justified) "width: 100%;",
      htmltools::tags$div(
        class=divClass, role="group", `aria-label`="...", `data-toggle`="buttons",
        class = "btn-group-container-sw",
        generateRGB(inputId, choices, selected, status, size, checkIcon)
      )
    )
  )
  # Dep
  attachShinyWidgetsDep(radioGroupButtonsTag)
}


generateRGB <- function(inputId, choices, selected, status, size, checkIcon) {
  if (!is.null(checkIcon) && !is.null(checkIcon$yes)) {
    displayIcon <- TRUE
  } else {
    displayIcon <- FALSE
  }
  lapply(
    X = seq_along(choices),
    FUN = function(i) {
      htmltools::tags$div(
        class="btn-group",
        class=if (size != "normal") paste0("btn-group-", size),
        role="group",
        htmltools::tags$button(
          class=paste0("btn radiobtn btn-", status),
          class=if (choices[i] %in% selected) "active",
          type="button",
          if (displayIcon) htmltools::tags$span(class="radio-btn-icon-yes", checkIcon$yes),
          if (displayIcon) htmltools::tags$span(class="radio-btn-icon-no", checkIcon$no),
          htmltools::tags$input(
            type="radio", autocomplete="off", htmltools::HTML(names(choices)[i]),
            name=inputId, value=choices[i],
            checked=if (choices[i] %in% selected) "checked"
          )
        )
      )
    }
  )
}




#' @title Change the value of a radio group buttons input on the client
#'
#' @description
#' Change the value of a radio group buttons input on the client
#'
#' @param session The session object passed to function given to shinyServer.
#' @param inputId	The id of the input object.
#' @param selected The value selected.
#' @param label The label to set.
#' @param choices The new choices for the input.
#' @param status Status, only used if choices is not NULL.
#' @param size Size, only used if choices is not NULL.
#' @param checkIcon Icon, only used if choices is not NULL.
#'
#' @export
#'
#' @importFrom htmltools tagList
#'
#' @examples
#' \dontrun{
#'
#' if (interactive()) {
#'
#' library("shiny")
#' library("shinyWidgets")
#'
#' ui <- fluidPage(
#'   radioGroupButtons(
#'     inputId = "somevalue",
#'     choices = c("A", "B", "C"),
#'     label = "My label"
#'   ),
#'
#'   verbatimTextOutput(outputId = "res"),
#'
#'   actionButton(inputId = "updatechoices", label = "Random choices"),
#'   pickerInput(
#'     inputId = "updateselected", label = "Update selected:",
#'     choices = c("A", "B", "C"), multiple = FALSE
#'   ),
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
#'     newchoices <- sample(letters, sample(2:6))
#'     updateRadioGroupButtons(
#'       session = session, inputId = "somevalue",
#'       choices = newchoices
#'     )
#'     updatePickerInput(
#'       session = session, inputId = "updateselected",
#'       choices = newchoices
#'     )
#'   })
#'
#'   observeEvent(input$updateselected, {
#'     updateRadioGroupButtons(
#'       session = session, inputId = "somevalue",
#'       selected = input$updateselected
#'     )
#'   }, ignoreNULL = TRUE, ignoreInit = TRUE)
#'
#'   observeEvent(input$updatelabel, {
#'     updateRadioGroupButtons(
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
#'
#' }
updateRadioGroupButtons <- function(session, inputId, label = NULL, choices = NULL, selected = NULL,
                                    status = "default", size = "normal",
                                    checkIcon = list()) {
  if (is.null(selected) && !is.null(choices))
    selected <- choices[[1]]
  if (!is.null(choices))
    choices <- choicesWithNames(choices)
  options <- if (!is.null(choices)) {
    format(htmltools::tagList(generateRGB(inputId, choices, selected, status = status, size = size,
                               checkIcon = checkIcon)))
  }
  message <- dropNulls(list(selected = selected, options = options, label = label))
  session$sendInputMessage(inputId, message)
}

