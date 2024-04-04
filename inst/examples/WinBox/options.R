
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  html_dependency_winbox(),
  actionButton(inputId = "show1", label = "Show WinBox"),
  actionButton(inputId = "show2", label = "Show WinBox as modal")
)

server <- function(input, output, session) {

  observeEvent(input$show1, {
    WinBox(
      title = "Custom background color and border",
      ui = tagList(
        tags$h2("Hello from WinBox!"),
        "Text content of winbox."
      ),
      options = wbOptions(
        background = "#112446",
        border = "0.5em",
        x = "center",
        y = "center",
        width = "50%",
        height = "50%"
      )
    )
  })

  observeEvent(input$show2, {
    WinBox(
      title = "WinBox as modal",
      ui = tagList(
        tags$h2("Hello from WinBox!"),
        "Text content of winbox."
      ),
      options = wbOptions(modal = TRUE)
    )
  })

}

if (interactive())
  shinyApp(ui, server)
