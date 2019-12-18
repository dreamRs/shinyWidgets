if (interactive()) {

  library(shiny)
  library(shinyWidgets)


  data("mpg", package = "ggplot2")


  ui <- fluidPage(
    fluidRow(
      column(
        width = 10, offset = 1,
        tags$h3("Filter data with picker group"),
        panel(
          pickerGroupUI(
            id = "my-filters",
            params = list(
              manufacturer = list(inputId = "manufacturer", label = "Manufacturer:"),
              model = list(inputId = "model", label = "Model:"),
              trans = list(inputId = "trans", label = "Trans:"),
              class = list(inputId = "class", label = "Class:")
            )
          ), status = "primary"
        ),
        DT::dataTableOutput(outputId = "table")
      )
    )
  )

  server <- function(input, output, session) {
    res_mod <- callModule(
      module = pickerGroupServer,
      id = "my-filters",
      data = mpg,
      vars = c("manufacturer", "model", "trans", "class")
    )
    output$table <- DT::renderDataTable(res_mod())
  }

  shinyApp(ui, server)

}


### Not inline example

if (interactive()) {

  library(shiny)
  library(shinyWidgets)


  data("mpg", package = "ggplot2")


  ui <- fluidPage(
    fluidRow(
      column(
        width = 4,
        tags$h3("Filter data with picker group"),
        pickerGroupUI(
          id = "my-filters",
          inline = FALSE,
          params = list(
            manufacturer = list(inputId = "manufacturer", label = "Manufacturer:"),
            model = list(inputId = "model", label = "Model:"),
            trans = list(inputId = "trans", label = "Trans:"),
            class = list(inputId = "class", label = "Class:")
          )
        )
      ),
      column(
        width = 8,
        DT::dataTableOutput(outputId = "table")
      )
    )
  )

  server <- function(input, output, session) {
    res_mod <- callModule(
      module = pickerGroupServer,
      id = "my-filters",
      data = mpg,
      vars = c("manufacturer", "model", "trans", "class")
    )
    output$table <- DT::renderDataTable(res_mod())
  }

  shinyApp(ui, server)

}
