#' Custom shadows
#'
#' Allow to apply a shadow on a given element.
#'
#' @param class The element to which the shadow should be applied.
#' For example, class is set to box.
#'
#' @export
#'
#' @examples
#' \dontrun{
#'  if (interactive()) {
#'
#'   library(shiny)
#'   library(shinyWidgets)
#'   library(shinydashboard)
#'   library(shinydashboardPlus)
#'
#'   ui <- fluidPage(
#'     tags$h2("Add shadow and hover interactions to any element"),
#'
#'     setShadow("box"),
#'     setShadow("info-box"),
#'     setShadow("progress"),
#'     setBackgroundColor(color = "ghostwhite"),
#'     useShinydashboardPlus(),
#'
#'     fluidRow(
#'      boxPlus(
#'        title = "Closable Box with dropdown",
#'        closable = TRUE,
#'        status = "warning",
#'        solidHeader = FALSE,
#'        collapsible = TRUE,
#'        enable_dropdown = TRUE,
#'        dropdown_icon = "wrench",
#'        dropdown_menu = dropdownItemList(
#'          dropdownItem(url = "http://www.google.com", name = "Link to google"),
#'          dropdownItem(url = "#", name = "item 2"),
#'          dropdownDivider(),
#'          dropdownItem(url = "#", name = "item 3")
#'        ),
#'        p("Box Content")
#'      ),
#'      boxPlus(
#'        title = "Closable box, with label",
#'        closable = TRUE,
#'        enable_label = TRUE,
#'        label_text = 1,
#'        label_status = "danger",
#'        status = "warning",
#'        solidHeader = FALSE,
#'        collapsible = TRUE,
#'        p("Box Content")
#'      )
#'     ),
#'     fluidRow(
#'      infoBox(
#'      "Orders",
#'      "50",
#'      "Subtitle", icon = icon("credit-card")
#'      )
#'     ),
#'     fluidRow(
#'      verticalProgress(
#'       value = 10,
#'       striped = TRUE,
#'       active = TRUE
#'      ),
#'      verticalProgress(
#'        value = 50,
#'        active = TRUE,
#'        status = "warning",
#'        size = "xs"
#'      ),
#'      verticalProgress(
#'        value = 20,
#'        status = "danger",
#'        size = "sm",
#'        height = "60%"
#'      )
#'     )
#'   )
#'   server <- function(input, output, session) {}
#'   shinyApp(ui, server)
#'  }
#' }
setShadow <- function(class) {

  # shadow css
  cssShadow <- paste0(
    " box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
      transition: 0.3s;
      border-radius: 5px;
   ")
  cssShadow <- paste0(".", class, " {", cssShadow, "}")

  # hover effect css
  cssHover <- "box-shadow: 0 16px 32px 0 rgba(0,0,0,0.2);"
  cssHover <- paste0(".", class, ":hover", " {", cssHover, "}")

  css <- paste(cssShadow, cssHover)

  # wrap everything in the head
  htmltools::tags$head(
    htmltools::tags$style(css)
  )
}

