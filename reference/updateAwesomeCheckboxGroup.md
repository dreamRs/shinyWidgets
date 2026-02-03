# Change the value of a [`awesomeCheckboxGroup`](https://dreamrs.github.io/shinyWidgets/reference/awesomeCheckboxGroup.md) input on the client

Change the value of a
[`awesomeCheckboxGroup`](https://dreamrs.github.io/shinyWidgets/reference/awesomeCheckboxGroup.md)
input on the client

## Usage

``` r
updateAwesomeCheckboxGroup(
  session = getDefaultReactiveDomain(),
  inputId,
  label = NULL,
  choices = NULL,
  selected = NULL,
  inline = FALSE,
  status = "primary"
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

  List of values to show checkboxes for.

- selected:

  The values that should be initially selected, if any.

- inline:

  If TRUE, render the choices inline (i.e. horizontally)

- status:

  Color of the buttons.

## See also

[`awesomeCheckboxGroup`](https://dreamrs.github.io/shinyWidgets/reference/awesomeCheckboxGroup.md)

## Examples

``` r
if (interactive()) {

library("shiny")
library("shinyWidgets")


ui <- fluidPage(
  awesomeCheckboxGroup(
    inputId = "somevalue",
    choices = c("A", "B", "C"),
    label = "My label"
  ),

  verbatimTextOutput(outputId = "res"),

  actionButton(inputId = "updatechoices", label = "Random choices"),
  textInput(inputId = "updatelabel", label = "Update label")
)

server <- function(input, output, session) {

  output$res <- renderPrint({
    input$somevalue
  })

  observeEvent(input$updatechoices, {
    updateAwesomeCheckboxGroup(
      session = session, inputId = "somevalue",
      choices = sample(letters, sample(2:6))
    )
  })

  observeEvent(input$updatelabel, {
    updateAwesomeCheckboxGroup(
      session = session, inputId = "somevalue",
      label = input$updatelabel
    )
  }, ignoreInit = TRUE)

}

shinyApp(ui = ui, server = server)

}
```
