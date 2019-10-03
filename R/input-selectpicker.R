#' @title Select picker Input Control
#'
#' @description
#' Create a select picker (\url{https://developer.snapappointments.com/bootstrap-select/})
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label Display label for the control, or \code{NULL} for no label.
#' @param choices List of values to select from. If elements of the
#'  list are named then that name rather than the value is displayed to the user.
#' @param selected The initially selected value (or multiple values if \code{multiple = TRUE}).
#' If not specified then defaults to the first value for single-select lists
#'  and no values for multiple select lists.
#' @param multiple Is selection of multiple items allowed?
#' @param options List of options, see \link{pickerOptions} for all available options.
#' To limit the number of selection possible, see example below.
#' @param choicesOpt Options for choices in the dropdown menu.
#' @param width The width of the input : 'auto', 'fit', '100px', '75\%'.
#' @param inline Put the label and the picker on the same line.
#'
#' @seealso \link{updatePickerInput} to update value server-side.
#'
#' @return A select control that can be added to a UI definition.
#'
#'
#' @examples
#' \dontrun{
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'
#' # You can run the gallery to see other examples
#' shinyWidgetsGallery()
#'
#'
#' # Simple example
#' library("shiny")
#' ui <- fluidPage(
#'   pickerInput(inputId = "somevalue", label = "A label", choices = c("a", "b")),
#'   verbatimTextOutput("value")
#' )
#' server <- function(input, output) {
#'   output$value <- renderPrint({ input$somevalue })
#' }
#' shinyApp(ui, server)
#'
#'
#' ### Add actions box for selecting
#' # deselecting all options
#'
#' library("shiny")
#' library("shinyWidgets")
#'
#' ui <- fluidPage(
#'   br(),
#'   pickerInput(
#'     inputId = "p1",
#'     label = "Select all option",
#'     choices = rownames(mtcars),
#'     multiple = TRUE,
#'     options = list(`actions-box` = TRUE)
#'   ),
#'   br(),
#'   pickerInput(
#'     inputId = "p2",
#'     label = "Select all option / custom text",
#'     choices = rownames(mtcars),
#'     multiple = TRUE,
#'     options = list(
#'       `actions-box` = TRUE,
#'       `deselect-all-text` = "None...",
#'       `select-all-text` = "Yeah, all !",
#'       `none-selected-text` = "zero"
#'     )
#'   )
#' )
#'
#' server <- function(input, output, session) {
#'
#' }
#'
#' shinyApp(ui = ui, server = server)
#'
#'
#'
#' ### Customize the values displayed in the box ----
#'
#' library("shiny")
#' library("shinyWidgets")
#'
#' ui <- fluidPage(
#'   br(),
#'   pickerInput(
#'     inputId = "p1",
#'     label = "Default",
#'     multiple = TRUE,
#'     choices = rownames(mtcars),
#'     selected = rownames(mtcars)[1:5]
#'   ),
#'   br(),
#'   pickerInput(
#'     inputId = "p1b",
#'     label = "Default with | separator",
#'     multiple = TRUE,
#'     choices = rownames(mtcars),
#'     selected = rownames(mtcars)[1:5],
#'     options = list(`multiple-separator` = " | ")
#'   ),
#'   br(),
#'   pickerInput(
#'     inputId = "p2",
#'     label = "Static",
#'     multiple = TRUE,
#'     choices = rownames(mtcars),
#'     selected = rownames(mtcars)[1:5],
#'     options = list(`selected-text-format`= "static",
#'                    title = "Won't change")
#'   ),
#'   br(),
#'   pickerInput(
#'     inputId = "p3",
#'     label = "Count",
#'     multiple = TRUE,
#'     choices = rownames(mtcars),
#'     selected = rownames(mtcars)[1:5],
#'     options = list(`selected-text-format`= "count")
#'   ),
#'   br(),
#'   pickerInput(
#'     inputId = "p3",
#'     label = "Customize count",
#'     multiple = TRUE,
#'     choices = rownames(mtcars),
#'     selected = rownames(mtcars)[1:5],
#'     options = list(
#'       `selected-text-format`= "count",
#'       `count-selected-text` = "{0} models choosed (on a total of {1})"
#'     )
#'   )
#' )
#'
#' server <- function(input, output, session) {
#'
#' }
#'
#' shinyApp(ui = ui, server = server)
#'
#'
#'
#' ### Limit the number of selections ----
#'
#' library(shiny)
#' library(shinyWidgets)
#' ui <- fluidPage(
#'   pickerInput(
#'     inputId = "groups",
#'     label = "Select one from each group below:",
#'     choices = list(
#'       Group1 = c("1", "2", "3", "4"),
#'       Group2 = c("A", "B", "C", "D")
#'     ),
#'     multiple = TRUE,
#'     options =  list("max-options-group" = 1)
#'   ),
#'   verbatimTextOutput(outputId = "res_grp"),
#'   pickerInput(
#'     inputId = "groups_2",
#'     label = "Select two from each group below:",
#'     choices = list(
#'       Group1 = c("1", "2", "3", "4"),
#'       Group2 = c("A", "B", "C", "D")
#'     ),
#'     multiple = TRUE,
#'     options =  list("max-options-group" = 2)
#'   ),
#'   verbatimTextOutput(outputId = "res_grp_2"),
#'   pickerInput(
#'     inputId = "classic",
#'     label = "Select max two option below:",
#'     choices = c("A", "B", "C", "D"),
#'     multiple = TRUE,
#'     options =  list(
#'       "max-options" = 2,
#'       "max-options-text" = "No more!"
#'     )
#'   ),
#'   verbatimTextOutput(outputId = "res_classic")
#' )
#' server <- function(input, output) {
#'   output$res_grp <- renderPrint(input$groups)
#'   output$res_grp_2 <- renderPrint(input$groups_2)
#'   output$res_classic <- renderPrint(input$classic)
#' }
#' shinyApp(ui, server)
#'
#' }
#' }
#'
#' @importFrom shiny restoreInput
#' @importFrom htmltools tags htmlEscape validateCssUnit
#'  tagAppendAttributes tagAppendChildren tag
#'
#' @export
pickerInput <- function(inputId, label = NULL, choices, selected = NULL, multiple = FALSE,
                        options = list(), choicesOpt = NULL, width = NULL, inline = FALSE) {
  choices <- choicesWithNames(choices)
  selected <- restoreInput(id = inputId, default = selected)
  if (!is.null(options) && length(options) > 0)
    names(options) <- paste("data", names(options), sep = "-")
  if (!is.null(width))
    options <- c(options, list("data-width" = width))
  if (!is.null(width) && width %in% c("fit"))
    width <- NULL
  options <- lapply(options, function(x) {
    if (identical(x, TRUE))
      "true"
    else if (identical(x, FALSE))
      "false"
    else x
  })
  maxOptGroup <- options[["data-max-options-group"]]

  selectTag <- tag("select", dropNulls(options))
  selectTag <- tagAppendAttributes(
    tag = selectTag,
    id = inputId,
    class = "selectpicker form-control"
  )
  selectTag <- tagAppendChildren(
    tag = selectTag, pickerSelectOptions(choices, selected, choicesOpt, maxOptGroup)
  )

  if (multiple)
    selectTag$attribs$multiple <- "multiple"
  divClass <- "form-group shiny-input-container"
  labelClass <- "control-label"
  if (inline) {
    divClass <- paste(divClass, "form-horizontal")
    selectTag <- tags$div(class="col-sm-10", selectTag)
    labelClass <- paste(labelClass, "col-sm-2")
  }
  pickerTag <- tags$div(
    class = divClass,
    style = if (!is.null(width)) paste0("width: ", validateCssUnit(width), ";"),
    if (!is.null(label)) tags$label(class = labelClass, `for` = inputId, label),
    selectTag
  )
  # Deps
  attachShinyWidgetsDep(pickerTag, "picker")
}



#' @title Change the value of a select picker input on the client
#'
#' @description
#' Change the value of a picker input on the client
#'
#' @param session The session object passed to function given to shinyServer.
#' @param inputId	The id of the input object.
#' @param label Display a text in the center of the switch.
#' @param choices List of values to select from. If elements of the list are named
#' then that name rather than the value is displayed to the user.
#' @param selected The initially selected value (or multiple values if multiple = TRUE).
#'  If not specified then defaults to the first value for single-select lists
#'  and no values for multiple select lists.
#' @param choicesOpt Options for choices in the dropdown menu
#'
#' @seealso \link{pickerInput}.
#'
#' @importFrom utils capture.output
#' @export
#'
#' @examples
#' \dontrun{
#' if (interactive()) {
#'
#' library("shiny")
#' library("shinyWidgets")
#'
#' ui <- fluidPage(
#'   tags$h2("Update pickerInput"),
#'
#'   fluidRow(
#'     column(
#'       width = 5, offset = 1,
#'       pickerInput(
#'         inputId = "p1",
#'         label = "classic update",
#'         choices = rownames(mtcars)
#'       )
#'     ),
#'     column(
#'       width = 5,
#'       pickerInput(
#'         inputId = "p2",
#'         label = "disabled update",
#'         choices = rownames(mtcars)
#'       )
#'     )
#'   ),
#'
#'   fluidRow(
#'     column(
#'       width = 10, offset = 1,
#'       sliderInput(
#'         inputId = "up",
#'         label = "Select between models with mpg greater than :",
#'         width = "50%",
#'         min = min(mtcars$mpg),
#'         max = max(mtcars$mpg),
#'         value = min(mtcars$mpg),
#'         step = 0.1
#'       )
#'     )
#'   )
#'
#' )
#'
#' server <- function(input, output, session) {
#'
#'   observeEvent(input$up, {
#'     mtcars2 <- mtcars[mtcars$mpg >= input$up, ]
#'
#'     # Method 1
#'     updatePickerInput(session = session, inputId = "p1",
#'                       choices = rownames(mtcars2))
#'
#'     # Method 2
#'     disabled_choices <- !rownames(mtcars) %in% rownames(mtcars2)
#'     updatePickerInput(
#'       session = session, inputId = "p2",
#'       choices = rownames(mtcars),
#'       choicesOpt = list(
#'         disabled = disabled_choices,
#'         style = ifelse(disabled_choices,
#'                        yes = "color: rgba(119, 119, 119, 0.5);",
#'                        no = "")
#'       )
#'     )
#'   }, ignoreInit = TRUE)
#'
#' }
#'
#' shinyApp(ui = ui, server = server)
#'
#' }
#' }
updatePickerInput <- function (session, inputId, label = NULL, selected = NULL, choices = NULL, choicesOpt = NULL) {
  choices <- if (!is.null(choices))
    choicesWithNames(choices)
  if (!is.null(selected))
    selected <- validateSelected(selected, choices, inputId)
  options <- if (!is.null(choices))
    paste(capture.output(pickerSelectOptions(choices, selected, choicesOpt)), collapse = "\n")
  message <- dropNulls(list(label = label, options = options, value = selected))
  session$sendInputMessage(inputId, message)
}





#' Generate pickerInput options
#'
#' @param choices a named list
#' @param selected selected value if any
#' @param choicesOpt additional option ofr choices
#'
#' @importFrom htmltools HTML htmlEscape tagList tags
#'
#' @noRd
pickerSelectOptions <- function(choices, selected = NULL, choicesOpt = NULL, maxOptGroup = NULL) {
  if (is.null(choicesOpt) & is.null(maxOptGroup)) {
    return(selectOptions(choices, selected))
  }
  if (is.null(choicesOpt))
    choicesOpt <- list()
  l <- lengths(choices)
  if (!is.null(maxOptGroup))
    maxOptGroup <- rep_len(x = maxOptGroup, length.out = sum(l))
  cusum <- cumsum(l)
  m <- matrix(data = c(1, cusum[-length(l)] + 1, cusum), ncol = 2)
  namesch <- names(choices)
  html <- lapply(seq_len(length(choices)), FUN = function(i) {
    label <- namesch[i]
    choice <- choices[[i]]
    if (is.list(choice)) {
      tags$optgroup(
        label = htmlEscape(label, TRUE),
        `data-max-options` = if (!is.null(maxOptGroup)) maxOptGroup[i],
        pickerSelectOptions(
          choice, selected,
          choicesOpt = lapply(
            X = choicesOpt,
            FUN = function(j) {
              j[m[i, 1]:m[i, 2]]
            }
          )
        )
      )
    } else {
      tags$option(
        value = choice,
        HTML(htmlEscape(label)),
        style = choicesOpt$style[i],
        `data-icon` = choicesOpt$icon[i],
        `data-subtext` = choicesOpt$subtext[i],
        `data-content` = choicesOpt$content[i],
        disabled = if (!is.null(choicesOpt$disabled[i]) && choicesOpt$disabled[i]) "disabled",
        selected = if (choice %in% selected) "selected" else NULL
      )
    }
  })
  return(tagList(html))
}

# From shiny/input-select.R, faster alternative if no choice options specific to picker
selectOptions <- function(choices, selected = NULL) {
  html <- mapply(choices, names(choices), FUN = function(choice, label) {
    if (is.list(choice)) {
      sprintf(
        '<optgroup label="%s">\n%s\n</optgroup>',
        htmlEscape(label, TRUE),
        selectOptions(choice, selected)
      )

    } else {
      sprintf(
        '<option value="%s"%s>%s</option>',
        htmlEscape(choice, TRUE),
        if (choice %in% selected) ' selected' else '',
        htmlEscape(label)
      )
    }
  })
  HTML(paste(html, collapse = '\n'))
}


