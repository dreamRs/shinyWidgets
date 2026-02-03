# Change the value of a numeric range input

Change the value of a numeric range input

## Usage

``` r
updateNumericRangeInput(
  session = getDefaultReactiveDomain(),
  inputId,
  label = NULL,
  value = NULL
)
```

## Arguments

- session:

  The session object passed to function given to shinyServer.

- inputId:

  The `input` slot that will be used to access the value.

- label:

  Display label for the control, or `NULL` for no label.

- value:

  The initial value(s) for the range. A numeric vector of length one
  will be duplicated to represent the minimum and maximum of the range;
  a numeric vector of two or more will have its minimum and maximum set
  the minimum and maximum of the range.

## See also

[`numericRangeInput()`](https://dreamrs.github.io/shinyWidgets/reference/numericRangeInput.md)

## Examples

``` r
library(shiny)
library(shinyWidgets)

ui <- fluidPage(

  tags$br(),

  numericRangeInput(
    inputId = "my_id",
    label = "Numeric Range Input:",
    value = c(100, 400)
  ),
  verbatimTextOutput(outputId = "res1"),
  textInput("label", "Update label:"),
  numericInput("val1", "Update value 1:", 100),
  numericInput("val2", "Update value 2:", 400)

)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$my_id)

  observeEvent(input$label, {
    updateNumericRangeInput(
      session = session,
      inputId = "my_id",
      label = input$label
    )
  }, ignoreInit = TRUE)

  observe({
    updateNumericRangeInput(
      session = session,
      inputId = "my_id",
      value = c(input$val1, input$val2)
    )
  })
}

if (interactive())
  shinyApp(ui, server)
```
