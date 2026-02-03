# Pretty radio Buttons Input Control

Create a set of radio buttons used to select an item from a list.

## Usage

``` r
prettyRadioButtons(
  inputId,
  label,
  choices = NULL,
  selected = NULL,
  status = "primary",
  shape = c("round", "square", "curve"),
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

  List of values to show radio buttons for. If elements of the list are
  named then that name rather than the value is displayed to the user.
  If this argument is provided, then `choiceNames` and `choiceValues`
  must not be provided, and vice-versa. The values should be strings;
  other types (such as logicals and numbers) will be coerced to strings.

- selected:

  The values that should be initially selected, (if not specified then
  defaults to the first value).

- status:

  Add a class to the radio, you can use Bootstrap status like 'info',
  'primary', 'danger', 'warning' or 'success'.

- shape:

  Shape of the radio between `square`, `curve` and `round`.

- outline:

  Color also the border of the radio (`TRUE` or `FALSE`).

- fill:

  Fill the radio with color (`TRUE` or `FALSE`).

- thick:

  Make the content inside radio smaller (`TRUE` or `FALSE`).

- animation:

  Add an animation when radio is checked, a value between `smooth`,
  `jelly`, `tada`, `rotate`, `pulse`.

- icon:

  Optional, display an icon on the radio, must be an icon created with
  `icon`.

- plain:

  Remove the border when radio is checked (`TRUE` or `FALSE`).

- bigger:

  Scale the radio a bit bigger (`TRUE` or `FALSE`).

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

## Examples

``` r
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h1("Pretty radio buttons"),
  br(),

  fluidRow(
    column(
      width = 4,
      prettyRadioButtons(
        inputId = "radio1",
        label = "Click me!",
        choices = c("Click me !", "Me !", "Or me !")
      ),
      verbatimTextOutput(outputId = "res1"),
      br(),
      prettyRadioButtons(
        inputId = "radio4",
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
      prettyRadioButtons(
        inputId = "radio2",
        label = "Click me!",
        thick = TRUE,
        choices = c("Click me !", "Me !", "Or me !"),
        animation = "pulse",
        status = "info"
      ),
      verbatimTextOutput(outputId = "res2"),
      br(),
      prettyRadioButtons(
        inputId = "radio5",
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
      prettyRadioButtons(
        inputId = "radio3",
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

  output$res1 <- renderPrint(input$radio1)
  output$res2 <- renderPrint(input$radio2)
  output$res3 <- renderPrint(input$radio3)
  output$res4 <- renderPrint(input$radio4)
  output$res5 <- renderPrint(input$radio5)

}

if (interactive())
  shinyApp(ui, server)
```
