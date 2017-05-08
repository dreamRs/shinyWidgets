
# ------------------------------------------------------------------------ #
#
# Descriptif : Select picker : fonctions R
#     Detail : https://silviomoreto.github.io/bootstrap-select/examples/
#
#
# Auteur : Victor PERRIER
#
# Date creation : 08/09/2016
# Date modification : 08/09/2016
#
# Version 1.0
#
# ------------------------------------------------------------------------ #




#' @title Select picker Input Control
#'
#' @description
#' Create a select picker.
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label Display a text in the center of the switch.
#' @param choices List of values to select from. If elements of the list are named then that name rather than the value is displayed to the user.
#' @param selected The initially selected value (or multiple values if multiple = TRUE). If not specified then defaults to the first value for single-select lists and no values for multiple select lists.
#' @param multiple Is selection of multiple items allowed?
#' @param options Options to customize the select picker
#' @param choicesOpt Options for choices in the dropdown menu
#' @param width The width of the input : 'auto', 'fit', '100px', '75\%'
#' @param inline Put the label and the picker on the same line.
#' @return A select control that can be added to a UI definition.
#'
#'
#' @examples
#' \dontrun{
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'
#' ui <- fluidPage(
#'   pickerInput(inputId = "somevalue", label = "A label", choices = c("a", "b")),
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
#' @importFrom htmltools htmlDependency attachDependencies htmlEscape
#'
#' @export


pickerInput <- function(inputId, label = NULL, choices, selected = NULL, multiple = FALSE,
                        options = NULL, choicesOpt = NULL, width = NULL, inline = FALSE) {
  choices <- choicesWithNames(choices)
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
  selectTag <- do.call(tags$select, c(selectProps, pickerOptions(choices, selected, choicesOpt)))

  if (multiple)
    selectTag$attribs$multiple <- "multiple"
  divClass <- "form-group"
  labelClass <- "control-label"
  if (inline) {
    divClass <- paste(divClass, "form-horizontal")
    selectTag <- tags$div(class="col-sm-10", selectTag)
    labelClass <- paste(labelClass, "col-sm-2")
  }
  pickerTag <- tagList(
    tags$div(
      class = divClass,
      if (!is.null(label)) tags$label(class = labelClass, `for` = inputId, label),
      if (!is.null(label) & !inline) br(),
      selectTag,
      tags$script(paste0('$("#', inputId, '").selectpicker();'))
    )
    # ,
    # receivePickerMessage(paste0("message", inputId))
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
#' @param choices List of values to select from. If elements of the list are named then that name rather than the value is displayed to the user.
#' @param selected The initially selected value (or multiple values if multiple = TRUE). If not specified then defaults to the first value for single-select lists and no values for multiple select lists.
#' @param choicesOpt Options for choices in the dropdown menu
#'
#' @importFrom utils capture.output
#' @export


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



# #' @title Select/Deselect value of a select picker
# #'
# #' @export
#
# updatePickerSelect <- function(session, inputId, selected = NULL) {
#   if (is.null(selected)) {
#     session$sendCustomMessage(
#       type = paste0("message", inputId),
#       message = list(inputId = inputId, deselectAll = TRUE, selectChoices = FALSE)
#     )
#   } else {
#     session$sendCustomMessage(
#       type = paste0("message", inputId),
#       message = list(inputId = inputId, deselectAll = FALSE, selectChoices = TRUE, selected = jsonlite::toJSON(selected))
#     )
#   }
# }
#
#
#
# receivePickerMessage <- function(message) {
#   deselectAll <- "if (data.deselectAll) {$('#' + data.inputId).selectpicker('deselectAll');}"
#   selectChoices <- "if (data.selectChoices) {$('#' + data.inputId).selectpicker('val', data.selected);}"
#   js <- paste0("Shiny.addCustomMessageHandler('", message, "', function(data) {", deselectAll, selectChoices, "});")
#   tags$script(js)
# }




# pickerOptions <- function (choices, selected = NULL, choicesOpt = NULL)
# {
#   if (is.null(choicesOpt))
#     choicesOpt <- list()
#   html <- lapply(seq_along(choices), FUN = function(i) {
#     label <- names(choices)[i]
#     choice <- choices[[i]]
#     if (is.list(choice)) {
#       optionTag <- list(
#         label = htmltools::htmlEscape(label, TRUE), pickerOptions(choice, selected)
#       )
#       optionTag <- dropNulls(optionTag)
#       do.call(tags$optgroup, optionTag)
#     }
#     else {
#       optionTag <- list(
#         value = htmltools::htmlEscape(choice, TRUE), htmltools::htmlEscape(label),
#         style = choicesOpt$style[i], `data-icon` = choicesOpt$icon[i],
#         `data-subtext` = choicesOpt$subtext[i],
#         selected = if (choice %in% selected) "selected" else NULL
#       )
#       # optionTag$attribs <- c(optionTag$attribs, list(if (choice %in% selected) " selected" else ""))
#       optionTag <- dropNulls(optionTag)
#       do.call(tags$option, optionTag)
#     }
#   })
#   return(tagList(html))
# }

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
      do.call(tags$optgroup, optionTag)
    }
    else {
      optionTag <- list(
        value = htmltools::htmlEscape(choice, TRUE), htmltools::htmlEscape(label),
        style = choicesOpt$style[i],
        `data-icon` = choicesOpt$icon[i],
        `data-subtext` = choicesOpt$subtext[i],
        `data-content` = choicesOpt$content[i],
        selected = if (choice %in% selected) "selected" else NULL
      )
      # optionTag$attribs <- c(optionTag$attribs, list(if (choice %in% selected) " selected" else ""))
      optionTag <- dropNulls(optionTag)
      do.call(tags$option, optionTag)
    }
  })
  return(tagList(html))
}

