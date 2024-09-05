
library(shiny)
pkgload::load_all()

ui <- fluidPage(
  tags$h2("Slim Select examples"),
  fluidRow(
    column(
      width = 3,
      slimSelectInput(
        inputId = "slim1",
        label = "Single slim select:",
        choices = month.name,
        width = "100%"
      ),
      verbatimTextOutput("res1")
    ),
    column(
      width = 3,
      slimSelectInput(
        inputId = "slim2",
        label = "Multiple slim select:",
        choices = month.name,
        multiple = TRUE,
        width = "100%"
      ),
      verbatimTextOutput("res2)
    )
  )
)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$slim1)

}

shinyApp(ui, server)
