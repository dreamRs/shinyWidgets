#' Use 'shinydashboardPlus' in 'shiny'
#'
#' Allow to use functions from 'shinydashboardPlus' into a classic 'shiny' app.
#'
#' @export
#'
#' @importFrom htmltools findDependencies attachDependencies
#'
#' @examples
#' if (interactive()) {
#'
#' library(shiny)
#' library(shinydashboard)
#' library(shinydashboardPlus)
#' library(shinyWidgets)
#'
#'
#' # example taken from ?box
#'
#' ui <- fluidPage(
#'   tags$h2("Classic shiny"),
#'
#'   # use this in non shinydashboardPlus app
#'   useShinydashboardPlus(),
#'   setBackgroundColor(color = "ghostwhite"),
#'
#'   # boxPlus
#'   box(
#'    title = "Improved box",
#'    closable = TRUE,
#'    width = 12,
#'    status = "warning",
#'    solidHeader = FALSE,
#'    collapsible = TRUE,
#'    label = boxLabel(
#'      text = 1,
#'      status = "danger",
#'      style = "circle"
#'    ),
#'    dropdownMenu = boxDropdown(
#'      boxDropdownItem("Link to google", href = "http://www.google.com"),
#'      boxDropdownItem("item 2", href = "#"),
#'      dropdownDivider(),
#'      boxDropdownItem("item 3", href = "#", icon = icon("table-cells"))
#'    ),
#'    sidebar = boxSidebar(
#'      startOpen = TRUE,
#'      id = "mycardsidebar",
#'      sliderInput(
#'        "obs",
#'        "Number of observations:",
#'        min = 0,
#'        max = 1000,
#'        value = 500
#'      )
#'    ),
#'    plotOutput("distPlot")
#'   ),
#'
#'   br(),
#'
#'   # extra elements
#'   fluidRow(
#'   column(
#'    width = 6,
#'    timelineBlock(
#'     reversed = FALSE,
#'     timelineEnd(color = "red"),
#'     timelineLabel(2018, color = "teal"),
#'     timelineItem(
#'       title = "Item 1",
#'       icon = icon("gears"),
#'       color = "olive",
#'       time = "now",
#'       footer = "Here is the footer",
#'       "This is the body"
#'     ),
#'     timelineItem(
#'       title = "Item 2",
#'       border = FALSE
#'     ),
#'     timelineLabel(2015, color = "orange"),
#'     timelineItem(
#'       title = "Item 3",
#'       icon = icon("paint-brush"),
#'       color = "maroon",
#'       timelineItemMedia(image = "https://placehold.it/150x100"),
#'       timelineItemMedia(image = "https://placehold.it/150x100")
#'     ),
#'     timelineStart(color = "purple")
#'    )
#'   ),
#'   column(
#'    width = 6,
#'    box(
#'      title = "Box with boxPad containing inputs",
#'      status = "warning",
#'      width = 12,
#'      fluidRow(
#'        column(
#'          width = 6,
#'          boxPad(
#'            color = "gray",
#'            sliderInput(
#'              "obs2",
#'              "Number of observations:",
#'              min = 0, max = 1000, value = 500
#'            ),
#'            checkboxGroupInput(
#'              "variable",
#'              "Variables to show:",
#'              c(
#'                "Cylinders" = "cyl",
#'                "Transmission" = "am",
#'                "Gears" = "gear"
#'              )
#'            ),
#'
#'            knobInput(
#'              inputId = "myKnob",
#'              skin = "tron",
#'              readOnly = TRUE,
#'              label = "Display previous:",
#'              value = 50,
#'              min = -100,
#'              displayPrevious = TRUE,
#'              fgColor = "#428BCA",
#'              inputColor = "#428BCA"
#'            )
#'          )
#'        ),
#'        column(
#'          width = 6,
#'          plotOutput("distPlot2", height = "200px"),
#'          tableOutput("data")
#'        )
#'      )
#'     )
#'    )
#'   )
#' )
#'
#' server <- function(input, output, session) {
#'
#'   output$distPlot <- renderPlot({
#'    hist(rnorm(input$obs))
#'   })
#'
#'   output$distPlot2 <- renderPlot({
#'     hist(rnorm(input$obs2))
#'   })
#'
#'   output$data <- renderTable({
#'     head(mtcars[, c("mpg", input$variable), drop = FALSE])
#'   }, rownames = TRUE)
#'
#' }
#'
#' shinyApp(ui, server)
#'
#' }
useShinydashboardPlus <- function() {
  if (!requireNamespace(package = "shinydashboardPlus"))
    message("Package 'shinydashboardPlus' is required to run this function")
  deps <- findDependencies(shinydashboardPlus::dashboardPage(
    header = shinydashboardPlus::dashboardHeader(),
    sidebar = shinydashboard::dashboardSidebar(),
    body = shinydashboard::dashboardBody()
  ))
  attachDependencies(tags$div(class = "main-sidebar", style = "display: none;"), value = deps)
}

