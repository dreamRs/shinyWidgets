# Slim Select Input

An advanced select dropdown, based on
[slim-select](https://github.com/brianvoe/slim-select) JavaScript
library.

## Usage

``` r
slimSelectInput(
  inputId,
  label,
  choices,
  selected = NULL,
  multiple = FALSE,
  search = TRUE,
  placeholder = NULL,
  allowDeselect = NULL,
  closeOnSelect = !multiple,
  keepOrder = NULL,
  alwaysOpen = NULL,
  contentPosition = NULL,
  ...,
  inline = FALSE,
  width = NULL
)
```

## Arguments

- inputId:

  The `input` slot that will be used to access the value.

- label:

  Display label for the control, or `NULL` for no label.

- choices:

  List of values to select from. You can use:

  - `vector` a simple vector.

  - `named list` / `named vector` in the same way as with
    [`shiny::selectInput()`](https://rdrr.io/pkg/shiny/man/selectInput.html)

  - cuxtom choices prepared with
    [`prepare_slim_choices()`](https://dreamrs.github.io/shinyWidgets/reference/prepare_slim_choices.md).

- selected:

  The initially selected value (or multiple values if
  `multiple = TRUE`). If not specified then defaults to the first value
  for single-select lists and no values for multiple select lists.

- multiple:

  Is selection of multiple items allowed?

- search:

  Enable search feature.

- placeholder:

  Placeholder text.

- allowDeselect:

  This will allow you to deselect a value on a single/multiple select
  dropdown.

- closeOnSelect:

  A boolean value in which determines whether or not to close the
  content area upon selecting a value.

- keepOrder:

  If `TRUE` will maintain the order in which options are selected.

- alwaysOpen:

  If `TRUE` keep the select open at all times.

- contentPosition:

  Will set the css position to either relative or absolute.

- ...:

  Other settings passed to Slim Select JAvaScript method.

- inline:

  Display the widget inline.

- width:

  The width of the input, e.g. `'400px'`, or `'100%'`; see
  [`validateCssUnit()`](https://rstudio.github.io/htmltools/reference/validateCssUnit.html).

## Value

A `shiny.tag` object that can be used in a UI definition.

## Examples

``` r
library(shiny)
library(shinyWidgets)
library(htmltools)

state_data <- data.frame(
  name = state.name,
  abb = state.abb,
  region = state.region,
  division = state.division
)

ui <- fluidPage(
  tags$h2("Slim Select examples"),
  fluidRow(
    column(
      width = 4,

      slimSelectInput(
        inputId = "slim1",
        label = "Single slim select:",
        choices = month.name,
        width = "100%"
      ),
      verbatimTextOutput("res1"),

      slimSelectInput(
        inputId = "slim4",
        label = "Allow deselect in single select:",
        choices = month.name,
        placeholder = "Select something:",
        allowDeselect = TRUE,
        width = "100%"
      ),
      verbatimTextOutput("res4")

    ),
    column(
      width = 4,

      slimSelectInput(
        inputId = "slim2",
        label = "Multiple slim select:",
        choices = month.name,
        multiple = TRUE,
        placeholder = "Select a month",
        width = "100%"
      ),
      verbatimTextOutput("res2"),

      slimSelectInput(
        inputId = "slim5",
        label = "Keep order:",
        choices = month.name,
        multiple = TRUE,
        keepOrder = TRUE,
        width = "100%"
      ),
      verbatimTextOutput("res5")

    ),
    column(
      width = 4,

      htmltools::tagAppendAttributes(slimSelectInput(
        inputId = "slim6",
        label = "Always open:",
        choices = month.name,
        multiple = TRUE,
        alwaysOpen = TRUE,
        width = "100%"
      ), style = css(height = "350px")),
      verbatimTextOutput("res6"),

      slimSelectInput(
        inputId = "slim3",
        label = "Use prepare_slim_choices:",
        choices = prepare_slim_choices(
          state_data,
          label = name,
          value = abb,
          .by = region,
          selectAll = TRUE,
          closable = "close"
        ),
        multiple = TRUE,
        width = "100%"
      ),
      verbatimTextOutput("res3")

    )
  )
)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$slim1)

  output$res2 <- renderPrint(input$slim2)

  output$res3 <- renderPrint(input$slim3)

  output$res4 <- renderPrint(input$slim4)

  output$res5 <- renderPrint(input$slim5)

  output$res6 <- renderPrint(input$slim6)

}

if (interactive())
  shinyApp(ui, server)
```
