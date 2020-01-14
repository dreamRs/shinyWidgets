if (interactive()) {
  library(shiny)
  library(shinyWidgets)

  ui <- fluidPage(
    tags$h2("Drop Menu xith Shiny Output"),
    dropMenu(
      actionButton("myid", "See what's inside"),
      plotOutput("plot", width = "600px"),
      sliderInput("n", "Number of obs.", 10, 500, 50)
    ),
    tags$br(),
    dropMenu(
      actionButton("see_table", "DT inside"),
      DT::DTOutput(outputId = "table")
    )
  )

  server <- function(input, output, session) {

    output$plot <- renderPlot({
      plot(density(rnorm(input$n)))
    })

    output$table <- DT::renderDT(iris)

  }

  shinyApp(ui, server)
}
