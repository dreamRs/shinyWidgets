
# Panels ---------------------------------

library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  # Try with different Bootstrap version
  # theme = bslib::bs_theme(version = 5),

  tags$h2("Bootstrap panel"),

  # Default
  panel(
    "Content goes here",
  ),
  panel(
    "With status",
    status = "primary"
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




