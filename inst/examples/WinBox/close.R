
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  html_dependency_winbox(),
  tags$p("With an ID:"),
  actionButton(inputId = "show", label = "Show WinBox with ID"),
  actionButton(inputId = "close", label = "Close WinBox with ID"),
  tags$p("Without ID, close last one:"),
  actionButton(inputId = "show_mult", label = "Show multiple WinBox"),
  actionButton(inputId = "close_last", label = "Close last WinBox")
)

server <- function(input, output, session) {

  observeEvent(input$show, {
    WinBox(
      id = "mywinbox",
      title = "WinBox window",
      ui = tags$div(
        style = "padding: 10px;",
        tags$h2("Hello from WinBox!"),
        "Text content of winbox."
      )
    )
  })

  observeEvent(input$close, closeWinBox("mywinbox"))

  observeEvent(input$show_mult, {
    WinBox(
      title = paste("WinBox window", input$show_mult),
      ui = tags$div(
        style = "padding: 10px;",
        tags$h2("Hello from WinBox!"),
        "Text content of winbox."
      )
    )
  })
  observeEvent(input$close_last, closeWinBox(NULL))

}

shinyApp(ui, server)
