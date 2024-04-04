
library(shiny)
library(shinyWidgets)
library(reactable)
library(ggplot2)
data("midwest", package = "ggplot2")

ui <- fluidPage(
  html_dependency_winbox(),
  actionButton(inputId = "show", label = "Show WinBox")
)

server <- function(input, output, session) {

  observeEvent(input$show, {
    inputId <- paste0("var", input$show)
    WinBox(
      title = "With an htmlwidget",
      ui = tagList(
        tags$h3("Midwest demographics"),
        renderReactable({
          reactable(data = midwest, bordered = TRUE, striped = TRUE)
        })
      ),
      options = wbOptions(height = 630)
    )
  })

}

if (interactive())
  shinyApp(ui, server)
