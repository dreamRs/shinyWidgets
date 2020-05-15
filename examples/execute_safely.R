library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h2("Execute code safely in server"),
  fileInput(
    inputId = "file",
    label = "Try to import something else than a text file (Excel for example)"
  ),
  verbatimTextOutput(outputId = "file_value")
)

server <- function(input, output, session) {

  options(warn = 2) # turns warnings into errors
  onStop(function() {
    options(warn = 0)
  })

  r <- reactive({
    req(input$file)
    execute_safely(
      read.csv(input$file$datapath)
    )
  })

  output$file_value <- renderPrint({
    head(r())
  })

}

if (interactive())
  shinyApp(ui, server)
