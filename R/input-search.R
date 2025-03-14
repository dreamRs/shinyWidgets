#' @title Search Input
#'
#' @description
#' A text input only triggered when Enter key is pressed or search button clicked
#'
#' @param inputId The input slot that will be used to access the value.
#' @param label Display label for the control, or NULL for no label.
#' @param value Initial value.
#' @param placeholder A character string giving the user a hint as to what can be entered into the control.
#' @param btnSearch An icon for the button which validate the search.
#' @param btnReset An icon for the button which reset the search.
#' @param btnClass Class to add to buttons, if a vector of length 2 the first value is used for search button and second one for reset button.
#' @param resetValue Value used when reset button is clicked, default to `""` (empty string),
#'  if `NULL` value is not reset.
#' @param inputType The type of input to use, default is `"text"` but you can also use `"password"` for example,
#'  see [developer.mozilla.org](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/text) for other possible types.
#' @param width The width of the input, e.g. `400px`, or `100%`.
#'
#' @note The two buttons ('search' and 'reset') act like [shiny::actionButton()], you can
#' retrieve their value server-side with `input$<INPUTID>_search` and `input$<INPUTID>_reset`.
#'
#' @seealso [updateSearchInput()] to update value server-side.
#'
#'
#' @importFrom shiny restoreInput
#' @importFrom htmltools tags css validateCssUnit singleton
#'
#' @export
#'
#' @example examples/searchInput.R
searchInput <- function(inputId,
                        label = NULL,
                        value = "",
                        placeholder = NULL,
                        btnSearch = NULL,
                        btnReset = NULL,
                        btnClass = "btn-default btn-outline-secondary",
                        resetValue = "",
                        inputType = "text",
                        width = NULL) {
  value <- shiny::restoreInput(id = inputId, default = value)
  btnClass <- rep_len(btnClass, length.out = 2)
  tagSearch <- htmltools::tags$button(
    class = "btn btn-addon action-button",
    class = btnClass[1],
    id = paste0(inputId, "_search"),
    type = "button",
    btnSearch,
    style = if (is.null(btnSearch)) css(display = "none")
  )
  tagReset <- htmltools::tags$button(
    class = "btn btn-addon action-button",
    class = btnClass[2],
    id = paste0(inputId, "_reset"),
    type = "button",
    btnReset,
    style = if (is.null(btnReset)) css(display = "none")
  )

  htmltools::tags$div(
    class = "form-group shiny-input-container",
    style = css(width = validateCssUnit(width)),
    label_input(inputId, label),
    htmltools::tags$div(
      id = inputId,
      `data-reset` = !is.null(resetValue),
      `data-reset-value` = resetValue,
      class = "input-group search-text",
      htmltools::tags$input(
        id = paste0(inputId, "_text"),
        type = inputType,
        class = "form-control",
        value = value,
        placeholder = placeholder
      ),
      markup_search_input_group_button(
        tagReset, tagSearch, btnSearch, btnReset,
        theme_func = shiny::getCurrentTheme
      )
    ),
    html_dependency_input_icons()
  )
}


#' @importFrom htmltools tagList tagFunction
#' @importFrom shiny getCurrentTheme
#' @importFrom bslib is_bs_theme theme_version
markup_search_input_group_button <- function(tagReset, tagSearch, btnSearch, btnReset, theme_func = NULL) {
  tagList(tagFunction(function() {
    if (is.function(theme_func))
      theme <- theme_func()
    default <- htmltools::tags$div(
      class = "input-group-btn",
      style = if (is.null(btnSearch) & is.null(btnReset)) css(display = "none"),
      tagReset,
      tagSearch
    )
    if (!bslib::is_bs_theme(theme)) {
      return(default)
    }
    if (bslib::theme_version(theme) %in% c("5")) {
      return(tagList(tagReset, tagSearch))
    }
    return(default)
  }))
}



#' Change the value of a search input on the client
#'
#' @param session The \code{session} object passed to function given to \code{shinyServer}.
#' @param inputId The id of the input object.
#' @param label The label to set for the input object.
#' @param value The value to set for the input object.
#' @param placeholder The placeholder to set for the input object.
#' @param trigger Logical, update value server-side as well.
#'
#' @note By default, only UI value is updated, use \code{trigger = TRUE} to update both UI and Server value.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'
#' library(shiny)
#' library(shinyWidgets)
#'
#' ui <- fluidPage(
#'   tags$h2("Update searchinput"),
#'   searchInput(
#'     inputId = "search", label = "Enter your text",
#'     placeholder = "A placeholder",
#'     btnSearch = icon("magnifying-glass"),
#'     btnReset = icon("xmark"),
#'     width = "450px"
#'   ),
#'   br(),
#'   verbatimTextOutput(outputId = "res"),
#'   br(),
#'   textInput(
#'     inputId = "update_search",
#'     label = "Update search"
#'   ),
#'   checkboxInput(
#'     inputId = "trigger_search",
#'     label = "Trigger update search",
#'     value = TRUE
#'   )
#' )
#'
#' server <- function(input, output, session) {
#'
#'   output$res <- renderPrint({
#'     input$search
#'   })
#'
#'   observeEvent(input$update_search, {
#'     updateSearchInput(
#'       session = session,
#'       inputId = "search",
#'       value = input$update_search,
#'       trigger = input$trigger_search
#'     )
#'   }, ignoreInit = TRUE)
#' }
#'
#' shinyApp(ui, server)
#'
#' }
updateSearchInput <- function (session, inputId, label = NULL, value = NULL, placeholder = NULL, trigger = FALSE) {
  message <- list(label = label, value = value,
                  placeholder = placeholder,
                  trigger = trigger,
                  id = inputId)
  message <- dropNulls(message)
  session$sendInputMessage(inputId, message)
}
