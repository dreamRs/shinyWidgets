#' @title Select picker Input Control
#'
#' @description
#' Create a select picker (\url{https://silviomoreto.github.io/bootstrap-select/})
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label Display a text in the center of the switch.
#' @param choices List of values to select from. If elements of the
#'  list are named then that name rather than the value is displayed to the user.
#' @param selected The initially selected value (or multiple values if multiple = TRUE).
#' If not specified then defaults to the first value for single-select lists
#'  and no values for multiple select lists.
#' @param multiple Is selection of multiple items allowed?
#' @param options Options to customize the select picker,
#' see \url{https://silviomoreto.github.io/bootstrap-select/options/}.
#' @param choicesOpt Options for choices in the dropdown menu.
#' @param width The width of the input : 'auto', 'fit', '100px', '75\%'.
#' @param inline Put the label and the picker on the same line.
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
#' # Add actions box for selecting
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
#' # Customize the values displayed in the box
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
#'     selected = rownames(mtcars)
#'   ),
#'   br(),
#'   pickerInput(
#'     inputId = "p1b",
#'     label = "Default with | separator",
#'     multiple = TRUE,
#'     choices = rownames(mtcars),
#'     selected = rownames(mtcars),
#'     options = list(`multiple-separator` = " | ")
#'   ),
#'   br(),
#'   pickerInput(
#'     inputId = "p2",
#'     label = "Static",
#'     multiple = TRUE,
#'     choices = rownames(mtcars),
#'     selected = rownames(mtcars),
#'     options = list(`selected-text-format`= "static",
#'                    title = "Won't change")
#'   ),
#'   br(),
#'   pickerInput(
#'     inputId = "p3",
#'     label = "Count",
#'     multiple = TRUE,
#'     choices = rownames(mtcars),
#'     selected = rownames(mtcars),
#'     options = list(`selected-text-format`= "count")
#'   ),
#'   br(),
#'   pickerInput(
#'     inputId = "p3",
#'     label = "Customize count",
#'     multiple = TRUE,
#'     choices = rownames(mtcars),
#'     selected = rownames(mtcars),
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
#' }
#' }
#'
#' @importFrom shiny restoreInput
#' @importFrom htmltools tags htmlEscape
#'
#' @export
pickerInput <- function(inputId, label = NULL, choices, selected = NULL, multiple = FALSE,
                        options = NULL, choicesOpt = NULL, width = NULL, inline = FALSE) {
  choices <- choicesWithNames(choices)
  selected <- shiny::restoreInput(id = inputId, default = selected)
  if (!is.null(options))
    names(options) <- paste("data", names(options), sep = "-")
  if (!is.null(width))
    options <- c(options, list("data-width" = width))
  options <- lapply(options, function(x) {
    if (identical(x, TRUE))
      "true"
    else if (identical(x, FALSE))
      "false"
    else x
  })
  selectProps <- dropNulls(c(list(id = inputId, class = "selectpicker form-control"), options))
  selectTag <- do.call(htmltools::tags$select, c(selectProps, pickerOptions(choices, selected, choicesOpt)))

  if (multiple)
    selectTag$attribs$multiple <- "multiple"
  divClass <- "form-group"
  labelClass <- "control-label"
  if (inline) {
    divClass <- paste(divClass, "form-horizontal")
    selectTag <- htmltools::tags$div(class="col-sm-10", selectTag)
    labelClass <- paste(labelClass, "col-sm-2")
  }
  pickerTag <- htmltools::tags$div(
    class = divClass,
    if (!is.null(label)) htmltools::tags$label(class = labelClass, `for` = inputId, label),
    if (!is.null(label) & !inline) htmltools::tags$br(),
    selectTag,
    htmltools::tags$script(HTML(paste0('$("#', escape_jquery(inputId), '").selectpicker();')))
  )
  # Dep
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
    paste(capture.output(pickerOptions(choices, selected, choicesOpt)), collapse = "\n")
  message <- dropNulls(list(label = label, options = options, value = selected))
  session$sendInputMessage(inputId, message)
}





#' Generate pickerInput options
#'
#' @param choices a named list
#' @param selected selected value if any
#' @param choicesOpt additional option ofr choices
#'
#' @importFrom htmltools HTML htmlEscape tagList
#'
#' @noRd
pickerOptions <- function (choices, selected = NULL, choicesOpt = NULL)
{
  if (is.null(choicesOpt))
    choicesOpt <- list()
  l <- sapply(choices, length)
  m <- matrix(data = c(c(1, cumsum(l)[-length(l)] + 1), cumsum(l)), ncol = 2)
  html <- lapply(seq_along(choices), FUN = function(i) {
    label <- names(choices)[i]
    choice <- choices[[i]]
    if (is.list(choice)) {
      optionTag <- list(
        label = htmltools::htmlEscape(label, TRUE),
        pickerOptions(
          choice, selected,
          choicesOpt = lapply(
            X = choicesOpt,
            FUN = function(j) {
              j[m[i, 1]:m[i, 2]]
            }
          )
        )
      )
      optionTag <- dropNulls(optionTag)
      do.call(htmltools::tags$optgroup, optionTag)
    }
    else {
      optionTag <- list(
        value = choice, htmltools::HTML(htmltools::htmlEscape(label)),
        style = choicesOpt$style[i],
        `data-icon` = choicesOpt$icon[i],
        `data-subtext` = choicesOpt$subtext[i],
        `data-content` = choicesOpt$content[i],
        disabled = if (!is.null(choicesOpt$disabled[i]) && choicesOpt$disabled[i]) "disabled",
        selected = if (choice %in% selected) "selected" else NULL
      )
      # optionTag$attribs <- c(optionTag$attribs, list(if (choice %in% selected) " selected" else ""))
      optionTag <- dropNulls(optionTag)
      do.call(htmltools::tags$option, optionTag)
    }
  })
  return(htmltools::tagList(html))
}

