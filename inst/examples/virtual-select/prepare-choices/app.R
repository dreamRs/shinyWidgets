library(shiny)
library(shinyWidgets)

state_data <- data.frame(
  name = state.name,
  abb = state.abb,
  region = state.region,
  division = state.division
)

ui <- fluidPage(
  tags$h2("Virtual Select: prepare choices"),

  virtualSelectInput(
    inputId = "sel1",
    label = "Use a data.frame:",
    choices = prepare_choices(state_data, name, abb),
    search = TRUE
  ),
  verbatimTextOutput("res1"),

  virtualSelectInput(
    inputId = "sel2",
    label = "Group choices:",
    choices = prepare_choices(state_data, name, abb, region),
    multiple = TRUE
  ),
  verbatimTextOutput("res2"),

  virtualSelectInput(
    inputId = "sel3",
    label = "Add a description:",
    choices = prepare_choices(state_data, name, abb, description = division),
    multiple = TRUE,
    hasOptionDescription = TRUE
  ),
  verbatimTextOutput("res3")
)

server <- function(input, output, session) {
  output$res1 <- renderPrint(input$sel1)
  output$res2 <- renderPrint(input$sel2)
  output$res3 <- renderPrint(input$sel3)
}

if (interactive())
  shinyApp(ui, server)

