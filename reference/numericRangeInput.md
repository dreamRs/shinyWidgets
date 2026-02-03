# Numeric Range Input

Create an input group of numeric inputs that function as a range input.

## Usage

``` r
numericRangeInput(
  inputId,
  label,
  value,
  width = NULL,
  separator = " to ",
  min = NA,
  max = NA,
  step = NA
)
```

## Arguments

- inputId:

  The `input` slot that will be used to access the value.

- label:

  Display label for the control, or `NULL` for no label.

- value:

  The initial value(s) for the range. A numeric vector of length one
  will be duplicated to represent the minimum and maximum of the range;
  a numeric vector of two or more will have its minimum and maximum set
  the minimum and maximum of the range.

- width:

  The width of the input, e.g. `'400px'`, or `'100%'`; see
  [`validateCssUnit()`](https://rstudio.github.io/htmltools/reference/validateCssUnit.html).

- separator:

  String to display between the start and end input boxes.

- min:

  Minimum allowed value

- max:

  Maximum allowed value

- step:

  Interval to use when stepping between min and max

## See also

[`updateNumericRangeInput()`](https://dreamrs.github.io/shinyWidgets/reference/updateNumericRangeInput.md)

## Examples

``` r
if (interactive()) {

### examples ----

# see ?demoNumericRange
demoNumericRange()


###  basic usage ----

library( shiny )
library( shinyWidgets )


ui <- fluidPage(

  tags$br(),

  numericRangeInput(
    inputId = "my_id", label = "Numeric Range Input:",
    value = c(100, 400)
  ),
  verbatimTextOutput(outputId = "res1")

)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$my_id)

}

shinyApp(ui, server)


}
```
