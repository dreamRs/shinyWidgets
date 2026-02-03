# Awesome Checkbox Group Input Control

Create a Font Awesome Bootstrap checkbox that can be used to specify
logical values.

## Usage

``` r
awesomeCheckboxGroup(
  inputId,
  label,
  choices,
  selected = NULL,
  inline = FALSE,
  status = "primary",
  width = NULL
)
```

## Arguments

- inputId:

  The `input` slot that will be used to access the value.

- label:

  Input label.

- choices:

  List of values to show checkboxes for.

- selected:

  The values that should be initially selected, if any.

- inline:

  If TRUE, render the choices inline (i.e. horizontally)

- status:

  Color of the buttons

- width:

  The width of the input

## Value

A checkbox control that can be added to a UI definition.

## See also

[`updateAwesomeCheckboxGroup`](https://dreamrs.github.io/shinyWidgets/reference/updateAwesomeCheckboxGroup.md)

## Examples

``` r
if (interactive()) {


ui <- fluidPage(
  br(),
  awesomeCheckboxGroup(
    inputId = "id1", label = "Make a choice:",
    choices = c("graphics", "ggplot2")
  ),
  verbatimTextOutput(outputId = "res1"),
  br(),
  awesomeCheckboxGroup(
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
