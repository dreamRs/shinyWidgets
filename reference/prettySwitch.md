# Pretty Switch Input

A toggle switch to replace checkbox

## Usage

``` r
prettySwitch(
  inputId,
  label,
  value = FALSE,
  status = "default",
  slim = FALSE,
  fill = FALSE,
  bigger = FALSE,
  inline = FALSE,
  width = NULL
)
```

## Arguments

- inputId:

  The `input` slot that will be used to access the value.

- label:

  Display label for the control, or `NULL` for no label.

- value:

  Initial value (`TRUE` or `FALSE`).

- status:

  Add a class to the switch, you can use Bootstrap status like 'info',
  'primary', 'danger', 'warning' or 'success'.

- slim:

  Change the style of the switch (`TRUE` or `FALSE`), see examples.

- fill:

  Change the style of the switch (`TRUE` or `FALSE`), see examples.

- bigger:

  Scale the switch a bit bigger (`TRUE` or `FALSE`).

- inline:

  Display the input inline, if you want to place switch next to each
  other.

- width:

  The width of the input, e.g. `400px`, or `100%`.

## Value

`TRUE` or `FALSE` server-side.

## Note

Appearance is better in a browser such as Chrome than in RStudio Viewer

## See also

See
[`updatePrettySwitch`](https://dreamrs.github.io/shinyWidgets/reference/updatePrettySwitch.md)
to update the value server-side.

## Examples

``` r
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h1("Pretty switches"),
  br(),

  fluidRow(
    column(
      width = 4,
      prettySwitch(inputId = "switch1", label = "Default:"),
      verbatimTextOutput(outputId = "res1"),
      br(),
      prettySwitch(
        inputId = "switch4",
        label = "Fill switch with status:",
        fill = TRUE, status = "primary"
      ),
      verbatimTextOutput(outputId = "res4")
    ),
    column(
      width = 4,
      prettySwitch(
        inputId = "switch2",
        label = "Danger status:",
        status = "danger"
      ),
      verbatimTextOutput(outputId = "res2")
    ),
    column(
      width = 4,
      prettySwitch(
        inputId = "switch3",
        label = "Slim switch:",
        slim = TRUE
      ),
      verbatimTextOutput(outputId = "res3")
    )
  )

)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$switch1)
  output$res2 <- renderPrint(input$switch2)
  output$res3 <- renderPrint(input$switch3)
  output$res4 <- renderPrint(input$switch4)

}

if (interactive())
  shinyApp(ui, server)
```
