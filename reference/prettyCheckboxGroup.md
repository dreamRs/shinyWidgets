# Pretty Checkbox Group Input Control

Create a group of pretty checkboxes that can be used to toggle multiple
choices independently. The server will receive the input as a character
vector of the selected values.

## Usage

``` r
prettyCheckboxGroup(
  inputId,
  label,
  choices = NULL,
  selected = NULL,
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
  width = NULL,
  choiceNames = NULL,
  choiceValues = NULL
)
```

## Arguments

- inputId:

  The `input` slot that will be used to access the value.

- label:

  Display label for the control.

- choices:

  List of values to show checkboxes for. If elements of the list are
  named then that name rather than the value is displayed to the user.
  If this argument is provided, then `choiceNames` and `choiceValues`
  must not be provided, and vice-versa. The values should be strings;
  other types (such as logicals and numbers) will be coerced to strings.

- selected:

  The values that should be initially selected, if any.

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

  If `TRUE`, render the choices inline (i.e. horizontally).

- width:

  The width of the input, e.g. `400px`, or `100%`.

- choiceNames:

  List of names to display to the user.

- choiceValues:

  List of values corresponding to `choiceNames`

## Value

A character vector or `NULL` server-side.

## See also

[`updatePrettyCheckboxGroup`](https://dreamrs.github.io/shinyWidgets/reference/updatePrettyCheckboxGroup.md)
for updating values server-side.

## Examples

``` r
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h1("Pretty checkbox group"),
  br(),

  fluidRow(
    column(
      width = 4,
      prettyCheckboxGroup(
        inputId = "checkgroup1",
        label = "Click me!",
        choices = c("Click me !", "Me !", "Or me !")
      ),
      verbatimTextOutput(outputId = "res1"),
      br(),
      prettyCheckboxGroup(
        inputId = "checkgroup4",
        label = "Click me!",
        choices = c("Click me !", "Me !", "Or me !"),
        outline = TRUE,
        plain = TRUE,
        icon = icon("thumbs-up")
      ),
      verbatimTextOutput(outputId = "res4")
    ),
    column(
      width = 4,
      prettyCheckboxGroup(
        inputId = "checkgroup2",
        label = "Click me!",
        thick = TRUE,
        choices = c("Click me !", "Me !", "Or me !"),
        animation = "pulse",
        status = "info"
      ),
      verbatimTextOutput(outputId = "res2"),
      br(),
      prettyCheckboxGroup(
        inputId = "checkgroup5",
        label = "Click me!",
        icon = icon("check"),
        choices = c("Click me !", "Me !", "Or me !"),
        animation = "tada",
        status = "default"
      ),
      verbatimTextOutput(outputId = "res5")
    ),
    column(
      width = 4,
      prettyCheckboxGroup(
        inputId = "checkgroup3",
        label = "Click me!",
        choices = c("Click me !", "Me !", "Or me !"),
        shape = "round",
        status = "danger",
        fill = TRUE,
        inline = TRUE
      ),
      verbatimTextOutput(outputId = "res3")
    )
  )

)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$checkgroup1)
  output$res2 <- renderPrint(input$checkgroup2)
  output$res3 <- renderPrint(input$checkgroup3)
  output$res4 <- renderPrint(input$checkgroup4)
  output$res5 <- renderPrint(input$checkgroup5)

}

if (interactive())
  shinyApp(ui, server)
```
