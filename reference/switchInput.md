# Bootstrap Switch Input Control

**\[deprecated\]** The JavaScript library used by this widget is no
longer actively maintained.

## Usage

``` r
switchInput(
  inputId,
  label = NULL,
  value = FALSE,
  onLabel = "ON",
  offLabel = "OFF",
  onStatus = NULL,
  offStatus = NULL,
  size = "default",
  labelWidth = "auto",
  handleWidth = "auto",
  disabled = FALSE,
  inline = FALSE,
  width = NULL
)
```

## Arguments

- inputId:

  The `input` slot that will be used to access the value.

- label:

  Display a text in the center of the switch.

- value:

  Initial value (TRUE or FALSE).

- onLabel:

  Text on the left side of the switch (TRUE).

- offLabel:

  Text on the right side of the switch (FALSE).

- onStatus:

  Color (bootstrap status) of the left side of the switch (TRUE).

- offStatus:

  Color (bootstrap status) of the right side of the switch (FALSE).

- size:

  Size of the buttons ('default', 'mini', 'small', 'normal', 'large').

- labelWidth:

  Width of the center handle in pixels.

- handleWidth:

  Width of the left and right sides in pixels.

- disabled:

  Logical, display the toggle switch in disabled state?.

- inline:

  Logical, display the toggle switch inline?

- width:

  The width of the input : 'auto', '100px', '75%'.

## Value

A switch control that can be added to a UI definition.

## Note

For more information, see the project on Github
<https://github.com/Bttstrp/bootstrap-switch>.

## See also

[`updateSwitchInput()`](https://dreamrs.github.io/shinyWidgets/reference/updateSwitchInput.md),
[`materialSwitch()`](https://dreamrs.github.io/shinyWidgets/reference/materialSwitch.md),
[`prettySwitch()`](https://dreamrs.github.io/shinyWidgets/reference/prettySwitch.md)

## Examples

``` r
## Only run examples in interactive R sessions
if (interactive()) {

# Examples in the gallery :
shinyWidgets::shinyWidgetsGallery()

# Basic usage :
ui <- fluidPage(
  switchInput(inputId = "somevalue"),
  verbatimTextOutput("value")
)
server <- function(input, output) {
  output$value <- renderPrint({ input$somevalue })
}
shinyApp(ui, server)
}
```
