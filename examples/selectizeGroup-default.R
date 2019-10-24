# Default -----------------------------------------------------------------

if (interactive()) {

  library(shiny)
  library(shinyWidgets)

  data("mpg", package = "ggplot2")

  ui <- fluidPage(
    fluidRow(
      column(
        width = 10, offset = 1,
        tags$h3("Filter data with selectize group"),
        panel(
          selectizeGroupUI(
            id = "my-filters",
            params = list(
              manufacturer = list(inputId = "manufacturer", title = "Manufacturer:"),
              model = list(inputId = "model", title = "Model:"),
              trans = list(inputId = "trans", title = "Trans:"),
              class = list(inputId = "class", title = "Class:")
            )
          ), status = "primary"
        ),
        DT::dataTableOutput(outputId = "table")
      )
    )
  )

  server <- function(input, output, session) {
    res_mod <- callModule(
      module = selectizeGroupServer,
      id = "my-filters",
      data = mpg,
      vars = c("manufacturer", "model", "trans", "class")
    )
    output$table <- DT::renderDataTable(res_mod())
  }

  shinyApp(ui, server)

}
