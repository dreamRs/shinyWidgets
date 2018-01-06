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
#' @param width The width of the input, e.g. '400px', or '100\%'.
#'
#' @note The two buttons ('search' and 'reset') act like \code{actionButton}, you can
#' retrieve their value server-side with \code{input$<INPUTID>_search} and \code{input$<INPUTID>_reset}.
#'
#' @examples
#' \dontrun{
#' if (interactive()) {
#'   ui <- fluidPage(
#'     tags$h1("Search Input"),
#'     br(),
#'     searchInput(
#'       inputId = "search", label = "Enter your text",
#'       placeholder = "A placeholder",
#'       btnSearch = icon("search"),
#'       btnReset = icon("remove"),
#'       width = "450px"
#'     ),
#'     br(),
#'     verbatimTextOutput(outputId = "res")
#'   )
#'
#'   server <- function(input, output, session) {
#'     output$res <- renderPrint({
#'       input$search
#'     })
#'   }
#'
#'   shinyApp(ui = ui, server = server)
#' }
#' }
#'
#' @importFrom shiny restoreInput
#' @importFrom htmltools tags validateCssUnit singleton
#'
#' @export

searchInput <- function(inputId, label = NULL, value = "", placeholder = NULL,
                        btnSearch = NULL, btnReset = NULL, width = NULL) {
  value <- shiny::restoreInput(id = inputId, default = value)
  if (!is.null(btnSearch)) {
    btnSearch <- htmltools::tags$button(
      class="btn btn-default btn-addon action-button",
      id = paste0(inputId, "_search"),
      type="button", btnSearch
    )
  }
  if (!is.null(btnReset)) {
    btnReset <- htmltools::tags$button(
      class="btn btn-default btn-addon action-button",
      id = paste0(inputId, "_reset"),
      type="button", btnReset
    )
  }

  css_btn_addon <- paste0(
    ".btn-addon{", "font-size:14.5px;",
    "margin:0 0 0 0 !important;",
    "display: inline-block !important;", "}"
  )

  searchTag <- htmltools::tags$div(
    class="form-group shiny-input-container",
    style = if (!is.null(width))
      paste0("width: ", validateCssUnit(width), ";"),
    if (!is.null(label)) htmltools::tags$label(label, `for` = inputId),
    htmltools::tags$div(
      id = inputId,
      class = "input-group search-text",
      htmltools::tags$input(id = paste0("se", inputId),
                 style = "border-radius: 0.25em 0 0 0.25em !important;",
                 type = "text", class = "form-control", value = value,
                 placeholder = placeholder),
      htmltools::tags$div(class="input-group-btn", btnReset, btnSearch)
    ),
    singleton(tags$head(tags$style(css_btn_addon)))
  )
  # Dep
  attachShinyWidgetsDep(searchTag)
}

