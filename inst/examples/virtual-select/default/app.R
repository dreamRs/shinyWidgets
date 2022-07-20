library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h2("Virtual Select"),

  fluidRow(
    column(
      width = 4,
      virtualSelectInput(
        inputId = "single",
        label = "Single select :",
        choices = month.name,
        search = TRUE
      ),
      virtualSelectInput(
        inputId = "multiple",
        label = "Multiple select:",
        choices = setNames(month.abb, month.name),
        multiple = TRUE
      )
    ),
    column(
      width = 4,
      tags$b("Single select :"),
      verbatimTextOutput("res_single"),
      tags$b("Is virtual select open ?"),
      verbatimTextOutput(outputId = "res_single_open"),

      tags$br(),

      tags$b("Multiple select :"),
      verbatimTextOutput("res_multiple"),
      tags$b("Is virtual select open ?"),
      verbatimTextOutput(outputId = "res_multiple_open")
    )
  )


)

server <- function(input, output, session) {

  output$res_single <- renderPrint(input$single)
  output$res_single_open <- renderPrint(input$single_open)

  output$res_multiple <- renderPrint(input$multiple)
  output$res_multiple_open <- renderPrint(input$multiple_open)

}

if (interactive())
  shinyApp(ui, server)
