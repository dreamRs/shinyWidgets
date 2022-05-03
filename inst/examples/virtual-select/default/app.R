library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h2("Virtual Select"),

  virtualSelectInput(
    inputId = "single",
    label = "Single select :",
    choices = month.name,
    search = TRUE
  ),
  verbatimTextOutput("res_single"),

  virtualSelectInput(
    inputId = "multiple",
    label = "Multiple select:",
    choices = setNames(month.abb, month.name),
    multiple = TRUE
  ),
  verbatimTextOutput("res_multiple")
)

server <- function(input, output, session) {
  output$res_single <- renderPrint(input$single)
  output$res_multiple <- renderPrint(input$multiple)
}

if (interactive())
  shinyApp(ui, server)
