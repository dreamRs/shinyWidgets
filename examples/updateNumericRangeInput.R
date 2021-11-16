library(shiny)
library(shinyWidgets)

ui <- fluidPage(

  tags$br(),

  numericRangeInput(
    inputId = "my_id",
    label = "Numeric Range Input:",
    value = c(100, 400)
  ),
  verbatimTextOutput(outputId = "res1"),
  textInput("label", "Update label:"),
  numericInput("val1", "Update value 1:", 100),
  numericInput("val2", "Update value 2:", 400)

)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$my_id)

  observeEvent(input$label, {
    updateNumericRangeInput(
      session = session,
      inputId = "my_id",
      label = input$label
    )
  }, ignoreInit = TRUE)

  observe({
    updateNumericRangeInput(
      session = session,
      inputId = "my_id",
      value = c(input$val1, input$val2)
    )
  })
}

if (interactive())
  shinyApp(ui, server)
