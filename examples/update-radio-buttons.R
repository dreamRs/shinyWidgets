library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  radioGroupButtons(
    inputId = "somevalue",
    choices = c("A", "B", "C"),
    label = "My label"
  ),

  verbatimTextOutput(outputId = "res"),

  actionButton(inputId = "updatechoices", label = "Random choices"),
  pickerInput(
    inputId = "updateselected", label = "Update selected:",
    choices = c("A", "B", "C"), multiple = FALSE
  ),
  textInput(inputId = "updatelabel", label = "Update label")
)

server <- function(input, output, session) {

  output$res <- renderPrint({
    input$somevalue
  })

  observeEvent(input$updatechoices, {
    newchoices <- sample(letters, sample(3:7))
    updateRadioGroupButtons(
      session = session,
      inputId = "somevalue",
      choices = newchoices
    )
    updatePickerInput(
      session = session,
      inputId = "updateselected",
      choices = newchoices
    )
  })

  observeEvent(input$updateselected, {
    updateRadioGroupButtons(
      session = session, inputId = "somevalue",
      selected = input$updateselected
    )
  }, ignoreNULL = TRUE, ignoreInit = TRUE)

  observeEvent(input$updatelabel, {
    updateRadioGroupButtons(
      session = session, inputId = "somevalue",
      label = input$updatelabel
    )
  }, ignoreInit = TRUE)

}

if (interactive())
  shinyApp(ui = ui, server = server)
