
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
  tags$h2("updateQuercusInput() example"),
  fluidRow(
    column(
      width = 6,
      quercusInput(
        inputId = "ID1",
        label = "Select cities:",
        choices = create_tree(cities),
        multiSelectEnabled = TRUE,
        initiallyExpanded = TRUE,
        returnValue = "text"
      ),
      verbatimTextOutput("res1")
    ),
    column(
      width = 6,
      textInput(
        inputId = "label",
        label = "Update label:",
        value = "Select cities:"
      ),
      checkboxGroupInput(
        inputId = "val_country",
        label = "Select countries:",
        choices = unique(cities$country),
        inline = TRUE
      ),
      checkboxGroupInput(
        inputId = "val_city",
        label = "Select cities:",
        choices = unique(cities$city),
        inline = TRUE
      ),
      actionButton("clear", "Clear selected"),
      actionButton("update", "Update choices"),
      actionButton("back", "Back to first choices")
    )
  )
)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$ID1)

  observe(
    updateTreeInput(inputId = "ID1", label = input$label)
  )

  observe(
    updateQuercusInput(inputId = "ID1", selected = input$val_country)
  )

  observe(
    updateQuercusInput(inputId = "ID1", selected = input$val_city)
  )

  observeEvent(input$clear, {
    updateQuercusInput(inputId = "ID1", selected = character(0))
    updateCheckboxGroupInput(inputId = "val_country", selected = character(0))
    updateCheckboxGroupInput(inputId = "val_city", selected = character(0))
  })

  observeEvent(input$update, {
    cities <- data.frame(
      continent = c("Asia", "Asia", "Asia", "Australia",
                    "Australia", "Australia", "Australia", "Australia",
                    "South America", "South America", "South America", "Arctic"),
      country = c("Japan", "Japan", "China", "Australia", "Australia",
                  "Australia", "New Zealand", "New Zealand",
                  "Brazil", "Argentina", "Chile", NA),
      city = c("Tokyo", "Kyoto", "Beijing", "Sydney",
               "Melbourne", "Perth", "Auckland", "Wellington",
               "São Paulo", "Buenos Aires", "Santiago", NA),
      stringsAsFactors = FALSE
    )
    updateQuercusInput(inputId = "ID1", choices = create_tree(cities))
  })

  observeEvent(input$back, {
    updateQuercusInput(inputId = "ID1", choices = create_tree(cities))
  })
}

if (interactive())
  shinyApp(ui, server)
