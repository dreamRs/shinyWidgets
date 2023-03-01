
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
  tags$h2("updateTreeInput() example"),
  fluidRow(
    column(
      width = 6,
      treeInput(
        inputId = "ID1",
        label = "Select cities:",
        choices = create_tree(cities),
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
      actionButton("clear", "Clear selected")
    )
  )
)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$ID1)

  observe(
    updateTreeInput(inputId = "ID1", label = input$label)
  )

  observeEvent(
    input$val_country,
    updateTreeInput(inputId = "ID1", selected = input$val_country)
  )

  observeEvent(
    input$val_city,
    updateTreeInput(inputId = "ID1", selected = input$val_city)
  )

  observeEvent(input$clear, {
      updateTreeInput(inputId = "ID1", selected = character(0))
      updateCheckboxGroupInput(inputId = "val_country", selected = character(0))
      updateCheckboxGroupInput(inputId = "val_city", selected = character(0))
    }
  )
}

if (interactive())
  shinyApp(ui, server)
