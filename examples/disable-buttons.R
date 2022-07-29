library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  theme = bslib::bs_theme(version = 5),

  checkboxGroupButtons(
    inputId = "check",
    choices = setNames(1:6, head(month.name)),
    label = "Check buttons"
  ),
  radioGroupButtons(
    inputId = "radio",
    choices = setNames(1:6, head(month.name)),
    label = "Radio buttons",
    checkIcon = list(
      yes = icon("square-check"),
      no = icon("square")
    )
  ),

  tags$b("Check"),
  verbatimTextOutput(outputId = "valCheck"),
  tags$b("Radio"),
  verbatimTextOutput(outputId = "valRadio"),

  checkboxInput(inputId = "disable", label = "Disable?", value = FALSE),
  checkboxInput(inputId = "disable1", label = "Disable march?", value = FALSE),
  checkboxInput(inputId = "disable2", label = "Disable february & april?", value = FALSE)
)

server <- function(input, output, session) {

  output$valCheck <- renderPrint({
    input$check
  })
  output$valRadio <- renderPrint({
    input$radio
  })

  observeEvent(input$disable, {
    updateCheckboxGroupButtons(
      session = session,
      inputId = "check",
      disabled = input$disable
    )
    updateRadioGroupButtons(
      session = session,
      inputId = "radio",
      disabled = input$disable
    )
  }, ignoreInit = TRUE)

  observeEvent(input$disable1, {
    updateCheckboxGroupButtons(
      session = session,
      inputId = "check",
      disabledChoices = if (input$disable1) 3 else NULL
    )
    updateRadioGroupButtons(
      session = session,
      inputId = "radio",
      disabledChoices = if (input$disable1) 3 else NULL
    )
  }, ignoreInit = TRUE)

  observeEvent(input$disable2, {
    updateCheckboxGroupButtons(
      session = session,
      inputId = "check",
      disabledChoices = if (input$disable2) c(2, 4) else NULL
    )
    updateRadioGroupButtons(
      session = session,
      inputId = "radio",
      disabledChoices = if (input$disable2) c(2, 4) else NULL
    )
  }, ignoreInit = TRUE)

}

shinyApp(ui = ui, server = server, options = list(launch.browser = TRUE))
