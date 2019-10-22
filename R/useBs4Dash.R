#' Use 'bs4Dash' in 'shiny'
#'
#' Allow to use functions from 'bs4Dash' into a classic 'shiny' app,
#' specifically \code{bs4ValueBox}, \code{bs4InfoBox} and \code{bs4Card}.
#'
#' @export
#'
#' @param old_school FALSE by default. Experimental.
#'
#' @importFrom htmltools findDependencies attachDependencies
#'
#' @examples
#' if (interactive()) {
#'
#' library(shiny)
#' library(bs4Dash)
#' library(shinyWidgets)
#'
#' ui <- fluidPage(
#'   h1("Import bs4Dash elements inside shiny!", align = "center"),
#'   h5("Don't need any sidebar, navbar, ...", align = "center"),
#'   h5("Only focus on basic elements for a pure interface", align = "center"),
#'
#'   # use this in non dashboard app
#'   setBackgroundColor(color = "ghostwhite"),
#'   useBs4Dash(old_school = FALSE),
#'
#'   # infoBoxes
#'   fluidRow(
#'     bs4InfoBox(
#'       title = "Messages",
#'       value = 1410,
#'       icon = "envelope"
#'       ),
#'       bs4InfoBox(
#'         title = "Bookmarks",
#'         status = "info",
#'         value = 240,
#'         icon = "bookmark"
#'       ),
#'       bs4InfoBox(
#'         title = "Comments",
#'         gradientColor = "danger",
#'         value = 41410,
#'         icon = "comments"
#'       )
#'   ),
#'
#'   # valueBoxes
#'   fluidRow(
#'     bs4ValueBox(
#'       value = uiOutput("orderNum"),
#'       subtitle = "New Orders",
#'       icon = "credit-card",
#'       href = "http://google.com"
#'     ),
#'     bs4ValueBox(
#'       value = "60%",
#'       subtitle = "Approval Rating",
#'       icon = "line-chart",
#'       status = "success"
#'     ),
#'     bs4ValueBox(
#'       value = htmlOutput("progress"),
#'       subtitle = "Progress",
#'       icon = "users",
#'       status = "danger"
#'     )
#'   ),
#'
#'   # Boxes
#'   fluidRow(
#'     bs4Card(
#'      status = "primary",
#'      sliderInput("orders", "Orders", min = 1, max = 2000, value = 650),
#'      selectInput(
#'       "progress",
#'       "Progress",
#'        choices = c(
#'          "0%" = 0, "20%" = 20, "40%" = 40,
#'           "60%" = 60, "80%" = 80, "100%" = 100
#'        )
#'       )
#'     ),
#'    bs4Card(
#'     title = "Histogram box title",
#'     status = "warning",
#'     solidHeader = TRUE,
#'     collapsible = TRUE,
#'     plotOutput("plot", height = 250)
#'     )
#'   )
#' )
#'
#' server <- function(input, output, session) {
#'
#'   output$orderNum <- renderText({
#'     prettyNum(input$orders, big.mark=",")
#'   })
#'
#'   output$orderNum2 <- renderText({
#'     prettyNum(input$orders, big.mark=",")
#'   })
#'
#'   output$progress <- renderUI({
#'     tagList(input$progress, tags$sup(style="font-size: 20px", "%"))
#'   })
#'
#'   output$progress2 <- renderUI({
#'     paste0(input$progress)
#'   })
#'
#'
#'   output$plot <- renderPlot({
#'     hist(rnorm(input$orders))
#'   })
#'
#' }
#'
#' shinyApp(ui, server)
#'
#' }
useBs4Dash <- function(old_school = FALSE) {
  if (!requireNamespace(package = "bs4Dash"))
    message("Package 'bs4Dash' is required to run this function")
  deps <- findDependencies(bs4Dash::bs4DashPage(
    old_school = old_school,
    navbar = bs4Dash::bs4DashNavbar(),
    sidebar = bs4Dash::bs4DashSidebar(),
    body = bs4Dash::bs4DashBody()
  ))
  attachDependencies(tags$div(), value = deps)
}
