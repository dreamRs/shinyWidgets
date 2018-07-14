
#' Vertical tab panel
#'
#' @param ... For \code{verticalTabsetPanel}, \code{verticalTabPanel}
#'  to include, and for the later, UI elements.
#' @param selected The \code{value} (or, if none was supplied, the \code{title})
#'  of the tab that should be selected by default. If \code{NULL}, the first tab will be selected.
#' @param color Color for the tab panels.
#'
#' @export
#'
#' @importFrom htmltools tagGetAttribute tags tagList
#' @importFrom shiny singleton
#'
#' @name vertical-tab
#'
#' @examples
#' \dontrun{
#'
#' if (interactive()) {
#'
#' library(shiny)
#' library(shinyWidgets)
#'
#' ui <- fluidPage(
#'   fluidRow(
#'     column(
#'       width = 10, offset = 1,
#'       tags$h2("Vertical tab panel example"),
#'       verticalTabsetPanel(
#'         verticalTabPanel(
#'           title = "Title 1", icon = icon("home", "fa-2x"),
#'           "Content panel 1"
#'         ),
#'         verticalTabPanel(
#'           title = "Title 2", icon = icon("map", "fa-2x"),
#'           "Content panel 2"
#'         ),
#'         verticalTabPanel(
#'           title = "Title 3", icon = icon("rocket", "fa-2x"),
#'           "Content panel 3"
#'         )
#'       )
#'     )
#'   )
#' )
#'
#' server <- function(input, output, session) {
#'
#' }
#'
#' shinyApp(ui, server)
#'
#' }
#'
#' }
verticalTabsetPanel <- function(..., selected = NULL, color = "#112446") {
  tabs <- list(...)
  if (is.null(selected)) {
    indice <- 1
  } else {
    values <- lapply(
      X = tabs,
      FUN = function(x) {
        tagGetAttribute(tag = x$tabcontent, attr = "data-value")
      }
    )
    values <- unlist(values)
    indice <- which(values == selected)
    if (length(indice) < 1)
      indice <- 1
  }
  tabs[[indice]]$tabcontent$attribs$class <- paste(
    tabs[[indice]]$tabcontent$attribs$class, "active"
  )
  tabs[[indice]]$tabbox$attribs$class <- paste(
    tabs[[indice]]$tabbox$attribs$class, "active"
  )
  vtbTag <- tags$div(
    class="col-sm-12 bhoechie-tab-container tabbable",
    tags$div(
      class="col-sm-3 bhoechie-tab-menu",
      tags$div(
        class="list-group",
        lapply(X = tabs, FUN = `[[`, "tabbox")
      )
    ),
    tags$div(
      class="col-sm-9 bhoechie-tab  tab-content",
      lapply(X = tabs, FUN = `[[`, "tabcontent")
    )
  )
  tagList(
    singleton(
      tagList(
        tags$link(href="shinyWidgets/vertical-tab-panel/vertical-tab-panel.css", rel="stylesheet"),
        tags$style(sprintf(":root {--vtb-color: %s;}", color))
      )
    ),
    vtbTag,
    singleton(
      tags$script(src="shinyWidgets/vertical-tab-panel/vertical-tab-panel.js")
    )
  )
}



#' @param title Display title for tab.
#' @param value Not used yet.
#' @param icon Optional icon to appear on the tab.
#' @param box_height Height for the title box.
#'
#' @export
#'
#' @rdname vertical-tab
verticalTabPanel <- function(title, ..., value = title, icon = NULL, box_height = "160px") {
  tabbox <- tags$a(
    href="#", class="list-group-item text-center",
    style = if (!is.null(box_height)) paste("height:", box_height),
    `data-value` = value, `data-toggle` = "tab",
    if (!is.null(icon)) tags$h4(icon),
    tags$h4(title)
  )
  tabcontent <- tags$div(
    class="bhoechie-tab-content", `data-value` = value,
    ...
  )
  list(tabbox = tabbox, tabcontent = tabcontent)
}


