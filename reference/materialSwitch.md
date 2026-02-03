# Material Design Switch Input Control

A toggle switch to turn a selection on or off.

## Usage

``` r
materialSwitch(
  inputId,
  label = NULL,
  value = FALSE,
  status = "default",
  right = FALSE,
  inline = FALSE,
  width = NULL
)
```

## Arguments

- inputId:

  The `input` slot that will be used to access the value.

- label:

  Input label.

- value:

  TRUE or FALSE.

- status:

  Color, must be a valid Bootstrap status : default, primary, info,
  success, warning, danger.

- right:

  Should the the label be on the right? default to FALSE.

- inline:

  Display the input inline, if you want to place buttons next to each
  other.

- width:

  The width of the input, e.g. `400px`, or `100%`.

## Value

A switch control that can be added to a UI definition.

## See also

[`updateMaterialSwitch`](https://dreamrs.github.io/shinyWidgets/reference/updateMaterialSwitch.md),
[`switchInput`](https://dreamrs.github.io/shinyWidgets/reference/switchInput.md)

## Examples

``` r
if (interactive()) {
  library(shiny)
  library(shinyWidgets)

  ui <- fluidPage(
    tags$h3("Material switch examples"),

    materialSwitch(inputId = "switch1", label = "Night mode"),
    verbatimTextOutput("value1"),

    materialSwitch(inputId = "switch2", label = "Night mode", status = "danger"),
    verbatimTextOutput("value2")
  )
  server <- function(input, output) {

    output$value1 <- renderText({ input$switch1 })

    output$value2 <- renderText({ input$switch2 })

  }
  shinyApp(ui, server)
}
```
