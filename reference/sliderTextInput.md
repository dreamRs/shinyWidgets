# Slider Text Input Widget

Constructs a slider widget with characters instead of numeric values.

## Usage

``` r
sliderTextInput(
  inputId,
  label,
  choices,
  selected = NULL,
  animate = FALSE,
  grid = FALSE,
  hide_min_max = FALSE,
  from_fixed = FALSE,
  to_fixed = FALSE,
  from_min = NULL,
  from_max = NULL,
  to_min = NULL,
  to_max = NULL,
  force_edges = FALSE,
  width = NULL,
  pre = NULL,
  post = NULL,
  dragRange = TRUE
)
```

## Arguments

- inputId:

  The `input` slot that will be used to access the value.

- label:

  Display label for the control, or `NULL` for no label.

- choices:

  Character vector to select a value from.

- selected:

  The initially selected value, if length \> 1, create a range slider.

- animate:

  TRUE to show simple animation controls with default settings, for more
  details see
  [`sliderInput`](https://rdrr.io/pkg/shiny/man/sliderInput.html).

- grid:

  Logical, show or hide ticks marks.

- hide_min_max:

  Hides min and max labels.

- from_fixed:

  Fix position of left (or single) handle.

- to_fixed:

  Fix position of right handle.

- from_min:

  Set minimum limit for left handle.

- from_max:

  Set the maximum limit for left handle.

- to_min:

  Set minimum limit for right handle.

- to_max:

  Set the maximum limit for right handle.

- force_edges:

  Slider will be always inside it's container.

- width:

  The width of the input, e.g. `400px`, or `100%`.

- pre:

  A prefix string to put in front of the value.

- post:

  A suffix string to put after the value.

- dragRange:

  See the same argument in
  [`sliderInput`](https://rdrr.io/pkg/shiny/man/sliderInput.html).

## Value

The value retrieved server-side is a character vector.

## See also

[updateSliderTextInput](https://dreamrs.github.io/shinyWidgets/reference/updateSliderTextInput.md)
to update value server-side.

## Examples

``` r
if (interactive()) {

library("shiny")
library("shinyWidgets")

ui <- fluidPage(
  br(),
  sliderTextInput(
    inputId = "mySliderText",
    label = "Month range slider:",
    choices = month.name,
    selected = month.name[c(4, 7)]
  ),
  verbatimTextOutput(outputId = "result")
)

server <- function(input, output, session) {
  output$result <- renderPrint(str(input$mySliderText))
}

shinyApp(ui = ui, server = server)

}
```
