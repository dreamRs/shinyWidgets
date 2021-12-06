library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  # Test with different version of Bootstrap
  # theme = bslib::bs_theme(version = 5),

  tags$h2("numericInputIcon examples"),
  fluidRow(
    column(
      width = 6,
      numericInputIcon(
        inputId = "ex1",
        label = "With an icon",
        value = 10,
        icon = icon("percent")
      ),
      verbatimTextOutput("res1"),
      numericInputIcon(
        inputId = "ex2",
        label = "With an icon (right)",
        value = 90,
        step = 10,
        icon = list(NULL, icon("percent"))
      ),
      verbatimTextOutput("res2"),
      numericInputIcon(
        inputId = "ex3",
        label = "With text",
        value = 50,
        icon = list("km/h")
      ),
      verbatimTextOutput("res3"),
      numericInputIcon(
        inputId = "ex4",
        label = "Both side",
        value = 10000,
        icon = list(icon("dollar-sign"), ".00")
      ),
      verbatimTextOutput("res4"),
      numericInputIcon(
        inputId = "ex5",
        label = "Sizing",
        value = 10000,
        icon = list(icon("dollar-sign"), ".00"),
        size = "lg"
      ),
      verbatimTextOutput("res5")
    )
  )
)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$ex1)
  output$res2 <- renderPrint(input$ex2)
  output$res3 <- renderPrint(input$ex3)
  output$res4 <- renderPrint(input$ex4)
  output$res5 <- renderPrint(input$ex5)

}


if (interactive())
  shinyApp(ui, server)
