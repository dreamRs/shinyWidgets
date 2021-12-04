library("shiny")
library("shinyWidgets")

ui <- fluidPage(
  checkboxGroupButtons(
    inputId = "somevalue",
    choices = c("A", "B", "C"),
    label = "My label"
  ),

  verbatimTextOutput(outputId = "res"),

  actionButton(inputId = "updatechoices", label = "Random choices"),
  pickerInput(
    inputId = "updateselected",
    label = "Update selected:",
    choices = c("A", "B", "C"),
    multiple = TRUE
  ),
  actionButton(inputId = "clear", label = "Clear selected"),
  textInput(inputId = "updatelabel", label = "Update label")
)

server <- function(input, output, session) {

  output$res <- renderPrint({
    input$somevalue
  })

  observeEvent(input$updatechoices, {
    newchoices <- sample(letters, sample(2:6))
    updateCheckboxGroupButtons(
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
    updateCheckboxGroupButtons(
      session = session,
      inputId = "somevalue",
      selected = input$updateselected
    )
  }, ignoreNULL = TRUE, ignoreInit = TRUE)

  observeEvent(input$clear, {
    updateCheckboxGroupButtons(
      session = session,
      inputId = "somevalue",
      selected = character(0)
    )
  })

  observeEvent(input$updatelabel, {
    updateCheckboxGroupButtons(
      session = session,
      inputId = "somevalue",
      label = input$updatelabel
    )
  }, ignoreInit = TRUE)

}

if (interactive())
  shinyApp(ui = ui, server = server)
