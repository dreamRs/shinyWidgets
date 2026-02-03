# Awesome Radio Buttons Input Control

Create a set of prettier radio buttons used to select an item from a
list.

## Usage

``` r
awesomeRadio(
  inputId,
  label,
  choices,
  selected = NULL,
  inline = FALSE,
  status = "primary",
  checkbox = FALSE,
  width = NULL
)
```

## Arguments

- inputId:

  The `input` slot that will be used to access the value.

- label:

  Display label for the control, or `NULL` for no label.

- choices:

  List of values to select from (if elements of the list are named then
  that name rather than the value is displayed to the user)

- selected:

  The initially selected value (if not specified then defaults to the
  first value).

- inline:

  If `TRUE`, render the choices inline (i.e. horizontally).

- status:

  Color of the buttons, a valid Bootstrap status : default, primary,
  info, success, warning, danger.

- checkbox:

  Logical, render radio like checkboxes (with a square shape).

- width:

  The width of the input, e.g. `400px`, or `100%`.

## Value

A set of radio buttons that can be added to a UI definition.

## See also

[`updateAwesomeRadio`](https://dreamrs.github.io/shinyWidgets/reference/updateAwesomeRadio.md)

## Examples

``` r
## Only run examples in interactive R sessions
if (interactive()) {

ui <- fluidPage(
  br(),
  awesomeRadio(
    inputId = "id1", label = "Make a choice:",
    choices = c("graphics", "ggplot2")
  ),
  verbatimTextOutput(outputId = "res1"),
  br(),
  awesomeRadio(
    inputId = "id2", label = "Make a choice:",
    choices = c("base", "dplyr", "data.table"),
    inline = TRUE, status = "danger"
  ),
  verbatimTextOutput(outputId = "res2")
)

server <- function(input, output, session) {

  output$res1 <- renderPrint({
    input$id1
  })

  output$res2 <- renderPrint({
    input$id2
  })

}

shinyApp(ui = ui, server = server)

}
```
