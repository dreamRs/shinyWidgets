
library(shiny)
library(shinyWidgets)

# data
cities <- data.frame(
  continent = c("America", "America", "America", "Africa",
                "Africa", "Africa", "Africa", "Africa",
                "Europe", "Europe", "Europe", "Antarctica"),
  country = c("Canada", "Canada", "USA", "Tunisia", "Tunisia",
              "Tunisia", "Algeria", "Algeria", "Italy", "Germany", "Spain", NA),
  city = c("Trois-Rivières", "Québec", "San Francisco", "Tunis",
           "Monastir", "Sousse", "Alger", "Oran", "Rome", "Berlin", "Madrid", NA),
  stringsAsFactors = FALSE
)

# app
ui <- fluidPage(
  tags$h2("treeInput() example"),
  treeInput(
    inputId = "ID1",
    label = "Select cities:",
    choices = create_tree(cities),
    # selected = "San Francisco",
    returnValue = "text"
  ),
  verbatimTextOutput("res1")
)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$ID1)

}

if (interactive())
  shinyApp(ui, server)
