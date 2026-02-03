# Knob Input

**\[deprecated\]** The JavaScript library used by this widget is no
longer actively maintained.

## Usage

``` r
knobInput(
  inputId,
  label,
  value,
  min = 0,
  max = 100,
  step = 1,
  angleOffset = 0,
  angleArc = 360,
  cursor = FALSE,
  thickness = NULL,
  lineCap = c("default", "round"),
  displayInput = TRUE,
  displayPrevious = FALSE,
  rotation = c("clockwise", "anticlockwise"),
  fgColor = NULL,
  inputColor = NULL,
  bgColor = NULL,
  pre = NULL,
  post = NULL,
  fontSize = NULL,
  readOnly = FALSE,
  skin = NULL,
  width = NULL,
  height = NULL,
  immediate = TRUE
)
```

## Arguments

- inputId:

  The `input` slot that will be used to access the value.

- label:

  Display label for the control, or NULL for no label.

- value:

  Initial value.

- min:

  Minimum allowed value, default to `0`.

- max:

  Maximum allowed value, default to `100`.

- step:

  Specifies the interval between each selectable value, default to `1`.

- angleOffset:

  Starting angle in degrees, default to `0`.

- angleArc:

  Arc size in degrees, default to `360`.

- cursor:

  Display mode "cursor", don't work properly if `width` is not set in
  pixel, (`TRUE` or `FALSE`).

- thickness:

  Gauge thickness, numeric value.

- lineCap:

  Gauge stroke endings, 'default' or 'round'.

- displayInput:

  Hide input in the middle of the knob (`TRUE` or `FALSE`).

- displayPrevious:

  Display the previous value with transparency (`TRUE` or `FALSE`).

- rotation:

  Direction of progression, 'clockwise' or 'anticlockwise'.

- fgColor:

  Foreground color.

- inputColor:

  Input value (number) color.

- bgColor:

  Background color.

- pre:

  A prefix string to put in front of the value.

- post:

  A suffix string to put after the value.

- fontSize:

  Font size, must be a valid CSS unit.

- readOnly:

  Disable knob (`TRUE` or `FALSE`).

- skin:

  Change Knob skin, only one option available : 'tron'.

- width, height:

  The width and height of the input, e.g. `400px`, or `100%`. A value a
  pixel is recommended, otherwise the knob won't be able to initialize
  itself in some case (if hidden at start for example).

- immediate:

  If `TRUE` (default), server-side value is updated each time value
  change, if `FALSE` value is updated when user release the widget.

## Value

Numeric value server-side.

## See also

[`updateKnobInput`](https://dreamrs.github.io/shinyWidgets/reference/updateKnobInput.md)
for updating the value server-side.

## Examples

``` r
if (interactive()) {

library("shiny")
library("shinyWidgets")

ui <- fluidPage(
  knobInput(
    inputId = "myKnob",
    label = "Display previous:",
    value = 50,
    min = -100,
    displayPrevious = TRUE,
    fgColor = "#428BCA",
    inputColor = "#428BCA"
  ),
  verbatimTextOutput(outputId = "res")
)

server <- function(input, output, session) {

  output$res <- renderPrint(input$myKnob)

}

shinyApp(ui = ui, server = server)

}
```
