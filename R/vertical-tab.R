
#' Vertical tab panel
#'
#' @param ... For \code{verticalTabsetPanel}, \code{verticalTabPanel}
#'  to include, and for the later, UI elements.
#' @param selected The \code{value} (or, if none was supplied, the \code{title})
#'  of the tab that should be selected by default. If \code{NULL}, the first tab will be selected.
#' @param id If provided, you can use \code{input$id} in your server logic to determine which of
#'  the current tabs is active. The value will correspond to the \code{value} argument that is passed to \code{verticalTabPanel}.
#' @param color Color for the tab panels.
#' @param contentWidth Width of the content panel (must be between 1 and 12), menu width will be \code{12 - contentWidth}.
#' @param menuSide Side for the menu: right or left.
#'
#' @export
#'
#' @importFrom htmltools tagGetAttribute tags tagList htmlDependency
#' @importFrom sass sass sass_file
#'
#' @name vertical-tab
#'
#' @seealso \code{\link{updateVerticalTabsetPanel}} for updating selected tabs.
#'
#' @example examples/vertical-tab.R
verticalTabsetPanel <- function(..., selected = NULL, id = NULL, color = "#112446", contentWidth = 9, menuSide = "left") {
  stopifnot(is.numeric(contentWidth))
  stopifnot(contentWidth >= 1, contentWidth <= 12)
  menuSide <- match.arg(menuSide, choices = c("right", "left"))
  tabs <- list(...)
  if (is.null(id)) {
    id <- paste(sample(c(letters, LETTERS), 24, TRUE), collapse = "")
  }
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
  if (identical(menuSide, "left")) {
    vtabTag <- tags$div(
      class="row g-0 row-no-gutters vrtc-tab-panel-container tabbable",
      id = if (is.null(id)) id else paste0(id,"-tabbable"),
      tags$div(
        class = sprintf("col-sm-%s vrtc-tab-panel-menu vrtc-tab-panel-menu-%s", 12 - contentWidth, menuSide),
        tags$div(
          class = "list-group vertical-tab-panel",
          lapply(X = tabs, FUN = `[[`, "tabbox"),
          id=id
        )
      ),
      tags$div(
        class = sprintf("col-sm-%s vrtc-tab-panel  tab-content", contentWidth),
        lapply(X = tabs, FUN = `[[`, "tabcontent")
      )
    )
  } else {
    vtabTag <- tags$div(
      class = "col-sm-12 vrtc-tab-panel-container tabbable",
      id = paste0(id, "-tabbable"),
      tags$div(
        class = sprintf("col-sm-%s vrtc-tab-panel  tab-content", contentWidth),
        lapply(X = tabs, FUN = `[[`, "tabcontent")
      ),
      tags$div(
        class = sprintf("col-sm-%s vrtc-tab-panel-menu vrtc-tab-panel-menu-%s", 12 - contentWidth, menuSide),
        tags$div(
          class="list-group vertical-tab-panel",
          id = id,
          lapply(X = tabs, FUN = `[[`, "tabbox")
        )
      )
    )
  }

  vtabStyle <- tags$style(
    sass::sass(list(
      list(id = paste0(id, "-tabbable"), color = color),
      sass::sass_file(input = system.file("assets/vertical-tab-panel/vtb-custom.scss", package = "shinyWidgets"))
    ))
  )

  tagList(
    htmltools::htmlDependency(
      name = "vertical-tab",
      version = "0.1.0",
      src = c(
        href = "shinyWidgets/vertical-tab-panel",
        file = "assets/vertical-tab-panel"
      ),
      package = "shinyWidgets",
      script = c("vertical-tab-panel-bindings.js"),
      stylesheet = "vertical-tab-panel.css"
    ),
    vtabStyle,
    vtabTag
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
    class = "list-group-item text-center",
    style = "cursor: pointer;",
    style = if (!is.null(box_height)) paste("height:", box_height, ";"),
    `data-value` = value,
    `data-toggle` = "tab",
    if (!is.null(icon)) tags$h4(icon),
    tags$h4(title)
  )
  tabcontent <- tags$div(
    class="vrtc-tab-panel-content",
    `data-value` = value,
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
#'           title = "Title 1", icon = icon("house", "fa-2x"),
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
updateVerticalTabsetPanel <- function (session, inputId, selected = NULL) {
  message <- dropNulls(list(value = selected))
  session$sendInputMessage(inputId, message)
}



#' Mutate Vertical Tabset Panel
#'
#' @param session The \code{session} object passed to function given to \code{shinyServer.}
#' @param inputId The id of the \code{verticalTabsetPanel} object.
#' @param index The index of the the tab to remove.
#' @param tab The verticalTab to append.
#' @examples
#'
#' if (interactive()) {
#'
#' library(shiny)
#' library(shinyWidgets)
#'
#' ui <- fluidPage(
#'
#'   verticalTabsetPanel(
#'     verticalTabPanel("blaa","foo"),
#'     verticalTabPanel("yarp","bar"),
#'     id="hippi"
#'   )
#' )
#'
#' server <- function(input, output, session) {
#'   appendVerticalTab("hippi", verticalTabPanel("bipi","long"))
#'   removeVerticalTab("hippi", 1)
#'   appendVerticalTab("hippi", verticalTabPanel("howdy","fair"))
#'   reorderVerticalTabs("hippi", c(3,2,1))
#' }
#'
#' # Run the application
#' shinyApp(ui = ui, server = server)
#'
#' }
#' @export
appendVerticalTab <- function(inputId, tab, session = shiny::getDefaultReactiveDomain()) {
  shiny::insertUI(
    selector = paste0("#", inputId, "-tabbable > .tab-content"),
    where = "beforeEnd",
    ui = tab$tabcontent,
    immediate = TRUE
  )
  shiny::insertUI(
    selector = paste0("#",inputId),
    where = "beforeEnd",
    ui = tab$tabbox,
    immediate = TRUE
  )
}

#' @rdname appendVerticalTab
#' @export
removeVerticalTab <- function(inputId, index, session = shiny::getDefaultReactiveDomain()) {
  shiny::removeUI(
    selector = paste0("#", inputId, "-tabbable > div > .vrtc-tab-panel-content:nth-child(", index,")"),
    immediate = TRUE
  )
  shiny::removeUI(
    selector = paste0("#", inputId, " > a:nth-child(", index,")"),
    immediate = TRUE
  )
  session$sendInputMessage(inputId, message = list(validate = TRUE))
}

#' @param newOrder The new index order.
#' @rdname appendVerticalTab
#' @export
reorderVerticalTabs <- function(inputId, newOrder, session = shiny::getDefaultReactiveDomain()) {
  session$sendInputMessage(inputId, message = list(reorder = newOrder))
}
