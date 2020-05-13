
# Panels ---------------------------------

library(shiny)
library(shinyWidgets)

ui <- fluidPage(

  tags$h2("Bootstrap panel"),

  # Default
  panel(
    "Content goes here",
  ),

  # With header and footer
  panel(
    "Content goes here",
    heading = "My title",
    footer = "Something"
  ),

  # With status
  panel(
    "Content goes here",
    heading = "My title",
    status = "primary"
  ),

  # With table
  panel(
    heading = "A famous table",
    extra = tableOutput(outputId = "table")
  ),

  # With list group
  panel(
    heading = "A list of things",
    extra = list_group(
      "First item",
      "Second item",
      "And third item"
    )
  )
)

server <- function(input, output, session) {

  output$table <- renderTable({
    head(mtcars)
  }, width = "100%")

}

if (interactive())
  shinyApp(ui = ui, server = server)




