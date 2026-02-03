# Pretty Toggle Input

A single checkbox that changes appearance if checked or not.

## Usage

``` r
prettyToggle(
  inputId,
  label_on,
  label_off,
  icon_on = NULL,
  icon_off = NULL,
  value = FALSE,
  status_on = "success",
  status_off = "danger",
  shape = c("square", "curve", "round"),
  outline = FALSE,
  fill = FALSE,
  thick = FALSE,
  plain = FALSE,
  bigger = FALSE,
  animation = NULL,
  inline = FALSE,
  width = NULL
)
```

## Arguments

- inputId:

  The `input` slot that will be used to access the value.

- label_on:

  Display label for the control when value is `TRUE`.

- label_off:

  Display label for the control when value is `FALSE`

- icon_on:

  Optional, display an icon on the checkbox when value is `TRUE`, must
  be an icon created with `icon`.

- icon_off:

  Optional, display an icon on the checkbox when value is `FALSE`, must
  be an icon created with `icon`.

- value:

  Initial value (`TRUE` or `FALSE`).

- status_on:

  Add a class to the checkbox when value is `TRUE`, you can use
  Bootstrap status like 'info', 'primary', 'danger', 'warning' or
  'success'.

- status_off:

  Add a class to the checkbox when value is `FALSE`, you can use
  Bootstrap status like 'info', 'primary', 'danger', 'warning' or
  'success'.

- shape:

  Shape of the checkbox between `square`, `curve` and `round`.

- outline:

  Color also the border of the checkbox (`TRUE` or `FALSE`).

- fill:

  Fill the checkbox with color (`TRUE` or `FALSE`).

- thick:

  Make the content inside checkbox smaller (`TRUE` or `FALSE`).

- plain:

  Remove the border when checkbox is checked (`TRUE` or `FALSE`).

- bigger:

  Scale the checkboxes a bit bigger (`TRUE` or `FALSE`).

- animation:

  Add an animation when checkbox is checked, a value between `smooth`,
  `jelly`, `tada`, `rotate`, `pulse`.

- inline:

  Display the input inline, if you want to place checkboxes next to each
  other.

- width:

  The width of the input, e.g. `400px`, or `100%`.

## Value

`TRUE` or `FALSE` server-side.

## See also

See
[`updatePrettyToggle`](https://dreamrs.github.io/shinyWidgets/reference/updatePrettyToggle.md)
to update the value server-side.

## Examples

``` r
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h1("Pretty toggles"),
  br(),

  fluidRow(
    column(
      width = 4,
      prettyToggle(
        inputId = "toggle1",
        label_on = "Checked!",
        label_off = "Unchecked..."
      ),
      verbatimTextOutput(outputId = "res1"),
      br(),
      prettyToggle(
        inputId = "toggle4",  label_on = "Yes!",
        label_off = "No..", outline = TRUE,
        plain = TRUE,
        icon_on = icon("thumbs-up"),
        icon_off = icon("thumbs-down")
      ),
      verbatimTextOutput(outputId = "res4")
    ),
    column(
      width = 4,
      prettyToggle(
        inputId = "toggle2",
        label_on = "Yes!", icon_on = icon("check"),
        status_on = "info", status_off = "warning",
        label_off = "No..", icon_off = icon("xmark")
      ),
      verbatimTextOutput(outputId = "res2")
    ),
    column(
      width = 4,
      prettyToggle(
        inputId = "toggle3",  label_on = "Yes!",
        label_off = "No..", shape = "round",
        fill = TRUE, value = TRUE
      ),
      verbatimTextOutput(outputId = "res3")
    )
  )

)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$toggle1)
  output$res2 <- renderPrint(input$toggle2)
  output$res3 <- renderPrint(input$toggle3)
  output$res4 <- renderPrint(input$toggle4)

}

if (interactive())
  shinyApp(ui, server)




# Inline example ----

ui <- fluidPage(
  tags$h1("Pretty toggles: inline example"),
  br(),

  prettyToggle(
    inputId = "toggle1",
    label_on = "Checked!",
    label_off = "Unchecked...",
    inline = TRUE
  ),
  prettyToggle(
    inputId = "toggle2",
    label_on = "Yep",
    status_on = "default",
    icon_on = icon("ok-circle", lib = "glyphicon"),
    label_off = "Nope",
    status_off = "default",
    icon_off = icon("remove-circle", lib = "glyphicon"),
    plain = TRUE,
    inline = TRUE
  ),
  prettyToggle(
    inputId = "toggle3",
    label_on = "",
    label_off = "",
    icon_on = icon("volume-high", lib = "glyphicon"),
    icon_off = icon("volume-off", lib = "glyphicon"),
    status_on = "primary",
    status_off = "default",
    plain = TRUE,
    outline = TRUE,
    bigger = TRUE,
    inline = TRUE
  ),
  prettyToggle(
    inputId = "toggle4",
    label_on = "Yes!",
    label_off = "No..",
    outline = TRUE,
    plain = TRUE,
    icon_on = icon("thumbs-up"),
    icon_off = icon("thumbs-down"),
    inline = TRUE
  ),

  verbatimTextOutput(outputId = "res")

)

server <- function(input, output, session) {

  output$res <- renderPrint(
    c(input$toggle1,
      input$toggle2,
      input$toggle3,
      input$toggle4)
  )

}

if (interactive())
  shinyApp(ui, server)
```
