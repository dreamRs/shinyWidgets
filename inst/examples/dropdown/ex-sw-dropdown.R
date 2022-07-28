

library("shiny")
library("shinyWidgets")

ui <- fluidPage(
  tags$h1("Exemple dropdown"),

  dropdown(
    tags$h3("List of Input"),
    shinyWidgets::pickerInput(inputId = 'xcol', label = 'X Variable', choices = names(iris)),
    selectInput(inputId = 'ycol', label = 'Y Variable', choices = names(iris), selected = names(iris)[[2]]),
    sliderInput(inputId = 'clusters', label = 'Cluster count', value = 3, min = 1, max = 9),
    style = "material-circle", icon = icon("gear"), status = "danger",
    animate = animateOptions(enter = animations$zooming_entrances$zoomInDown, exit = animations$zooming_exits$zoomOutUp, duration = 1)
  ),
  plotOutput(outputId = 'plot1')

)

server <- function(input, output, session) {
  selectedData <- reactive({
    iris[, c(input$xcol, input$ycol)]
  })
  clusters <- reactive({
    kmeans(selectedData(), input$clusters)
  })
  output$plot1 <- renderPlot({
    palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
              "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))
    par(mar = c(5.1, 4.1, 0, 1))
    plot(selectedData(),
         col = clusters()$cluster,
         pch = 20, cex = 3)
    points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
  })
}

shinyApp(ui = ui, server = server)
