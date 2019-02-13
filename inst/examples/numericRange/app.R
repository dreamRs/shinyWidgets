library(shiny)
library(shinyWidgets)


# Define the UI
ui <- bootstrapPage(
  numericRangeInput('mpg', 'mpg range:', value = mtcars$mpg),
  plotOutput('plot')
)


# Define the server code
server <- function(input, output) {
  output$plot <- renderPlot({
    x <- mtcars[mtcars$mpg >= input$mpg[1] & mtcars$mpg <= input$mpg[2],]
    barplot(table(x$cyl))
  })
}

# Return a Shiny app object
shinyApp(ui = ui, server = server)
