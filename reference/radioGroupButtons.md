# Buttons Group Radio Input Control

Create buttons grouped that act like radio buttons.

## Usage

``` r
radioGroupButtons(
  inputId,
  label = NULL,
  choices = NULL,
  selected = NULL,
  status = "default",
  size = "normal",
  direction = "horizontal",
  justified = FALSE,
  individual = FALSE,
  checkIcon = list(),
  width = NULL,
  choiceNames = NULL,
  choiceValues = NULL,
  disabled = FALSE
)
```

## Arguments

- inputId:

  The `input` slot that will be used to access the value.

- label:

  Display label for the control, or `NULL` for no label.

- choices:

  List of values to select from (if elements of the list are named then
  that name rather than the value is displayed to the user). If this
  argument is provided, then `choiceNames` and `choiceValues` must not
  be provided, and vice-versa. The values should be strings; other types
  (such as logicals and numbers) will be coerced to strings.

- selected:

  The initially selected value. If not specified, then it defaults to
  the first item in `choices`. To start with no items selected, use
  `character(0)`.

- status:

  Add a class to the buttons, you can use Bootstrap status like 'info',
  'primary', 'danger', 'warning' or 'success'. Or use an arbitrary
  strings to add a custom class, e.g. : with `status = "custom-class"`,
  buttons will have class `btn-custom-class`.

- size:

  Size of the buttons ('xs', 'sm', 'normal', 'lg')

- direction:

  Horizontal or vertical

- justified:

  If TRUE, fill the width of the parent div

- individual:

  If TRUE, buttons are separated.

- checkIcon:

  A list, if no empty must contain at least one element named 'yes'
  corresponding to an icon to display if the button is checked.

- width:

  The width of the input, e.g. `'400px'`, or `'100%'`; see
  [`validateCssUnit()`](https://rstudio.github.io/htmltools/reference/validateCssUnit.html).

- choiceNames, choiceValues:

  List of names and values, respectively, that are displayed to the user
  in the app and correspond to the each choice (for this reason,
  `choiceNames` and `choiceValues` must have the same length). If either
  of these arguments is provided, then the other *must* be provided and
  `choices` *must not* be provided. The advantage of using both of these
  over a named list for `choices` is that `choiceNames` allows any type
  of UI object to be passed through (tag objects, icons, HTML code,
  ...), instead of just simple text. See Examples.

- disabled:

  Initialize buttons in a disabled state (users won't be able to select
  a value).

## Value

A buttons group control that can be added to a UI definition.

## See also

[`updateRadioGroupButtons()`](https://dreamrs.github.io/shinyWidgets/reference/updateRadioGroupButtons.md)

## Examples

``` r
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h1("radioGroupButtons examples"),

  radioGroupButtons(
    inputId = "somevalue1",
    label = "Choose a value: ",
    choices = c("A", "B", "C")
  ),
  verbatimTextOutput("value1"),

  radioGroupButtons(
    inputId = "somevalue2",
    label = "With custom status:",
    choices = names(iris),
    status = "primary"
  ),
  verbatimTextOutput("value2"),

  radioGroupButtons(
    inputId = "somevalue3",
    label = "With icons:",
    choices = names(mtcars),
    checkIcon = list(
      yes = icon("square-check"),
      no = icon("square")
    )
  ),
  verbatimTextOutput("value3")
)

server <- function(input, output) {

  output$value1 <- renderPrint({ input$somevalue1 })
  output$value2 <- renderPrint({ input$somevalue2 })
  output$value3 <- renderPrint({ input$somevalue3 })

}

if (interactive())
  shinyApp(ui, server)
```
