#' @title Buttons Group checkbox Input Control
#'
#' @description
#' Create buttons grouped that act like checkboxes.
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label Input label.
#' @param choices List of values to select from (if elements of the list are named
#'  then that name rather than the value is displayed to the user)
#' @param selected The initially selected value.
#' @param status Add a class to the buttons, you can use Bootstrap status like 'info', 'primary', 'danger', 'warning' or 'success'.
#'  Or use an arbitrary strings to add a custom class, e.g. : with \code{status = 'myClass'}, buttons will have class \code{btn-myClass}.
#' @param size Size of the buttons ('xs', 'sm', 'normal', 'lg')
#' @param direction Horizontal or vertical.
#' @param justified If TRUE, fill the width of the parent div.
#' @param individual If TRUE, buttons are separated.
#' @param checkIcon A list, if no empty must contain at least one element named 'yes'
#' corresponding to an icon to display if the button is checked.
#' @param width The width of the input, e.g. '400px', or '100\%'.
#' @param choiceNames,choiceValues Same as in \code{\link[shiny]{checkboxGroupInput}}. List of names and values, respectively, that are displayed to
#'  the user in the app and correspond to the each choice (for this reason,
#'  \code{choiceNames} and \code{choiceValues} must have the same length).
#'
#' @return A buttons group control that can be added to a UI definition.
#'
#' @seealso \code{\link{updateCheckboxGroupButtons}}
#'
#' @importFrom shiny restoreInput
#' @importFrom htmltools tags HTML validateCssUnit
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'
#'   ui <- fluidPage(
#'     tags$h1("checkboxGroupButtons examples"),
#'
#'     checkboxGroupButtons(
#'       inputId = "somevalue1",
#'       label = "Make a choice: ",
#'       choices = c("A", "B", "C")
#'     ),
#'     verbatimTextOutput("value1"),
#'
#'     checkboxGroupButtons(
#'       inputId = "somevalue2",
#'       label = "With custom status:",
#'       choices = names(iris),
#'       status = "primary"
#'     ),
#'     verbatimTextOutput("value2"),
#'
#'     checkboxGroupButtons(
#'       inputId = "somevalue3",
#'       label = "With icons:",
#'       choices = names(mtcars),
#'       checkIcon = list(
#'         yes = icon("check-square"),
#'         no = icon("square-o")
#'       )
#'     ),
#'     verbatimTextOutput("value3")
#'   )
#'   server <- function(input, output) {
#'
#'     output$value1 <- renderPrint({ input$somevalue1 })
#'     output$value2 <- renderPrint({ input$somevalue2 })
#'     output$value3 <- renderPrint({ input$somevalue3 })
#'
#'   }
#'   shinyApp(ui, server)
#'
#' }
checkboxGroupButtons <- function(
  inputId, label = NULL, choices = NULL, selected = NULL, status = "default", size = "normal",
  direction = "horizontal", justified = FALSE, individual = FALSE, checkIcon = list(),
  width = NULL, choiceNames = NULL, choiceValues = NULL
) {
  args <- normalizeChoicesArgs(choices, choiceNames, choiceValues)
  selected <- shiny::restoreInput(id = inputId, default = selected)
  size <- match.arg(arg = size, choices = c("xs", "sm", "normal", "lg"))
  direction <- match.arg(arg = direction, choices = c("horizontal", "vertical"))

  divClass <- if (individual) "" else "btn-group"
  if (!individual & direction == "vertical") {
    divClass <- paste0(divClass, "-vertical")
  }
  if (justified) {
    if (direction != "vertical") {
      divClass <- paste(divClass, "btn-group-justified")
    } else {
      divClass <- paste(divClass, "btn-block")
    }
  }
  if (size != "normal") {
    divClass <- paste0(divClass, " btn-group-", size)
  }
  checkboxGroupButtonsTag <- htmltools::tags$div(
    class="form-group shiny-input-container shiny-input-checkboxgroup shiny-input-container-inline",
    style = if(!is.null(width)) paste("width:", htmltools::validateCssUnit(width)),
    if (!is.null(label)) htmltools::tags$label(class="control-label", `for`=inputId, label),
    if (!is.null(label)) htmltools::tags$br(),
    htmltools::tags$div(
      id=inputId, class="checkboxGroupButtons",
      style=if (justified) "width: 100%;",
      htmltools::tags$div(
        class=divClass, role="group", `aria-label`="...", `data-toggle`="buttons",
        class = "btn-group-container-sw",
        generateCBGB(inputId, args, selected, status, size, checkIcon)
      )
    )
  )
  # Dep
  attachShinyWidgetsDep(checkboxGroupButtonsTag)
}





generateCBGB <- function(inputId, choices, selected, status, size, checkIcon) {
  btn_wrapper <- function(...) {
    htmltools::tags$div(
      class="btn-group btn-group-toggle",
      class=if (size != "normal") paste0("btn-group-", size),
      role="group",
      ...
    )
  }
  if (!is.null(checkIcon) && !is.null(checkIcon$yes)) {
    displayIcon <- TRUE
  } else {
    displayIcon <- FALSE
  }
  mapply(
    FUN = function(name, value) {
      btn_wrapper(
        htmltools::tags$button(
          class=paste0("btn checkbtn btn-", status),
          class=if (value %in% selected) "active",
          if (displayIcon) htmltools::tags$span(class="check-btn-icon-yes", checkIcon$yes),
          if (displayIcon) htmltools::tags$span(class="check-btn-icon-no", checkIcon$no),
          htmltools::tags$input(
            type="checkbox", autocomplete="off",
            name=inputId, value=value,
            checked=if (value %in% selected) "checked"
          ),
          if (is.list(name)) name else htmltools::HTML(name)
        )
      )
    },
    name = choices$choiceNames, value = choices$choiceValues,
    SIMPLIFY = FALSE, USE.NAMES = FALSE
  )
}




#' @title Change the value of a checkboxes group buttons input on the client
#'
#' @description
#' Change the value of a radio group buttons input on the client
#'
#' @param session The session object passed to function given to shinyServer.
#' @param inputId	The id of the input object.
#' @param selected The values selected.
#' @param label The label to set.
#' @param choices The new choices for the input.
#' @param status Status, only used if choices is not NULL.
#' @param size Size, only used if choices is not NULL.
#' @param checkIcon Icon, only used if choices is not NULL.
#' @param choiceNames,choiceValues List of names and values, an alternative to choices.
#'
#' @export
#'
#' @importFrom htmltools tagList
#'
#' @seealso \code{\link{checkboxGroupButtons}}
#'
#' @examples
#' if (interactive()) {
#'
#' library(shiny)
#' library(shinyWidgets)
#'
#' # Example 1 ----
#'
#' ui <- fluidPage(
#'
#'   radioButtons(inputId = "up", label = "Update button :", choices = c("All", "None")),
#'
#'   checkboxGroupButtons(
#'     inputId = "btn", label = "Power :",
#'     choices = c("Nuclear", "Hydro", "Solar", "Wind"),
#'     selected = "Hydro"
#'   ),
#'
#'   verbatimTextOutput(outputId = "res")
#'
#' )
#'
#' server <- function(input,output, session){
#'
#'   observeEvent(input$up, {
#'     if (input$up == "All"){
#'       updateCheckboxGroupButtons(session, "btn", selected = c("Nuclear", "Hydro", "Solar", "Wind"))
#'     } else {
#'       updateCheckboxGroupButtons(session, "btn", selected = character(0))
#'     }
#'   }, ignoreInit = TRUE)
#'
#'   output$res <- renderPrint({
#'     input$btn
#'   })
#' }
#'
#' shinyApp(ui = ui, server = server)
#'
#'
#' # Example 2 ----
#'
#' library("shiny")
#' library("shinyWidgets")
#'
#' ui <- fluidPage(
#'   checkboxGroupButtons(
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
#'     choices = c("A", "B", "C"), multiple = TRUE
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
#'     updateCheckboxGroupButtons(
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
#'     updateCheckboxGroupButtons(
#'       session = session, inputId = "somevalue",
#'       selected = input$updateselected
#'     )
#'   }, ignoreNULL = TRUE, ignoreInit = TRUE)
#'
#'   observeEvent(input$updatelabel, {
#'     updateCheckboxGroupButtons(
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
updateCheckboxGroupButtons <- function(session, inputId, label = NULL, choices = NULL, selected = NULL,
                                       status = "default", size = "normal",
                                       checkIcon = list(), choiceNames = NULL, choiceValues = NULL) {
  args <- normalizeChoicesArgs(choices, choiceNames, choiceValues, mustExist = FALSE)
  options <- if (!is.null(args$choiceNames)) {
    format(htmltools::tagList(generateCBGB(session$ns(inputId), args, selected, status = status, size = size,
                                checkIcon = checkIcon)))
  }
  message <- dropNulls(list(selected = selected, options = options, label = label))
  session$sendInputMessage(inputId, message)
}

