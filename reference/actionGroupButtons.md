# Actions Buttons Group Inputs

Create a group of actions buttons.

## Usage

``` r
actionGroupButtons(
  inputIds,
  labels,
  status = "default",
  size = "normal",
  direction = "horizontal",
  fullwidth = FALSE
)
```

## Arguments

- inputIds:

  The `input`s slot that will be used to access the value, one for each
  button.

- labels:

  Labels for each buttons, must have same length as `inputIds`.

- status:

  Add a class to the buttons, you can use Bootstrap status like 'info',
  'primary', 'danger', 'warning' or 'success'. Or use an arbitrary
  strings to add a custom class, e.g. : with `status = 'myClass'`,
  buttons will have class `btn-myClass`.

- size:

  Size of the buttons ('xs', 'sm', 'normal', 'lg').

- direction:

  Horizontal or vertical.

- fullwidth:

  If TRUE, fill the width of the parent div.

## Value

An actions buttons group control that can be added to a UI definition.

## Examples

``` r
if (interactive()) {
  library("shiny")
  library("shinyWidgets")

  ui <- fluidPage(
    br(),
    actionGroupButtons(
      inputIds = c("btn1", "btn2", "btn3"),
      labels = list("Action 1", "Action 2", tags$span(icon("gear"), "Action 3")),
      status = "primary"
    ),
    verbatimTextOutput(outputId = "res1"),
    verbatimTextOutput(outputId = "res2"),
    verbatimTextOutput(outputId = "res3")
  )

  server <- function(input, output, session) {

    output$res1 <- renderPrint(input$btn1)

    output$res2 <- renderPrint(input$btn2)

    output$res3 <- renderPrint(input$btn3)

  }

  shinyApp(ui = ui, server = server)
}
```
