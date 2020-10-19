
# Input in alert ----

library(shiny)
library(shinyWidgets)


ui <- fluidPage(
  tags$h1("Input sweet alert"),
  actionButton(inputId = "text", label = "Text Input"),
  verbatimTextOutput(outputId = "text"),
  actionButton(inputId = "password", label = "Password Input"),
  verbatimTextOutput(outputId = "password"),
  actionButton(inputId = "radio", label = "Radio Input"),
  verbatimTextOutput(outputId = "radio"),
  actionButton(inputId = "checkbox", label = "Checkbox Input"),
  verbatimTextOutput(outputId = "checkbox"),
  actionButton(inputId = "select", label = "Select Input"),
  verbatimTextOutput(outputId = "select")
)
server <- function(input, output, session) {

  observeEvent(input$text, {
    inputSweetAlert(
      session = session,
      inputId = "mytext",
      input = "text",
      title = "What's your name ?",
      inputPlaceholder = "e.g.: Victor",
      allowOutsideClick = FALSE,
      showCloseButton = TRUE
    )
  })
  output$text <- renderPrint(input$mytext)

  observeEvent(input$password, {
    inputSweetAlert(
      session = session,
      inputId = "mypassword",
      input = "password",
      title = "What's your password ?"
    )
  })
  output$password <- renderPrint(input$mypassword)

  observeEvent(input$radio, {
    inputSweetAlert(
      session = session,
      inputId = "myradio",
      input = "radio",
      inputOptions = c("Banana" , "Orange", "Apple"),
      title = "What's your favorite fruit ?"
    )
  })
  output$radio <- renderPrint(input$myradio)

  observeEvent(input$checkbox, {
    inputSweetAlert(
      session = session,
      inputId = "mycheckbox",
      input = "checkbox",
      inputPlaceholder = "Yes I agree",
      title = "Do you agree ?"
    )
  })
  output$checkbox <- renderPrint(input$mycheckbox)

  observeEvent(input$select, {
    inputSweetAlert(
      session = session,
      inputId = "myselect",
      input = "select",
      inputOptions = c("Banana" , "Orange", "Apple"),
      title = "What's your favorite fruit ?"
    )
  })
  output$select <- renderPrint(input$myselect)

}

shinyApp(ui = ui, server = server)
