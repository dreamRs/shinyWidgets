
#' Vertical tab panel
#'
#' @param ... For \code{verticalTabsetPanel}, \code{verticalTabPanel}
#'  to include, and for the later, UI elements.
#' @param selected The \code{value} (or, if none was supplied, the \code{title})
#'  of the tab that should be selected by default. If \code{NULL}, the first tab will be selected.
#' @param id If provided, you can use \code{input$id} in your server logic to determine which of
#'  the current tabs is active. The value will correspond to the \code{value} argument that is passed to \code{verticalTabPanel}.
#' @param color Color for the tab panels.
#'
#' @export
#'
#' @importFrom htmltools tagGetAttribute tags tagList
#' @importFrom shiny singleton
#'
#' @name vertical-tab
#'
#' @seealso \code{\link{updateVerticalTabsetPanel}} for updating selected tabs.
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
verticalTabsetPanel <- function(..., selected = NULL, id = NULL, color = "#112446") {
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
        class="list-group vertical-tab-panel",
        id = id,
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
      tagList(
        tags$script(src="shinyWidgets/vertical-tab-panel/vertical-tab-panel.js"),
        tags$script(src = "shinyWidgets/vertical-tab-panel/vertical-tab-panel-bindings.js")
      )
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




#' Update selected vertical tab
#'
#' @param session The \code{session} object passed to function given to \code{shinyServer.}
#' @param inputId The id of the \code{verticalTabsetPanel} object.
#' @param selected The name of the tab to make active.
#'
#' @export
#'
#' @seealso \code{\link{verticalTabsetPanel}}
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
#'       tags$h2("Update vertical tab panel example:"),
#'       verbatimTextOutput("res"),
#'       radioButtons(
#'         inputId = "update", label = "Update selected:",
#'         choices = c("Title 1", "Title 2", "Title 3"),
#'         inline = TRUE
#'       ),
#'       verticalTabsetPanel(
#'         id = "TABS",
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
#'   output$res <- renderPrint(input$TABS)
#'   observeEvent(input$update, {
#'     shinyWidgets:::updateVerticalTabsetPanel(
#'       session = session,
#'       inputId = "TABS",
#'       selected = input$update
#'     )
#'   }, ignoreInit = TRUE)
#' }
#'
#' shinyApp(ui, server)
#'
#' }
#'
#' }
updateVerticalTabsetPanel <- function (session, inputId, selected = NULL) {
  message <- dropNulls(list(value = selected))
  session$sendInputMessage(inputId, message)
}



