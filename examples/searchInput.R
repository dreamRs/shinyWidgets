library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  # theme = bslib::bs_theme(version = 5L, preset = "bootstrap"),
  tags$h1("Search Input"),
  br(),
  searchInput(
    inputId = "search", label = "Enter your text",
    placeholder = "A placeholder",
    btnSearch = icon("magnifying-glass"),
    btnReset = icon("xmark"),
    width = "450px"
  ),
  br(),
  verbatimTextOutput(outputId = "res")
)

server <- function(input, output, session) {
  output$res <- renderPrint(input$search)
}

if (interactive())
  shinyApp(ui = ui, server = server)
