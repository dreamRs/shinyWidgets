
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  html_dependency_winbox()
)

server <- function(input, output, session) {

  WinBox(
    title = "WinBox",
    ui = tagList(
      tags$h3("Hello from WinBox!")
    )
  )

}

if (interactive())
  shinyApp(ui, server)
