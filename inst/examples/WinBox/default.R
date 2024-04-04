
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  html_dependency_winbox(),
  actionButton(inputId = "show", label = "Show WinBox"),
  verbatimTextOutput("res")
)

server <- function(input, output, session) {

  observeEvent(input$show, {
    WinBox(
      title = "WinBox window",
      ui = tagList(
        tags$h2("Hello from WinBox!"),
        "Text content of winbox.",
        selectInput("month", "Select a month:", month.name)
      )
    )
  })

  output$res <- renderPrint(input$month)

}

if (interactive())
  shinyApp(ui, server)
