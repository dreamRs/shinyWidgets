# Format numbers in noUiSliderInput

Format numbers in noUiSliderInput

## Usage

``` r
wNumbFormat(
  decimals = NULL,
  mark = NULL,
  thousand = NULL,
  prefix = NULL,
  suffix = NULL,
  negative = NULL
)
```

## Arguments

- decimals:

  The number of decimals to include in the result. Limited to 7.

- mark:

  The decimal separator. Defaults to `'.'` if thousand isn't already set
  to `'.'`.

- thousand:

  Separator for large numbers. For example: `' '` would result in a
  formatted number of 1 000 000.

- prefix:

  A string to prepend to the number. Use cases include prefixing with
  money symbols such as `'$'` or the euro sign.

- suffix:

  A number to append to a number. For example: `',-'`.

- negative:

  The prefix for negative values. Defaults to `'-'`.

## Value

a named list.

## Note

Performed via wNumb JavaScript library :
<https://refreshless.com/wnumb/>.

## Examples

``` r
if (interactive()) {

library( shiny )
library( shinyWidgets )

ui <- fluidPage(
  tags$h3("Format numbers"),
  tags$br(),

  noUiSliderInput(
    inputId = "form1",
    min = 0, max = 10000,
    value = 800,
    format = wNumbFormat(decimals = 3,
                         thousand = ".",
                         suffix = " (US $)")
  ),
  verbatimTextOutput(outputId = "res1"),

  tags$br(),

  noUiSliderInput(
    inputId = "form2",
    min = 1988, max = 2018,
    value = 1988,
    format = wNumbFormat(decimals = 0,
                         thousand = "",
                         prefix = "Year: ")
  ),
  verbatimTextOutput(outputId = "res2"),

  tags$br()

)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$form1)
  output$res2 <- renderPrint(input$form2)

}

shinyApp(ui, server)

}
```
