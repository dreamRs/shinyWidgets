

library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  html_dependency_winbox(),
  actionButton("minimize", "Minimize WinBox"),
  actionButton("maximize", "Maximize WinBox"),
  actionButton("setBackground", "Set background"),
  actionButton("setTitle", "Set title"),
  actionButton("resize", "Resize"),
  actionButton("move", "Move")
)

server <- function(input, output, session) {

  WinBox(
    id = "myWb",
    title = "WinBox",
    ui = tagList(
      tags$h3("Hello from WinBox!"),
      tags$p("Some content for the WinBox")
    )
  )

  observeEvent(input$minimize, {
    applyWinBox("myWb", "minimize")
  })

  observeEvent(input$maximize, {
    applyWinBox("myWb", "maximize")
  })

  observeEvent(input$setBackground, {
    applyWinBox("myWb", "setBackground", "#ff005d")
  })

  observeEvent(input$setTitle, {
    applyWinBox("myWb", "setTitle", "This is a new title")
  })

  observeEvent(input$resize, {
    applyWinBox("myWb", "resize", "50%", "50%")
  })

  observeEvent(input$move, {
    applyWinBox("myWb", "move", "center", "center")
  })

}

if (interactive())
  shinyApp(ui, server)

