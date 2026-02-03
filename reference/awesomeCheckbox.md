# Awesome Checkbox Input Control

Create a Font Awesome Bootstrap checkbox that can be used to specify
logical values.

## Usage

``` r
awesomeCheckbox(
  inputId,
  label,
  value = FALSE,
  status = "primary",
  width = NULL
)
```

## Arguments

- inputId:

  The `input` slot that will be used to access the value.

- label:

  Input label.

- value:

  Initial value (TRUE or FALSE).

- status:

  Color of the buttons, a valid Bootstrap status : default, primary,
  info, success, warning, danger.

- width:

  The width of the input

## Value

A checkbox control that can be added to a UI definition.

## See also

[`updateAwesomeCheckbox`](https://dreamrs.github.io/shinyWidgets/reference/updateAwesomeCheckbox.md)

## Examples

``` r
## Only run examples in interactive R sessions
if (interactive()) {

ui <- fluidPage(
 awesomeCheckbox(inputId = "somevalue",
                 label = "A single checkbox",
                 value = TRUE,
                 status = "danger"),
 verbatimTextOutput("value")
)
server <- function(input, output) {
  output$value <- renderText({ input$somevalue })
}
shinyApp(ui, server)
}
```
