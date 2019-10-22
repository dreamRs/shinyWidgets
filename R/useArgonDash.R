#' Use 'argonDash' in 'shiny'
#'
#' Allow to use functions from 'argonDash' into a classic 'shiny' app,
#' specifically \code{argonCard}, \code{argonTabSet} and \code{argonInfoCard}.
#'
#' @export
#'
#' @importFrom htmltools findDependencies attachDependencies
#'
#' @examples
#' if (interactive()) {
#'
#' library(shiny)
#' library(argonR)
#' library(argonDash)
#' library(shinyWidgets)
#'
#' ui <- fluidPage(
#'   h1("Import argonDash elements inside shiny!", align = "center"),
#'   h5("Don't need any sidebar, navbar, ...", align = "center"),
#'   h5("Only focus on basic elements for a pure interface", align = "center"),
#'
#'   # use this in non dashboard app
#'   setBackgroundColor(color = "ghostwhite"),
#'   useArgonDash(),
#'
#'   fluidRow(
#'    column(
#'     width = 6,
#'      argonCard(
#'      status = "primary",
#'      width = 12,
#'      title = "Card 1",
#'      hover_lift = TRUE,
#'      shadow = TRUE,
#'      icon = "check-bold",
#'      src = "#",
#'      "Argon is a great free UI package based on Bootstrap 4
#'        that includes the most important components and features."
#'     )
#'    ),
#'    column(
#'     width = 6,
#'     argonTabSet(
#'      id = "tab-1",
#'      card_wrapper = TRUE,
#'      horizontal = TRUE,
#'      circle = FALSE,
#'      size = "sm",
#'      width = 6,
#'      iconList = list("cloud-upload-96", "bell-55", "calendar-grid-58"),
#'      argonTab(
#'        tabName = "Tab 1",
#'        active = TRUE,
#'        sliderInput(
#'         "number",
#'         "Number of observations:",
#'         min = 0,
#'         max = 100,
#'         value = 50
#'        ),
#'        uiOutput("progress")
#'      ),
#'      argonTab(
#'        tabName = "Tab 2",
#'        active = FALSE,
#'        prettyRadioButtons(
#'         inputId = "dist",
#'         inline = TRUE,
#'         animation = "pulse",
#'         label = "Distribution type:",
#'         c("Normal" = "norm",
#'          "Uniform" = "unif",
#'          "Log-normal" = "lnorm",
#'          "Exponential" = "exp")
#'         ),
#'         plotOutput("distPlot")
#'      ),
#'      argonTab(
#'        tabName = "Tab 3",
#'        active = FALSE,
#'        numericInput("valueBox", "Second value box:", 10, min = 1, max = 100)
#'      )
#'     )
#'    )
#'   ),
#'   br(),
#'   fluidRow(
#'    argonInfoCard(
#'     value = "350,897",
#'     title = "TRAFFIC",
#'     stat = 3.48,
#'     stat_icon = "arrow-up",
#'     description = "Since last month",
#'     icon = "chart-bar",
#'     icon_background = "danger",
#'     hover_lift = TRUE
#'    ),
#'    argonInfoCard(
#'      value = textOutput("value"),
#'      title = "NEW USERS",
#'      stat = -3.48,
#'      stat_icon = "arrow-down",
#'      description = "Since last week",
#'      icon = "chart-pie",
#'      icon_background = "warning",
#'      shadow = TRUE
#'    ),
#'    argonInfoCard(
#'      value = "924",
#'      title = "SALES",
#'      stat = -1.10,
#'      stat_icon = "arrow-down",
#'      description = "Since yesterday",
#'      icon = "users",
#'      icon_background = "yellow",
#'      background_color = "default"
#'    ),
#'    argonInfoCard(
#'      value = "49,65%",
#'      title = "PERFORMANCE",
#'      stat = 12,
#'      stat_icon = "arrow-up",
#'      description = "Since last month",
#'      icon = "percent",
#'      icon_background = "info",
#'      gradient = TRUE,
#'      background_color = "orange",
#'      hover_lift = TRUE
#'    )
#'   )
#' )
#'
#' server <- function(input, output, session) {
#'
#'  output$progress <- renderUI({
#'   argonProgress(value = input$number, status = "danger", text = "Custom Text")
#'  })
#'
#'  output$distPlot <- renderPlot({
#'   dist <- switch(input$dist,
#'                  norm = rnorm,
#'                  unif = runif,
#'                  lnorm = rlnorm,
#'                  exp = rexp,
#'                  rnorm)
#'
#'   hist(dist(500))
#'  })
#'
#'  output$value <- renderText(input$valueBox)
#'
#' }
#'
#' shinyApp(ui, server)
#'
#' }
useArgonDash <- function() {
  if (!requireNamespace(package = "argonDash") & !requireNamespace(package = "argonR"))
    message("Package 'argonDash' and 'argonR' are required to run this function")
  deps <- findDependencies(argonDash::argonDashPage(
    navbar = argonDash::argonDashNavbar(),
    sidebar = argonDash::argonDashSidebar(id = "mysidebar"),
    header = argonDash::argonDashHeader(),
    body = argonDash::argonDashBody()
  ))
  attachDependencies(tags$div(), value = deps)
}
