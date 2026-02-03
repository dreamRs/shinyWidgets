
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
  theme = bslib::bs_theme(version = 5, preset = "bootstrap"),
  tags$h2("quercusInput() example"),
  fluidRow(
    column(
      width = 4,

      quercusInput(
        inputId = "ID1",
        label = "Select cities: (initiallyExpanded = TRUE)",
        choices = create_tree(cities),
        initiallyExpanded = TRUE,
        returnValue = "text",
        width = "100%"
      ),
      verbatimTextOutput("res1"),

      quercusInput(
        inputId = "ID4",
        label = "Select cities: (multiSelectEnabled = TRUE)",
        choices = create_tree(cities),
        multiSelectEnabled = TRUE,
        returnValue = "text",
        width = "100%"
      ),
      verbatimTextOutput("res4")

    ),
    column(
      width = 4,

      quercusInput(
        inputId = "ID2",
        label = "Select cities: (searchEnabled = TRUE)",
        choices = create_tree(cities),
        searchEnabled = TRUE,
        returnValue = "text",
        width = "100%"
      ),
      verbatimTextOutput("res2"),

      quercusInput(
        inputId = "ID5",
        label = "Select cities: (checkboxSelectionEnabled = TRUE)",
        choices = create_tree(cities),
        checkboxSelectionEnabled = TRUE,
        returnValue = "text",
        width = "100%"
      ),
      verbatimTextOutput("res5"),

      quercusInput(
        inputId = "ID7",
        label = "Select cities: (cascadeSelectChildren = TRUE)",
        choices = create_tree(cities),
        cascadeSelectChildren = TRUE,
        returnValue = "text",
        width = "100%"
      ),
      verbatimTextOutput("res7")

    ),
    column(
      width = 4,

      quercusInput(
        inputId = "ID3",
        label = "Select cities: (multiSelectEnabled = TRUE, returnValue = \"all\")",
        choices = create_tree(cities),
        multiSelectEnabled = TRUE,
        returnValue = "all",
        width = "100%"
      ),
      verbatimTextOutput("res3"),

      quercusInput(
        inputId = "ID6a",
        label = "Select cities: (selected value)",
        choices = create_tree(cities),
        selected = "Monastir",
        returnValue = "text",
        width = "100%"
      ),
      verbatimTextOutput("res6a"),

      quercusInput(
        inputId = "ID6b",
        label = "Select cities: (selected valueS)",
        choices = create_tree(cities),
        multiSelectEnabled = TRUE,
        selected = c("Monastir", "Madrid"),
        returnValue = "text",
        width = "100%"
      ),
      verbatimTextOutput("res6b")

    )
  )
)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$ID1)
  output$res2 <- renderPrint(input$ID2)
  output$res3 <- renderPrint(input$ID3)
  output$res4 <- renderPrint(input$ID4)
  output$res5 <- renderPrint(input$ID5)
  output$res6a <- renderPrint(input$ID6a)
  output$res6b <- renderPrint(input$ID6b)
  output$res7 <- renderPrint(input$ID7)

}

if (interactive())
  shinyApp(ui, server)
