
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  html_dependency_winbox(),
  actionButton(inputId = "show", label = "Show WinBox as modal")
)

server <- function(input, output, session) {


  observeEvent(input$show, {
    WinBox(
      title = "WinBox as modal",
      ui = tagList(
        tags$h2("Hello from WinBox!"),
        "Text content of winbox.",
        actionButton("show2", "Open a normal winbox")
      ),
      options = wbOptions(modal = TRUE)
    )
  })

  observeEvent(input$show2, {
    WinBox(
      title = "Normal WinBox",
      ui = tagList(
        tags$h2("Hello from WinBox!"),
        "Text content of winbox."
      ),
      options = wbOptions(background = "firebrick")
    )
  })

}

if (interactive())
  shinyApp(ui, server)
