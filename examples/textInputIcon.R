library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  # Test with different version of Bootstrap
  theme = bslib::bs_theme(version = 5),

  tags$h2("textInputIcon examples"),
  fluidRow(
    column(
      width = 6,
      textInputIcon(
        inputId = "ex1",
        label = "With an icon",
        icon = icon("circle-user")
      ),
      verbatimTextOutput("res1"),
      textInputIcon(
        inputId = "ex2",
        label = "With an icon (right)",
        icon = list(NULL, icon("circle-user"))
      ),
      verbatimTextOutput("res2"),
      textInputIcon(
        inputId = "ex3",
        label = "With text",
        icon = list("https://")
      ),
      verbatimTextOutput("res3"),
      textInputIcon(
        inputId = "ex4",
        label = "Both side",
        icon = list(icon("envelope"), "@mail.com")
      ),
      verbatimTextOutput("res4"),
      textInputIcon(
        inputId = "ex5",
        label = "Sizing",
        icon = list(icon("envelope"), "@mail.com"),
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
