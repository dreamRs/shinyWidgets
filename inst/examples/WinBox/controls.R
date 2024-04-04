
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  html_dependency_winbox(),
  actionButton(inputId = "show", label = "Show WinBox")
)

server <- function(input, output, session) {

  observeEvent(input$show, {
    WinBox(
      title = "Custom controls",
      ui = tagList(
        tags$h2("Hello from WinBox!"),
        "Text content of winbox."
      ),
      controls = wbControls(
        min = FALSE,
        max = FALSE,
        resize = FALSE
      )
    )
  })

}

if (interactive())
  shinyApp(ui, server)
