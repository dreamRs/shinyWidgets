library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h2("noUiSliderInput example"),

  noUiSliderInput(
    inputId = "noui1",
    min = 0, max = 100,
    value = 20
  ),
  verbatimTextOutput(outputId = "res1"),

  tags$br(),

  noUiSliderInput(
    inputId = "noui2", label = "Slider vertical:",
    min = 0, max = 1000, step = 50,
    value = c(100, 400), margin = 100,
    orientation = "vertical",
    width = "100px", height = "300px"
  ),
  verbatimTextOutput(outputId = "res2")
)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$noui1)
  output$res2 <- renderPrint(input$noui2)

}

if (interactive())
  shinyApp(ui, server)
