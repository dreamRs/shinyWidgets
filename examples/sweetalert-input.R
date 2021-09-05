
# Input in alert ----

library(shiny)
library(shinyWidgets)


ui <- fluidPage(
  tags$h1("Input sweet alert"),

  actionButton("btn_text", "Text Input"),
  verbatimTextOutput(outputId = "text"),

  actionButton("btn_password", "Password Input"),
  verbatimTextOutput(outputId = "password"),

  actionButton("btn_radio", "Radio Input"),
  verbatimTextOutput(outputId = "radio"),

  actionButton("btn_checkbox", "Checkbox Input"),
  verbatimTextOutput(outputId = "checkbox"),

  actionButton("btn_select", "Select Input"),
  verbatimTextOutput(outputId = "select"),

  actionButton("btn_email", "Email Input"),
  verbatimTextOutput(outputId = "email")
)
server <- function(input, output, session) {

   observeEvent(input$btn_text, {
    inputSweetAlert(
      session = session,
      "mytext",
      input = "text",
      title = "What's your name ?",
      inputPlaceholder = "e.g.: Victor",
      allowOutsideClick = FALSE,
      showCloseButton = TRUE
    )
  })
  output$text <- renderPrint(input$mytext)

   observeEvent(input$btn_password, {
    inputSweetAlert(
      session = session,
      "mypassword",
      input = "password",
      title = "What's your password ?"
    )
  })
  output$password <- renderPrint(input$mypassword)

   observeEvent(input$btn_radio, {
    inputSweetAlert(
      session = session,
      "myradio",
      input = "radio",
      inputOptions = c("Banana" , "Orange", "Apple"),
      title = "What's your favorite fruit ?"
    )
  })
  output$radio <- renderPrint(input$myradio)

   observeEvent(input$btn_checkbox, {
    inputSweetAlert(
      session = session,
      "mycheckbox",
      input = "checkbox",
      inputPlaceholder = "Yes I agree",
      title = "Do you agree ?"
    )
  })
  output$checkbox <- renderPrint(input$mycheckbox)

   observeEvent(input$btn_select, {
    inputSweetAlert(
      session = session,
      "myselect",
      input = "select",
      inputOptions = c("Banana" , "Orange", "Apple"),
      title = "What's your favorite fruit ?"
    )
  })
  output$select <- renderPrint(input$myselect)

  observeEvent(input$btn_email, {
    inputSweetAlert(
      session = session,
      inputId = "myemail",
      input = "email",
      title = "What's your email ?",
      validationMessage= "this does not look like a valid email!"
    )
  })
  output$email <- renderPrint(input$myemail)

}

if (interactive())
  shinyApp(ui = ui, server = server)
