
# Select variables --------------------------------------------------------

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
          checkboxGroupInput(
            inputId = "vars",
            label = "Variables to use:",
            choices = c("manufacturer", "model", "trans", "class"),
            selected = c("manufacturer", "model", "trans", "class"),
            inline = TRUE
          ),
          selectizeGroupUI(
            id = "my-filters",
            params = list(
              manufacturer = list(inputId = "manufacturer", title = "Manufacturer:"),
              model = list(inputId = "model", title = "Model:"),
              trans = list(inputId = "trans", title = "Trans:"),
              class = list(inputId = "class", title = "Class:")
            )
          ),
          status = "primary"
        ),
        DT::dataTableOutput(outputId = "table")
      )
    )
  )

  server <- function(input, output, session) {

    vars_r <- reactive({
      input$vars
    })

    res_mod <- callModule(
      module = selectizeGroupServer,
      id = "my-filters",
      data = mpg,
      vars = vars_r
    )

    output$table <- DT::renderDataTable({
      req(res_mod())
      res_mod()
    })
  }

  shinyApp(ui, server)
}
