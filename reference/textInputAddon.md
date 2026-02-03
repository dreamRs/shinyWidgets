# Text with Add-on Input Control

Create text field with add-on.

## Usage

``` r
textInputAddon(
  inputId,
  label,
  value = "",
  placeholder = NULL,
  addon,
  width = NULL
)
```

## Arguments

- inputId:

  The `input` slot that will be used to access the value.

- label:

  Display label for the control, or `NULL` for no label.

- value:

  Initial value..

- placeholder:

  A character string giving the user a hint as to what can be entered
  into the control.

- addon:

  An icon tag, created by
  [`shiny::icon()`](https://rdrr.io/pkg/shiny/man/icon.html).

- width:

  The width of the input : 'auto', 'fit', '100px', '75%'.

## Value

A switch control that can be added to a UI definition.

## Examples

``` r
## Only run examples in interactive R sessions
if (interactive()) {
shinyApp(
  ui = fluidPage(
    textInputAddon(inputId = "id", label = "Label", placeholder = "Username", addon = icon("at")),
    verbatimTextOutput(outputId = "out")
  ),
  server = function(input, output) {
    output$out <- renderPrint({
      input$id
    })
  }
)
}
```
