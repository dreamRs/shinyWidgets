
library(shiny)
library(shinyWidgets)
library(apexcharter)
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
      title = "With an htmlwidget",
      ui = tagList(
        tags$h3("Economic chart"),
        selectInput(inputId, "Select a variable:", names(economics)[-1]),
        renderApexchart({
          apex(
            data = economics,
            type = "line",
            mapping = aes(x = date, y = !!sym(input[[inputId]]))
          ) %>%
            ax_stroke(width = 1)
        })
      ),
      options = wbOptions(height = 630)
    )
  })

}

if (interactive())
  shinyApp(ui, server)
