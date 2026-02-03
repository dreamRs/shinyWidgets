# Create a numeric input control with icon(s)

Extend form controls by adding text or icons before, after, or on both
sides of a classic `numericInput`.

## Usage

``` r
numericInputIcon(
  inputId,
  label,
  value,
  min = NULL,
  max = NULL,
  step = NULL,
  icon = NULL,
  size = NULL,
  help_text = NULL,
  width = NULL
)
```

## Arguments

- inputId:

  The `input` slot that will be used to access the value.

- label:

  Display label for the control, or `NULL` for no label.

- value:

  Initial value.

- min:

  Minimum allowed value

- max:

  Maximum allowed value

- step:

  Interval to use when stepping between min and max

- icon:

  An [`shiny::icon()`](https://rdrr.io/pkg/shiny/man/icon.html) (or
  equivalent) or a `list`, containing `icon`s or text, to be displayed
  on the right or left of the text input.

- size:

  Size of the input, default to `NULL`, can be `"sm"` (small) or `"lg"`
  (large).

- help_text:

  Help text placed below the widget and only displayed if value entered
  by user is outside of `min` and `max`.

- width:

  The width of the input, e.g. `'400px'`, or `'100%'`; see
  [`validateCssUnit()`](https://rstudio.github.io/htmltools/reference/validateCssUnit.html).

## Value

A numeric input control that can be added to a UI definition.

## See also

See
[`updateNumericInputIcon()`](https://dreamrs.github.io/shinyWidgets/reference/updateNumericInputIcon.md)
to update server-side, and
[`textInputIcon()`](https://dreamrs.github.io/shinyWidgets/reference/textInputIcon.md)
for using text value.

## Examples

``` r
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  # Test with different version of Bootstrap
  # theme = bslib::bs_theme(version = 5),

  tags$h2("numericInputIcon examples"),
  fluidRow(
    column(
      width = 6,
      numericInputIcon(
        inputId = "ex1",
        label = "With an icon",
        value = 10,
        icon = icon("percent")
      ),
      verbatimTextOutput("res1"),
      numericInputIcon(
        inputId = "ex2",
        label = "With an icon (right)",
        value = 90,
        step = 10,
        icon = list(NULL, icon("percent"))
      ),
      verbatimTextOutput("res2"),
      numericInputIcon(
        inputId = "ex3",
        label = "With text",
        value = 50,
        icon = list("km/h")
      ),
      verbatimTextOutput("res3"),
      numericInputIcon(
        inputId = "ex4",
        label = "Both side",
        value = 10000,
        icon = list(icon("dollar-sign"), ".00")
      ),
      verbatimTextOutput("res4"),
      numericInputIcon(
        inputId = "ex5",
        label = "Sizing",
        value = 10000,
        icon = list(icon("dollar-sign"), ".00"),
        size = "lg"
      ),
      verbatimTextOutput("res5")
    )
  )
)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$ex1)
  output$res2 <- renderPrint(input$ex2)
  output$res3 <- renderPrint(input$ex3)
  output$res4 <- renderPrint(input$ex4)
  output$res5 <- renderPrint(input$ex5)

}


if (interactive())
  shinyApp(ui, server)
```
