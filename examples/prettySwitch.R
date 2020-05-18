library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h1("Pretty switches"),
  br(),

  fluidRow(
    column(
      width = 4,
      prettySwitch(inputId = "switch1", label = "Default:"),
      verbatimTextOutput(outputId = "res1"),
      br(),
      prettySwitch(
        inputId = "switch4",
        label = "Fill switch with status:",
        fill = TRUE, status = "primary"
      ),
      verbatimTextOutput(outputId = "res4")
    ),
    column(
      width = 4,
      prettySwitch(
        inputId = "switch2",
        label = "Danger status:",
        status = "danger"
      ),
      verbatimTextOutput(outputId = "res2")
    ),
    column(
      width = 4,
      prettySwitch(
        inputId = "switch3",
        label = "Slim switch:",
        slim = TRUE
      ),
      verbatimTextOutput(outputId = "res3")
    )
  )

)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$switch1)
  output$res2 <- renderPrint(input$switch2)
  output$res3 <- renderPrint(input$switch3)
  output$res4 <- renderPrint(input$switch4)

}

if (interactive())
  shinyApp(ui, server)
