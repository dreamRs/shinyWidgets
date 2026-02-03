# Update a Formatted Numeric Input Widget

Update a Formatted Numeric Input Widget

## Usage

``` r
updateCurrencyInput(
  session = getDefaultReactiveDomain(),
  inputId,
  label = NULL,
  value = NULL,
  format = NULL
)

updateFormatNumericInput(
  session = getDefaultReactiveDomain(),
  inputId,
  label = NULL,
  value = NULL,
  format = NULL
)
```

## Arguments

- session:

  Standard shiny `session`.

- inputId:

  The id of the input object.

- label:

  The label to set for the input object.

- value:

  The value to set for the input object.

- format:

  The format to change the input object to.

## See also

Other autonumeric:
[`autonumericInput()`](https://dreamrs.github.io/shinyWidgets/reference/autonumericInput.md),
[`currencyInput()`](https://dreamrs.github.io/shinyWidgets/reference/formatNumericInput.md),
[`updateAutonumericInput()`](https://dreamrs.github.io/shinyWidgets/reference/updateAutonumericInput.md)

## Examples

``` r
if (interactive()) {
  library(shiny)
  library(shinyWidgets)

  ui <- fluidPage(
    tags$h2("Currency Input"),

    currencyInput("id1", "Euro:", value = 1234, format = "euro", width = 200, align = "right"),
    verbatimTextOutput("res1"),
    actionButton("bttn0", "Change Input to Euros"),
    actionButton("bttn1", "Change Input to Dollars"),
    actionButton("bttn2", "Change Input to Yen")
  )

  server <- function(input, output, session) {

    output$res1 <- renderPrint(input$id1)

    observeEvent(input$bttn0, {
      updateCurrencyInput(
        session = session,
        inputId = "id1",
        label = "Euro:",
        format = "euro"
      )
    })
    observeEvent(input$bttn1, {
      updateCurrencyInput(
        session = session,
        inputId = "id1",
        label = "Dollar:",
        format = "dollar"
      )
    })
    observeEvent(input$bttn2, {
      updateCurrencyInput(
        session = session,
        inputId = "id1",
        label = "Yen:",
        format = "Japanese"
      )
    })


  }

  shinyApp(ui, server)
}
```
