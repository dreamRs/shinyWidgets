# Pretty Checkbox Input

Create a pretty checkbox that can be used to specify logical values.

## Usage

``` r
prettyCheckbox(
  inputId,
  label,
  value = FALSE,
  status = "default",
  shape = c("square", "curve", "round"),
  outline = FALSE,
  fill = FALSE,
  thick = FALSE,
  animation = NULL,
  icon = NULL,
  plain = FALSE,
  bigger = FALSE,
  inline = FALSE,
  width = NULL
)
```

## Arguments

- inputId:

  The `input` slot that will be used to access the value.

- label:

  Display label for the control.

- value:

  Initial value (`TRUE` or `FALSE`).

- status:

  Add a class to the checkbox, you can use Bootstrap status like 'info',
  'primary', 'danger', 'warning' or 'success'.

- shape:

  Shape of the checkbox between `square`, `curve` and `round`.

- outline:

  Color also the border of the checkbox (`TRUE` or `FALSE`).

- fill:

  Fill the checkbox with color (`TRUE` or `FALSE`).

- thick:

  Make the content inside checkbox smaller (`TRUE` or `FALSE`).

- animation:

  Add an animation when checkbox is checked, a value between `smooth`,
  `jelly`, `tada`, `rotate`, `pulse`.

- icon:

  Optional, display an icon on the checkbox, must be an icon created
  with `icon`.

- plain:

  Remove the border when checkbox is checked (`TRUE` or `FALSE`).

- bigger:

  Scale the checkboxes a bit bigger (`TRUE` or `FALSE`).

- inline:

  Display the input inline, if you want to place checkboxes next to each
  other.

- width:

  The width of the input, e.g. `400px`, or `100%`.

## Value

`TRUE` or `FALSE` server-side.

## Note

Due to the nature of different checkbox design, certain animations are
not applicable in some arguments combinations. You can find examples on
the pretty-checkbox official page :
<https://lokesh-coder.github.io/pretty-checkbox/>.

## See also

See
[`updatePrettyCheckbox`](https://dreamrs.github.io/shinyWidgets/reference/updatePrettyCheckbox.md)
to update the value server-side. See
[`prettySwitch`](https://dreamrs.github.io/shinyWidgets/reference/prettySwitch.md)
and
[`prettyToggle`](https://dreamrs.github.io/shinyWidgets/reference/prettyToggle.md)
for similar widgets.

## Examples

``` r
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h1("Pretty checkbox"),
  br(),

  fluidRow(
    column(
      width = 4,
      prettyCheckbox(
        inputId = "checkbox1",
        label = "Click me!"
      ),
      verbatimTextOutput(outputId = "res1"),
      br(),
      prettyCheckbox(
        inputId = "checkbox4",
        label = "Click me!",
        outline = TRUE,
        plain = TRUE,
        icon = icon("thumbs-up")
      ),
      verbatimTextOutput(outputId = "res4")
    ),
    column(
      width = 4,
      prettyCheckbox(
        inputId = "checkbox2",
        label = "Click me!",
        thick = TRUE,
        animation = "pulse",
        status = "info"
      ),
      verbatimTextOutput(outputId = "res2"),
      br(),
      prettyCheckbox(
        inputId = "checkbox5",
        label = "Click me!",
        icon = icon("check"),
        animation = "tada",
        status = "default"
      ),
      verbatimTextOutput(outputId = "res5")
    ),
    column(
      width = 4,
      prettyCheckbox(
        inputId = "checkbox3",
        label = "Click me!",
        shape = "round",
        status = "danger",
        fill = TRUE,
        value = TRUE
      ),
      verbatimTextOutput(outputId = "res3")
    )
  )

)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$checkbox1)
  output$res2 <- renderPrint(input$checkbox2)
  output$res3 <- renderPrint(input$checkbox3)
  output$res4 <- renderPrint(input$checkbox4)
  output$res5 <- renderPrint(input$checkbox5)

}

if (interactive())
  shinyApp(ui, server)




# Inline example ----

ui <- fluidPage(
  tags$h1("Pretty checkbox: inline example"),
  br(),
  prettyCheckbox(
    inputId = "checkbox1",
    label = "Click me!",
    status = "success",
    outline = TRUE,
    inline = TRUE
  ),
  prettyCheckbox(
    inputId = "checkbox2",
    label = "Click me!",
    thick = TRUE,
    shape = "curve",
    animation = "pulse",
    status = "info",
    inline = TRUE
  ),
  prettyCheckbox(
    inputId = "checkbox3",
    label = "Click me!",
    shape = "round",
    status = "danger",
    value = TRUE,
    inline = TRUE
  ),
  prettyCheckbox(
    inputId = "checkbox4",
    label = "Click me!",
    outline = TRUE,
    plain = TRUE,
    animation = "rotate",
    icon = icon("thumbs-up"),
    inline = TRUE
  ),
  prettyCheckbox(
    inputId = "checkbox5",
    label = "Click me!",
    icon = icon("check"),
    animation = "tada",
    status = "primary",
    inline = TRUE
  ),
  verbatimTextOutput(outputId = "res")
)

server <- function(input, output, session) {

  output$res <- renderPrint(
    c(input$checkbox1,
      input$checkbox2,
      input$checkbox3,
      input$checkbox4,
      input$checkbox5)
  )

}

if (interactive())
  shinyApp(ui, server)
```
