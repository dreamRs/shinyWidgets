library(shiny)
library(shinyWidgets)


ui <- fluidPage(
  awesomeRadio(
    inputId = "radio",
    choices = c("A", "B", "C"),
    label = "My label"
  ),

  verbatimTextOutput(outputId = "res"),

  actionButton(inputId = "updatechoices", label = "Random choices"),
  textInput(inputId = "updatelabel", label = "Update label"),
  selectInput(
    inputId = "updatestatus",
    label = "Status",
    choices = c("primary", "danger", "warning", "success", "info")
  )
)

server <- function(input, output, session) {

  output$res <- renderPrint({
    input$somevalue
  })

  observeEvent(input$updatechoices, {
    updateAwesomeRadio(
      inputId = "radio",
      choices = sample(letters, sample(2:6, 1))
    )
  })

  observeEvent(input$updatelabel, {
    updateAwesomeRadio(
      inputId = "radio",
      label = input$updatelabel
    )
  }, ignoreInit = TRUE)

  # To update status you need to provide coices too
  observeEvent(input$updatestatus, {
    updateAwesomeRadio(
      inputId = "radio",
      choices = c("A", "B", "C"),
      status = input$updatestatus
    )
  }, ignoreInit = TRUE)

}

if (interactive())
  shinyApp(ui = ui, server = server)
