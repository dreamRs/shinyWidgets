
# Subset data -------------------------------------------------------------

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
          pickerInput(
            inputId = "car_select",
            choices = unique(mpg$manufacturer),
            options = list(
              `live-search` = TRUE,
              title = "None selected"
            )
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

    mpg_filter <- reactive({
      subset(mpg, manufacturer %in% input$car_select)
    })

    res_mod <- callModule(
      module = selectizeGroupServer,
      id = "my-filters",
      data = mpg_filter,
      vars = c("manufacturer", "model", "trans", "class")
    )

    output$table <- DT::renderDataTable({
      req(res_mod())
      res_mod()
    })
  }

  shinyApp(ui, server)
}
