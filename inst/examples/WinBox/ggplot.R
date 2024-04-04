
library(shiny)
library(shinyWidgets)
library(ggplot2)
data("economics", package = "ggplot2")

ui <- fluidPage(
  html_dependency_winbox(),
  actionButton(inputId = "show", label = "Show WinBox")
)

server <- function(input, output, session) {

  observeEvent(input$show, {
    inputId <- paste0("var", input$show)
    WinBox(
      title = "With ggplot2",
      ui = tagList(
        tags$h3("Economic chart"),
        selectInput(inputId, "Select a variable:", names(economics)[-1]),
        renderPlot({
          ggplot(economics) +
            aes(x = date, y = !!sym(input[[inputId]])) +
            geom_line()
        })
      ),
      options = wbOptions(height = 630)
    )
  })

}

if (interactive())
  shinyApp(ui, server)
