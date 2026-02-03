# Change the value of an awesome checkbox input on the client

Change the value of an awesome checkbox input on the client

## Usage

``` r
updateAwesomeCheckbox(session, inputId, label = NULL, value = NULL)
```

## Arguments

- session:

  standard `shiny` session

- inputId:

  The id of the input object.

- label:

  The label to set for the input object.

- value:

  The value to set for the input object.

## See also

[`awesomeCheckbox`](https://dreamrs.github.io/shinyWidgets/reference/awesomeCheckbox.md)

## Examples

``` r
if (interactive()) {

library("shiny")
library("shinyWidgets")


ui <- fluidPage(
  awesomeCheckbox(
    inputId = "somevalue",
    label = "My label",
    value = FALSE
  ),

  verbatimTextOutput(outputId = "res"),

  actionButton(inputId = "updatevalue", label = "Toggle value"),
  textInput(inputId = "updatelabel", label = "Update label")
)

server <- function(input, output, session) {

  output$res <- renderPrint({
    input$somevalue
  })

  observeEvent(input$updatevalue, {
    updateAwesomeCheckbox(
      session = session, inputId = "somevalue",
      value = as.logical(input$updatevalue %%2)
    )
  })

  observeEvent(input$updatelabel, {
    updateAwesomeCheckbox(
      session = session, inputId = "somevalue",
      label = input$updatelabel
    )
  }, ignoreInit = TRUE)

}

shinyApp(ui = ui, server = server)

}
```
