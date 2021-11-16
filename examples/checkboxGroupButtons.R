library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h1("checkboxGroupButtons examples"),

  checkboxGroupButtons(
    inputId = "somevalue1",
    label = "Make a choice: ",
    choices = c("A", "B", "C")
  ),
  verbatimTextOutput("value1"),

  checkboxGroupButtons(
    inputId = "somevalue2",
    label = "With custom status:",
    choices = names(iris),
    status = "primary"
  ),
  verbatimTextOutput("value2"),

  checkboxGroupButtons(
    inputId = "somevalue3",
    label = "With icons:",
    choices = names(mtcars),
    checkIcon = list(
      yes = icon("check-square"),
      no = icon("square-o")
    )
  ),
  verbatimTextOutput("value3")
)

server <- function(input, output) {

  output$value1 <- renderPrint({ input$somevalue1 })
  output$value2 <- renderPrint({ input$somevalue2 })
  output$value3 <- renderPrint({ input$somevalue3 })

}

if (interactive())
  shinyApp(ui, server)
