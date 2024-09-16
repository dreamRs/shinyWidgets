
library(shiny)
library(shinyWidgets)

state_data <- data.frame(
  name = state.name,
  abb = state.abb,
  region = state.region,
  division = state.division
)

ui <- fluidPage(
  tags$h2("Slim Select examples"),
  fluidRow(
    column(
      width = 3,
      slimSelectInput(
        inputId = "slim1",
        label = "Disable some choices:",
        choices = prepare_slim_choices(
          state_data,
          label = name,
          value = abb,
          disabled = division == "Mountain"
        ),
        width = "100%"
      ),
      verbatimTextOutput("res1")
    ),
    column(
      width = 3,
      slimSelectInput(
        inputId = "slim2",
        label = "Custom styles:",
        choices = prepare_slim_choices(
          state_data,
          label = name,
          value = abb,
          style = ifelse(
            division == "Mountain",
            "color: blue;",
            "color: red;"
          )
        ),
        multiple = TRUE,
        placeholder = "Select a state",
        width = "100%"
      ),
      verbatimTextOutput("res2")
    ),
    column(
      width = 3,
      slimSelectInput(
        inputId = "slim3",
        label = "Options groups with options:",
        choices = prepare_slim_choices(
          state_data,
          label = name,
          value = abb,
          .by = region,
          selectAll = TRUE,
          closable = "close"
        ),
        multiple = TRUE,
        width = "100%"
      ),
      verbatimTextOutput("res3")
    )
  )
)

server <- function(input, output, session) {
  output$res1 <- renderPrint(input$slim1)

  output$res2 <- renderPrint(input$slim2)

  output$res3 <- renderPrint(input$slim3)
}

if (interactive())
  shinyApp(ui, server)
