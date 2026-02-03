# Format Numeric Inputs

Shiny widgets for as-you-type formatting of currency and numeric values.
For a more modifiable version see
[`autonumericInput()`](https://dreamrs.github.io/shinyWidgets/reference/autonumericInput.md).
These two functions do the exact same thing but are named differently
for more intuitive use (currency for money, formatNumeric for percentage
or other).

## Usage

``` r
currencyInput(
  inputId,
  label,
  value,
  format = "euro",
  width = NULL,
  align = "center"
)

formatNumericInput(
  inputId,
  label,
  value,
  format = "commaDecimalCharDotSeparator",
  width = NULL,
  align = "center"
)
```

## Arguments

- inputId:

  The `input` slot that will be used to access the value.

- label:

  Display label for the control, or NULL for no label.

- value:

  Initial value (unformatted).

- format:

  A character string specifying the currency format of the input. See
  "Details" for possible values.

- width:

  The width of the input box, eg. `"200px"` or `"100%"`.

- align:

  The alignment of the text inside the input box, one of "center",
  "left", "right". Defaults to "center".

## Value

a currency input widget that can be added to the UI of a shiny app.

## Details

In regards to `format`, there are currently 41 sets of predefined
options that can be used, most of which are variations of one another.
The most common are:

- "French"

- "Spanish"

- "NorthAmerican"

- "British"

- "Swiss"

- "Japanese"

- "Chinese"

- "Brazilian"

- "Turkish"

- "euro" (same as "French")

- "dollar" (same as "NorthAmerican")

- "percentageEU2dec"

- "percentageUS2dec"

- "dotDecimalCharCommaSeparator"

- "commaDecimalCharDotSeparator"

To see the full list please visit [this
section](https://github.com/autoNumeric/autoNumeric/#predefined-common-options)
of the AutoNumeric Github Page.

## References

Bonneau, Alexandre. 2018. "AutoNumeric.js javascript Package".
<https://autonumeric.org/>.

## See also

Other autonumeric:
[`autonumericInput()`](https://dreamrs.github.io/shinyWidgets/reference/autonumericInput.md),
[`updateAutonumericInput()`](https://dreamrs.github.io/shinyWidgets/reference/updateAutonumericInput.md),
[`updateCurrencyInput()`](https://dreamrs.github.io/shinyWidgets/reference/formaNumericInputUpdate.md)

## Examples

``` r
if (interactive()) {
  library(shiny)
  library(shinyWidgets)

  ui <- fluidPage(
    tags$h2("Currency Input"),

    currencyInput("id1", "Euro:", value = 1234, format = "euro", width = 200, align = "right"),
    verbatimTextOutput("res1"),

    currencyInput("id2", "Dollar:", value = 1234, format = "dollar", width = 200, align = "right"),
    verbatimTextOutput("res2"),

    currencyInput("id3", "Yen:", value = 1234, format = "Japanese", width = 200, align = "right"),
    verbatimTextOutput("res3"),

    br(),
    tags$h2("Formatted Numeric Input"),

    formatNumericInput("id4", "Numeric:", value = 1234, width = 200),
    verbatimTextOutput("res4"),

    formatNumericInput("id5", "Percent:", value = 1234, width = 200, format = "percentageEU2dec"),
    verbatimTextOutput("res5")
  )

  server <- function(input, output, session) {
    output$res1 <- renderPrint(input$id1)
    output$res2 <- renderPrint(input$id2)
    output$res3 <- renderPrint(input$id3)
    output$res4 <- renderPrint(input$id4)
    output$res5 <- renderPrint(input$id5)
  }

  shinyApp(ui, server)
}
```
