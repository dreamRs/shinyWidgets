# Update an Autonumeric Input Object

Update an Autonumeric Input Object

## Usage

``` r
updateAutonumericInput(
  session = getDefaultReactiveDomain(),
  inputId,
  label = NULL,
  value = NULL,
  options = NULL
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

- options:

  List of additional parameters to update, use `autonumericInput`'s
  arguments.

## See also

Other autonumeric:
[`autonumericInput()`](https://dreamrs.github.io/shinyWidgets/reference/autonumericInput.md),
[`currencyInput()`](https://dreamrs.github.io/shinyWidgets/reference/formatNumericInput.md),
[`updateCurrencyInput()`](https://dreamrs.github.io/shinyWidgets/reference/formaNumericInputUpdate.md)

## Examples

``` r
if (interactive()) {
  library(shiny)
  library(shinyWidgets)

  ui <- fluidPage(
    h1("AutonumericInput Update Example"),
    br(),
    autonumericInput(
      inputId = "id1",
      label = "Autonumeric Input",
      value = 1234.56,
      align = "center",
      currencySymbol = "$ ",
      currencySymbolPlacement = "p",
      decimalCharacter = ".",
      digitGroupSeparator = ","
    ),
    verbatimTextOutput("res1"),
    actionButton("bttn1", "Change Input to Euros"),
    actionButton("bttn2", "Change Input to Dollars"),
    br(),
    br(),
    sliderInput("decimals", "Select Number of Decimal Places",
                value = 2, step = 1, min = 0, max = 6),
    actionButton("bttn3", "Update Number of Decimal Places")
  )

  server <- function(input, output, session) {
    output$res1 <- renderPrint(input$id1)

    observeEvent(input$bttn1, {
      updateAutonumericInput(
        session = session,
        inputId = "id1",
        label = "Euros:",
        value = 6543.21,
        options = list(
          currencySymbol = "\u20ac",
          currencySymbolPlacement = "s",
          decimalCharacter = ",",
          digitGroupSeparator = "."
        )
      )
    })
    observeEvent(input$bttn2, {
      updateAutonumericInput(
        session = session,
        inputId = "id1",
        label = "Dollars:",
        value = 6543.21,
        options = list(
          currencySymbol = "$",
          currencySymbolPlacement = "p",
          decimalCharacter = ".",
          digitGroupSeparator = ","
        )
      )
    })
    observeEvent(input$bttn3, {
      updateAutonumericInput(
        session = session,
        inputId = "id1",
        options = list(
          decimalPlaces = input$decimals
        )
      )
    })
  }

  shinyApp(ui, server)
}
```
