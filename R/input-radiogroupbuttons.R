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
#' @param checkIcon A list, if no empty must contain at least one element named 'yes' corresponding to an icon to display if the button is checked.
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
#' @import shiny
#' @importFrom htmltools htmlDependency attachDependencies
#'
#' @export


radioGroupButtons <- function(
  inputId, label = NULL, choices, selected = NULL, status = "default", size = "normal",
  direction = "horizontal", justified = FALSE, individual = FALSE, checkIcon = list()
) {
  choices <- choicesWithNames(choices)
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

  radioGroupButtonsTag <- tagList(
    tags$div(
      id=inputId, class="radioGroupButtons",
      if (!is.null(label)) tags$label(class="control-label", `for`=inputId, label),
      if (!is.null(label)) br(),
      style="margin-top: 3px; margin-bottom: 3px; ",
      style=if (justified) "width: 100%;",
      tags$div(
        class=divClass, role="group", `aria-label`="...", `data-toggle`="buttons",
        class = "btn-group-container-sw",
        generateRGB(inputId, choices, selected, status, size, checkIcon, individual)
      )
    )
  )
  # Dep
  attachShinyWidgetsDep(radioGroupButtonsTag)
}


generateRGB <- function(inputId, choices, selected, status, size, checkIcon, individual) {
  if (individual) {
    # div_class <- gsub(pattern = "btn-group ", replacement = "", x = div_class)
    btn_wrapper <- tagList
  } else {
    btn_wrapper <- function(...) {
      tags$div(
        class="btn-group",
        class=if (size != "normal") paste0("btn-group-", size),
        role="group",
        ...
      )
    }
  }
  if (!is.null(checkIcon) && !is.null(checkIcon$yes)) {
    displayIcon <- TRUE
  } else {
    displayIcon <- FALSE
  }
  lapply(
    X = seq_along(choices),
    FUN = function(i) {
      tags$div(
        class="btn-group",
        class=if (size != "normal") paste0("btn-group-", size),
        role="group",
        tags$button(
          class=paste0("btn radiobtn btn-", status),
          class=if (choices[i] %in% selected) "active",
          type="button",
          if (displayIcon) tags$span(class="radio-btn-icon-yes", checkIcon$yes),
          if (displayIcon) tags$span(class="radio-btn-icon-no", checkIcon$no),
          tags$input(
            type="radio", autocomplete="off", HTML(names(choices)[i]),
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
#' @param individual Individual buttons, only used if choices is not NULL.
#' @param checkIcon Icon, only used if choices is not NULL.
#'
#' @export
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
                                    individual = FALSE, checkIcon = list()) {
  if (!is.null(choices))
    choices <- choicesWithNames(choices)
  options <- if (!is.null(choices)) {
    format(tagList(generateRGB(inputId, choices, selected, status = status, size = size,
                                individual = individual, checkIcon = checkIcon)))
  }
  message <- dropNulls(list(selected = selected, options = options, label = label))
  session$sendInputMessage(inputId, message)
}

