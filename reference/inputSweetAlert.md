# Launch an input text dialog

Launch a popup with a text input

## Usage

``` r
inputSweetAlert(
  session = getDefaultReactiveDomain(),
  inputId,
  title = NULL,
  text = NULL,
  type = NULL,
  input = c("text", "password", "textarea", "radio", "checkbox", "select", "email",
    "url"),
  inputOptions = NULL,
  inputPlaceholder = NULL,
  inputValidator = NULL,
  btn_labels = "Ok",
  btn_colors = NULL,
  reset_input = TRUE,
  ...
)
```

## Arguments

- session:

  The `session` object passed to function given to shinyServer.

- inputId:

  The `input` slot that will be used to access the value. If in a Shiny
  module, it use same logic than inputs : use namespace in UI, not in
  server.

- title:

  Title of the pop-up.

- text:

  Text of the pop-up.

- type:

  Type of the pop-up : `"info"`, `"success"`, `"warning"`, `"error"` or
  `"question"`.

- input:

  Type of input, possible values are : `"text"`,
  `"password"`,`"textarea"`, `"radio"`, `"checkbox"` or `"select"`.

- inputOptions:

  Options for the input. For `"radio"` and `"select"` it will be
  choices.

- inputPlaceholder:

  Placeholder for the input, use it for `"text"` or `"checkbox"`.

- inputValidator:

  JavaScript function to validate input. Must be a character wrapped in
  [`I()`](https://rdrr.io/r/base/AsIs.html).

- btn_labels:

  Label(s) for button(s).

- btn_colors:

  Color(s) for button(s).

- reset_input:

  Set the input value to `NULL` when alert is displayed.

- ...:

  Other arguments passed to JavaScript method.

## Note

This function use the JavaScript sweetalert2 library, see the official
documentation for more https://sweetalert2.github.io/.

## See also

[`sendSweetAlert()`](https://dreamrs.github.io/shinyWidgets/reference/sweetalert.md),
[`confirmSweetAlert()`](https://dreamrs.github.io/shinyWidgets/reference/sweetalert-confirmation.md),
[`closeSweetAlert()`](https://dreamrs.github.io/shinyWidgets/reference/closeSweetAlert.md).

## Examples

``` r
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
      title = "What's your favorite fruit ?",
      inputValidator = I(
        "function(value) {
          if (!value) {
            return 'You need to choose something!';
          }
        }"
      )
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
```
