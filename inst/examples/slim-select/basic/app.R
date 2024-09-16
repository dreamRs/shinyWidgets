
library(shiny)
library(shinyWidgets)
library(htmltools)

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
      width = 4,

      slimSelectInput(
        inputId = "slim1",
        label = "Single slim select:",
        choices = month.name,
        width = "100%"
      ),
      verbatimTextOutput("res1"),

      slimSelectInput(
        inputId = "slim4",
        label = "Allow deselect in single select:",
        choices = month.name,
        placeholder = "Select something:",
        allowDeselect = TRUE,
        width = "100%"
      ),
      verbatimTextOutput("res4")

    ),
    column(
      width = 4,

      slimSelectInput(
        inputId = "slim2",
        label = "Multiple slim select:",
        choices = month.name,
        multiple = TRUE,
        placeholder = "Select a month",
        width = "100%"
      ),
      verbatimTextOutput("res2"),

      slimSelectInput(
        inputId = "slim5",
        label = "Keep order:",
        choices = month.name,
        multiple = TRUE,
        keepOrder = TRUE,
        width = "100%"
      ),
      verbatimTextOutput("res5")

    ),
    column(
      width = 4,

      slimSelectInput(
        inputId = "slim3",
        label = "Use prepare_slim_choices:",
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
      verbatimTextOutput("res3"),

      slimSelectInput(
        inputId = "slim6",
        label = "Always open:",
        choices = month.name,
        multiple = TRUE,
        alwaysOpen = TRUE,
        # contentPosition = "relative",
        # contentLocation = "slim6-placeholder",
        width = "100%"
      ) |> htmltools::tagAppendAttributes(style = css(height = "350px")),
      verbatimTextOutput("res6")

    )
  )
)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$slim1)

  output$res2 <- renderPrint(input$slim2)

  output$res3 <- renderPrint(input$slim3)

  output$res4 <- renderPrint(input$slim4)

  output$res5 <- renderPrint(input$slim5)

  output$res6 <- renderPrint(input$slim6)

}

if (interactive())
  shinyApp(ui, server)
