
# List group -----------------------------

library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h2("List group"),

  tags$b("List of item:"),
  list_group(
    "First item",
    "Second item",
    "And third item"
  ),

  tags$b("Set active item:"),
  list_group(
    list(class = "active", "First item"),
    "Second item",
    "And third item"
  )
)

server <- function(input, output, session) {

}

if (interactive())
  shinyApp(ui, server)
