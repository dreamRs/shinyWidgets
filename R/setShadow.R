#' Custom shadows
#'
#' Allow to apply a shadow on a given element.
#'
#' @param id Use this argument if you want to target an individual element.
#' @param class The element to which the shadow should be applied.
#' For example, class is set to box.
#'
#' @export
#'
#' @examples
#'  if (interactive()) {
#'
#'   library(shiny)
#'   library(shinydashboard)
#'   library(shinydashboardPlus)
#'   library(shinyWidgets)
#'
#'   boxTag <- boxPlus(
#'    title = "Closable box, with label",
#'    closable = TRUE,
#'    enable_label = TRUE,
#'    label_text = 1,
#'    label_status = "danger",
#'    status = "warning",
#'    solidHeader = FALSE,
#'    collapsible = TRUE,
#'    p("Box Content")
#'   )
#'
#'   shinyApp(
#'    ui = dashboardPagePlus(
#'      header = dashboardHeaderPlus(
#'        enable_rightsidebar = TRUE,
#'        rightSidebarIcon = "gears"
#'      ),
#'      sidebar = dashboardSidebar(),
#'      body = dashboardBody(
#'
#'       setShadow(class = "box"),
#'       setShadow(id = "my-progress"),
#'
#'       tags$h2("Add shadow to the box class"),
#'       fluidRow(boxTag, boxTag),
#'       tags$h2("Add shadow only to the first element using id"),
#'       tagAppendAttributes(
#'        verticalProgress(
#'         value = 10,
#'         striped = TRUE,
#'         active = TRUE
#'        ),
#'        id = "my-progress"
#'       ),
#'       verticalProgress(
#'         value = 50,
#'         active = TRUE,
#'         status = "warning",
#'         size = "xs"
#'       ),
#'       verticalProgress(
#'         value = 20,
#'         status = "danger",
#'         size = "sm",
#'         height = "60%"
#'       )
#'      ),
#'      rightsidebar = rightSidebar(),
#'      title = "DashboardPage"
#'    ),
#'    server = function(input, output) { }
#'   )
#' }
setShadow <- function(id = NULL, class = NULL) {

  # shadow css
  cssShadow <- paste0(
    " box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
      transition: 0.3s;
      border-radius: 5px;
   ")

  cssShadow <- if (!is.null(id)) {
    if (!is.null(class)) {
      paste0("#", id, " .", class, " {", cssShadow, "}")
    } else {
      paste0("#", id, " {", cssShadow, "}")
    }
  } else {
    if (!is.null(class)) {
      paste0(".", class, " {", cssShadow, "}")
    } else {
      NULL
    }
  }

  # hover effect css
  cssHover <- "box-shadow: 0 16px 32px 0 rgba(0,0,0,0.2);"

  cssHover <- if (!is.null(id)) {
    if (!is.null(class)) {
      paste0("#", id, ":hover .", class, ":hover {", cssHover, "}")
    } else {
      paste0("#", id, ":hover", " {", cssHover, "}")
    }
  } else {
    if (!is.null(class)) {
      paste0(".", class, ":hover", " {", cssHover, "}")
    } else {
      NULL
    }
  }

  css <- paste(cssShadow, cssHover)

  # wrap everything in the head
  htmltools::tags$head(
    htmltools::tags$style(css)
  )
}
