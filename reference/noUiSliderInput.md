# Numeric range slider

A minimal numeric range slider with a lot of features.

## Usage

``` r
noUiSliderInput(
  inputId,
  label = NULL,
  min,
  max,
  value,
  step = NULL,
  tooltips = TRUE,
  connect = TRUE,
  padding = 0,
  margin = NULL,
  limit = NULL,
  orientation = c("horizontal", "vertical"),
  direction = c("ltr", "rtl"),
  behaviour = "tap",
  range = NULL,
  pips = NULL,
  format = wNumbFormat(),
  update_on = c("end", "change"),
  color = NULL,
  inline = FALSE,
  width = NULL,
  height = NULL
)
```

## Arguments

- inputId:

  The `input` slot that will be used to access the value.

- label:

  Display label for the control, or NULL for no label.

- min:

  Minimal value that can be selected.

- max:

  Maximal value that can be selected.

- value:

  The initial value of the slider. as many cursors will be created as
  values provided.

- step:

  numeric, by default, the slider slides fluently. In order to make the
  handles jump between intervals, you can use the step option.

- tooltips:

  logical, display slider's value in a tooltip above slider.

- connect:

  logical, vector of length `value` + 1, color slider between handle(s).

- padding:

  numeric, padding limits how close to the slider edges handles can be.

- margin:

  numeric, when using two handles, the minimum distance between the
  handles can be set using the margin option.

- limit:

  numeric, the limit option is the opposite of the `margin` option,
  limiting the maximum distance between two handles.

- orientation:

  The orientation setting can be used to set the slider to `"vertical"`
  or `"horizontal"`.

- direction:

  `"ltr"` or `"rtl"`, By default the sliders are top-to-bottom and
  left-to-right, but you can change this using the direction option,
  which decides where the upper side of the slider is.

- behaviour:

  Option to handle user interaction, a value or several between
  `"drag"`, `"tap"`, `"fixed"`, `"snap"` or `"none"`. See
  <https://refreshless.com/nouislider/behaviour-option/> for more
  examples.

- range:

  list, can be used to define non-linear sliders.

- pips:

  list, used to generate points along the slider.

- format:

  numbers format, see
  [`wNumbFormat`](https://dreamrs.github.io/shinyWidgets/reference/wNumbFormat.md).

- update_on:

  When to send value to server: `"end"` (when slider is released) or
  `"change"` (each time value changes).

- color:

  color in Hex format for the slider.

- inline:

  If `TRUE`, it's possible to position sliders side-by-side.

- width:

  The width of the input, e.g. `400px`, or `100%`.

- height:

  The height of the input, e.g. `400px`, or `100%`.

## Value

a ui definition

## Note

See
[`updateNoUiSliderInput()`](https://dreamrs.github.io/shinyWidgets/reference/updateNoUiSliderInput.md)
for updating slider value server-side. And
[`demoNoUiSlider()`](https://dreamrs.github.io/shinyWidgets/reference/demoNoUiSlider.md)
for examples.

## Examples

``` r
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h2("noUiSliderInput example"),

  noUiSliderInput(
    inputId = "noui1",
    min = 0, max = 100,
    value = 20
  ),
  verbatimTextOutput(outputId = "res1"),

  tags$br(),

  noUiSliderInput(
    inputId = "noui2", label = "Slider vertical:",
    min = 0, max = 1000, step = 50,
    value = c(100, 400), margin = 100,
    orientation = "vertical",
    width = "100px", height = "300px"
  ),
  verbatimTextOutput(outputId = "res2")
)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$noui1)
  output$res2 <- renderPrint(input$noui2)

}

if (interactive())
  shinyApp(ui, server)
```
