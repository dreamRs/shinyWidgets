#' @title Create a panel
#'
#' @description Create a panel (box) with basic border and padding,
#' you can use Bootstrap status to style the panel,
#' see \url{http://getbootstrap.com/components/#panels}.
#'
#' @param ... UI elements to include inside the panel.
#' @param heading Title for the panel in a plain header.
#' @param footer Footer for the panel.
#' @param status Bootstrap status for contextual alternative.
#'
#' @return A UI definition.
#' @export
#'
#' @importFrom htmltools tags
#'
#' @examples
#' if (interactive()) {
#' library("shiny")
#' library("shinyWidgets")
#'
#' ui <- fluidPage(
#'
#'   # Default
#'   panel(
#'     "Content goes here",
#'     checkboxInput(inputId = "id1", label = "Label")
#'   ),
#'
#'   # With header and footer
#'   panel(
#'     "Content goes here",
#'     checkboxInput(inputId = "id2", label = "Label"),
#'     heading = "My title",
#'     footer = "Something"
#'   ),
#'
#'   # With status
#'   panel(
#'     "Content goes here",
#'     checkboxInput(inputId = "id3", label = "Label"),
#'     heading = "My title",
#'     status = "primary"
#'   )
#' )
#'
#' server <- function(input, output, session) {
#'
#' }
#'
#' shinyApp(ui = ui, server = server)
#' }
panel <- function(..., heading = NULL, footer = NULL, status = "default") {
  status <- match.arg(
    arg = status,
    choices = c("default", "primary", "success", "info", "warning", "danger")
  )
  if (!is.null(heading)) {
    heading <- htmltools::tags$div(
      class="panel-heading",
      if (is.character(heading))
        htmltools::tags$h3(class="panel-title", heading)
      else
        heading
    )
  }
  htmltools::tags$div(
    class=paste0("panel panel-", status), heading,
    htmltools::tags$div(class="panel-body", ...),
    if (!is.null(footer)) htmltools::tags$div(class="panel-footer", footer)
  )
}






