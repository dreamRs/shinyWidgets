# Change the value of a radio input on the client

Change the value of a radio input on the client

## Usage

``` r
updateAwesomeRadio(
  session = getDefaultReactiveDomain(),
  inputId,
  label = NULL,
  choices = NULL,
  selected = NULL,
  inline = FALSE,
  status = "primary",
  checkbox = FALSE
)
```

## Arguments

- session:

  The session object passed to function given to shinyServer.

- inputId:

  The id of the input object.

- label:

  Input label.

- choices:

  List of values to select from (if elements of the list are named then
  that name rather than the value is displayed to the user)

- selected:

  The initially selected value.

- inline:

  If TRUE, render the choices inline (i.e. horizontally)

- status:

  Color of the buttons, to update status you need to provide `choices`.

- checkbox:

  Checkbox style

## See also

[`awesomeRadio()`](https://dreamrs.github.io/shinyWidgets/reference/awesomeRadio.md)

## Examples

``` r
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
```
