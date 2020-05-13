library("shiny")
library("shinyWidgets")

ui <- fluidPage(
  tags$h1("Click the button to open the alert"),
  actionButton(
    inputId = "sw_html",
    label = "Sweet alert with plot"
  )
)

server <- function(input, output, session) {

  observeEvent(input$sw_html, {
    show_alert(
      title = "Yay a plot!",
      text = tags$div(
        plotOutput(outputId = "plot"),
        sliderInput(
          inputId = "clusters",
          label = "Number of clusters",
          min = 2, max = 6, value = 3, width = "100%"
        )
      ),
      html = TRUE,
      width = "80%"
    )
  })

  output$plot <- renderPlot({
    plot(Sepal.Width ~ Sepal.Length,
         data = iris, col = Species,
         pch = 20, cex = 2)
    points(kmeans(iris[, 1:2], input$clusters)$centers,
           pch = 4, cex = 4, lwd = 4)
  })
}


if (interactive())
  shinyApp(ui, server)
