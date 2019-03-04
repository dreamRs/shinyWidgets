#' Use HTML templates in 'shiny'
#'
#' Allow to use functions from 'shinydashboard', 'shinydashboardPlus', 'bs4Dash', 'shinymaterial' into a classic 'shiny' app,
#' without the need to use sidebars, navbars or any sofisticated layout. The idea is
#' to be as simple as possible.
#'
#' @param lib Choose a flavor among \code{c("shinydashboard", "shinydashboardPlus", "bs4Dash", "shinymaterialPlus")}.
#'
#' @export
#'
#' @importFrom htmltools findDependencies attachDependencies
#'
#' @examples
#' \dontrun{
#'
#' # shinydashboard
#'
#' if (interactive()) {
#'
#' library(shiny)
#' library(shinydashboard)
#' library(shinyWidgets)
#'
#' # example taken from ?box
#'
#' ui <- fluidPage(
#'   h1("Import shinydashboard elements inside shiny!", align = "center"),
#'   h5("Don't need any sidebar, navbar, ...", align = "center"),
#'   h5("Only focus on basic elements for a pure interface", align = "center"),
#'
#'   # use this in non shinydashboard app
#'   setBackgroundColor(color = "ghostwhite"),
#'   useTemplate(lib = "shinydashboard"),
#'   # -----------------
#'
#'   # infoBoxes
#'   fluidRow(
#'     infoBox(
#'       "Orders", uiOutput("orderNum2"), "Subtitle", icon = icon("credit-card")
#'     ),
#'     infoBox(
#'       "Approval Rating", "60%", icon = icon("line-chart"), color = "green",
#'       fill = TRUE
#'     ),
#'     infoBox(
#'       "Progress", uiOutput("progress2"), icon = icon("users"), color = "purple"
#'     )
#'   ),
#'
#'   # valueBoxes
#'   fluidRow(
#'     valueBox(
#'       uiOutput("orderNum"), "New Orders", icon = icon("credit-card"),
#'       href = "http://google.com"
#'     ),
#'     valueBox(
#'       tagList("60", tags$sup(style="font-size: 20px", "%")),
#'       "Approval Rating", icon = icon("line-chart"), color = "green"
#'     ),
#'     valueBox(
#'       htmlOutput("progress"), "Progress", icon = icon("users"), color = "purple"
#'     )
#'   ),
#'
#'   # Boxes
#'   fluidRow(
#'     box(status = "primary",
#'         sliderInput("orders", "Orders", min = 1, max = 2000, value = 650),
#'         selectInput("progress", "Progress",
#'                     choices = c("0%" = 0, "20%" = 20, "40%" = 40, "60%" = 60, "80%" = 80,
#'                                 "100%" = 100)
#'         )
#'     ),
#'     box(title = "Histogram box title",
#'         status = "warning", solidHeader = TRUE, collapsible = TRUE,
#'         plotOutput("plot", height = 250)
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
#'     paste0(input$progress, "%")
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
#'
#' # shinydashboardPlus
#' #' if (interactive()) {
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
#'   h1("Import shinydashboardPlus elements inside shiny!", align = "center"),
#'   h5("Don't need any sidebar, navbar, ...", align = "center"),
#'   h5("Only focus on basic elements for a pure interface", align = "center"),
#'
#'   # use this in non shinydashboardPlus app
#'   useTemplate(lib = "shinydashboardPlus"),
#'   setBackgroundColor(color = "ghostwhite"),
#'
#'   # boxPlus
#'   fluidRow(
#'    boxPlus(
#'      title = "Closable Box with dropdown",
#'      closable = TRUE,
#'      status = "warning",
#'      solidHeader = FALSE,
#'      collapsible = TRUE,
#'      enable_dropdown = TRUE,
#'      dropdown_icon = "wrench",
#'      dropdown_menu = dropdownItemList(
#'        dropdownItem(url = "http://www.google.com", name = "Link to google"),
#'        dropdownItem(url = "#", name = "item 2"),
#'        dropdownDivider(),
#'        dropdownItem(url = "#", name = "item 3")
#'      ),
#'      p("Box Content")
#'    ),
#'    boxPlus(
#'      title = "Closable box, with label",
#'      closable = TRUE,
#'      enable_label = TRUE,
#'      label_text = 1,
#'      label_status = "danger",
#'      status = "warning",
#'      solidHeader = FALSE,
#'      collapsible = TRUE,
#'      p("Box Content")
#'    )
#'   ),
#'
#'   br(),
#'
#'   # gradientBoxes
#'   fluidRow(
#'     gradientBox(
#'      title = "My gradient Box",
#'      icon = "fa fa-th",
#'      gradientColor = "teal",
#'      boxToolSize = "sm",
#'      footer = column(
#'        width = 12,
#'        align = "center",
#'        sliderInput(
#'          "obs",
#'          "Number of observations:",
#'          min = 0, max = 1000, value = 500
#'        )
#'      ),
#'      plotOutput("distPlot")
#'     ),
#'     gradientBox(
#'      title = "My gradient Box",
#'      icon = "fa fa-heart",
#'      gradientColor = "maroon",
#'      boxToolSize = "xs",
#'      closable = TRUE,
#'      footer = "The footer goes here. You can include anything",
#'      "This is a gradient box"
#'     )
#'   ),
#'
#'   br(),
#'
#'   # extra elements
#'   fluidRow(
#'   column(
#'    width = 6,
#'    timelineBlock(
#'      reversed = FALSE,
#'      timelineEnd(color = "danger"),
#'      timelineLabel(2018, color = "teal"),
#'      timelineItem(
#'        title = "Item 1",
#'        icon = "gears",
#'        color = "olive",
#'        time = "now",
#'        footer = "Here is the footer",
#'        "This is the body"
#'      ),
#'      timelineItem(
#'        title = "Item 2",
#'        border = FALSE
#'      ),
#'      timelineLabel(2015, color = "orange"),
#'      timelineItem(
#'        title = "Item 3",
#'        icon = "paint-brush",
#'        color = "maroon",
#'        timelineItemMedia(src = "http://placehold.it/150x100"),
#'        timelineItemMedia(src = "http://placehold.it/150x100")
#'      ),
#'      timelineStart(color = "gray")
#'     )
#'    ),
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
#'
#' # bs4Dash
#' #' if (interactive()) {
#'
#' library(shiny)
#' library(bs4Dash)
#' library(shinyWidgets)
#'
#' # example taken from ?box
#'
#' ui <- fluidPage(
#'   h1("Import bs4Dash elements inside shiny!", align = "center"),
#'   h5("Don't need any sidebar, navbar, ...", align = "center"),
#'   h5("Only focus on basic elements for a pure interface", align = "center"),
#'
#'   # use this in non dashboard app
#'   setBackgroundColor(color = "ghostwhite"),
#'   useTemplate(lib = "bs4Dash"),
#'   # -----------------
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
#'     paste0(input$progress, "%")
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
#'
#' # shinymaterial
#' #' if (interactive()) {
#'
#' library(shiny)
#' library(shinyWidgets)
#' library(shinymaterial)
#' library(shinymaterialPlus)
#'
#' ui <- fluidPage(
#'   title = "Material design",
#'   useTemplate(lib = "shinymaterialPlus"),
#'   h1("Import materialize CSS inside shiny!", align = "center"),
#'   h5("Don't need any sidebar, navbar, ...", align = "center"),
#'   h5("Only focus on basic elements for a pure interface", align = "center"),
#'   hr(),
#'   fluidRow(
#'     column(
#'       width = 3,
#'       shinymaterialPlus::material_card(
#'         title = "Example Card",
#'         depth = 5,
#'         hoverable = FALSE,
#'         size = "large",
#'         tabs = TRUE,
#'         tabscontent = material_tabs(
#'           tabs = c(
#'             "Example Tab 1" = "example_tab_1",
#'             "Example Tab 2" = "example_tab_2"
#'           ),
#'           color = "deep-purple"
#'         ),
#'         material_card_tabs(
#'           id = "example_tab_1",
#'           "Tab 1"
#'         ),
#'         material_card_tabs(id = "example_tab_2", "Tab 2"),
#'         activator = TRUE,
#'         extra = tagList(
#'           "More info here!",
#'           material_badge(1, custom_caption = TRUE),
#'           material_badge(content = "Test", color = "red", type = "new")
#'         ),
#'         #color = "deep-orange",
#'         image = TRUE,
#'         src = "http://www.oxygenna.com/wp-content/uploads/2015/11/18.jpg"
#'       )
#'     ),
#'     column(
#'       width = 3,
#'       shinymaterialPlus::material_card(
#'         title = "Card with footer",
#'         depth = NULL,
#'         size = "large",
#'         activator = TRUE,
#'         extra = "More info here!",
#'         image = TRUE,
#'         src = "https://i.pinimg.com/originals/73/38/6e/73386e0513d4c02a4fbb814cadfba655.jpg",
#'         footer = tagList(
#'           material_row(
#'             material_column(
#'               s_width = 6,
#'               shiny::a(href = "http://www.google.fr", "Link 1")
#'             ),
#'             material_column(
#'               s_width = 6,
#'               shiny::a(href = "http://www.google.fr", "Link 2")
#'             )
#'           )
#'         )
#'       )
#'     ),
#'     column(
#'       width = 4,
#'       material_collapsible(
#'         type = "popout",
#'         material_collapsible_item(
#'           "Lorem ipsum dolor sit amet, consectetur adipiscing elit,
#'               sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
#'               Ut enim ad minim veniam, quis nostrud exercitation ullamco
#'               laboris nisi ut aliquip ex ea commodo consequat",
#'           header = "First",
#'           active = TRUE,
#'           icon = "filter_drama"
#'         ),
#'         material_collapsible_item(
#'           "Lorem ipsum dolor sit amet, consectetur adipiscing elit,
#'               sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
#'               Ut enim ad minim veniam, quis nostrud exercitation ullamco
#'               laboris nisi ut aliquip ex ea commodo consequat",
#'           header = "Second",
#'           icon = "place"
#'         ),
#'         material_collapsible_item(
#'           "Lorem ipsum dolor sit amet, consectetur adipiscing elit,
#'               sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
#'               Ut enim ad minim veniam, quis nostrud exercitation ullamco
#'               laboris nisi ut aliquip ex ea commodo consequat",
#'           header = "Third",
#'           icon = "whatshot"
#'         )
#'       )
#'     )
#'   ),
#'   fluidRow(
#'     column(
#'       width = 6,
#'       material_timeline(
#'         material_timeline_item(
#'           material_timeline_card(
#'             src = "https://i.pinimg.com/originals/df/0a/3e/df0a3e2ec30abb1c92d145ef165b714f.gif",
#'             title = "Item 1",
#'             extra = "Some text here!"
#'           ),
#'           marker_icon = "language",
#'           marker_color = "blue",
#'           marker_size = "large"
#'         ),
#'         material_timeline_item(
#'           material_timeline_card(
#'             src = "https://kulturologia.ru/files/u12645/Rhads-2.jpg",
#'             hoverable = TRUE,
#'             title = "Item 2",
#'             extra = "Some text here!"
#'           ),
#'           marker_icon = "work",
#'           marker_color = "green",
#'           marker_size = "small"
#'         )
#'       )
#'     ),
#'     column(
#'       width = 6,
#'       material_column(
#'         shinymaterialPlus::material_button(
#'           input_id = "example_button",
#'           label = "Button",
#'           icon = "cloud",
#'           depth = 5,
#'           color = "blue lighten-2",
#'           pulse = TRUE
#'         ),
#'         shinymaterialPlus::material_button(
#'           input_id = "example_button2",
#'           icon = "cloud",
#'           label = "",
#'           depth = 3,
#'           color = "green lighten-2",
#'           pulse = TRUE,
#'           floating = TRUE
#'         ),
#'         shinymaterialPlus::material_button(
#'           input_id = "example_button3",
#'           icon = "cloud",
#'           label = "large button",
#'           depth = 3,
#'           color = "orange lighten-2",
#'           size = "large"
#'         ),
#'         shinymaterialPlus::material_button(
#'           input_id = "example_button3",
#'           icon = "cloud",
#'           label = "Small disabled button",
#'           depth = 3,
#'           color = "orange lighten-2",
#'           size = "small",
#'           disabled = TRUE
#'         )
#'       )
#'     )
#'   )
#'   )
#'   shinyApp(ui, server = function(input, output) {})
#'
#' }
#'
#' }
useTemplate <- function(lib = c("shinydashboard", "shinydashboardPlus", "bs4Dash", "shinymaterialPlus")) {
  lib <- match.arg(lib)

  if (!requireNamespace(package = lib))
    message(paste0("Package ", lib, " is required to run this function"))

  deps <- if (lib == "shinydashboard") {
    findDependencies(shinydashboard::dashboardPage(
      header = shinydashboard::dashboardHeader(),
      sidebar = shinydashboard::dashboardSidebar(),
      body = shinydashboard::dashboardBody()
    ))
  } else if (lib == "shinydashboardPlus") {
    findDependencies(shinydashboardPlus::dashboardPagePlus(
      header = shinydashboardPlus::dashboardHeaderPlus(),
      sidebar = shinydashboard::dashboardSidebar(),
      body = shinydashboard::dashboardBody()
    ))
  } else if (lib == "bs4Dash") {
    findDependencies(bs4Dash::bs4DashPage(
      navbar = bs4Dash::bs4DashNavbar(),
      sidebar = bs4Dash::bs4DashSidebar(),
      body = bs4Dash::bs4DashBody()
    ))
  } else if (lib == "shinymaterialPlus") {
    findDependencies(shinymaterialPlus::material_page())
  }

  if (lib == "shinydashboard") {
    attachDependencies(tags$div(class = "main-sidebar", style = "display: none;"), value = deps)
  } else {
    attachDependencies(tags$div(), value = deps)
  }

}












