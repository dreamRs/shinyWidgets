# Change the value of a radio group buttons input on the client

Change the value of a radio group buttons input on the client

## Usage

``` r
updateRadioGroupButtons(
  session = getDefaultReactiveDomain(),
  inputId,
  label = NULL,
  choices = NULL,
  selected = NULL,
  status = "default",
  size = "normal",
  justified = FALSE,
  checkIcon = list(),
  choiceNames = NULL,
  choiceValues = NULL,
  disabled = FALSE,
  disabledChoices = NULL
)
```

## Arguments

- session:

  The `session` object passed to function given to `shinyServer`.
  Default is
  [`getDefaultReactiveDomain()`](https://rdrr.io/pkg/shiny/man/domains.html).

- inputId:

  The id of the input object.

- label:

  The label to set for the input object.

- choices:

  List of values to select from (if elements of the list are named then
  that name rather than the value is displayed to the user). If this
  argument is provided, then `choiceNames` and `choiceValues` must not
  be provided, and vice-versa. The values should be strings; other types
  (such as logicals and numbers) will be coerced to strings.

- selected:

  The initially selected value. If not specified, then it defaults to
  the first item in `choices`. To start with no items selected, use
  `character(0)`.

- status:

  Add a class to the buttons, you can use Bootstrap status like 'info',
  'primary', 'danger', 'warning' or 'success'. Or use an arbitrary
  strings to add a custom class, e.g. : with `status = "custom-class"`,
  buttons will have class `btn-custom-class`.

- size:

  Size of the buttons ('xs', 'sm', 'normal', 'lg')

- justified:

  If TRUE, fill the width of the parent div

- checkIcon:

  A list, if no empty must contain at least one element named 'yes'
  corresponding to an icon to display if the button is checked.

- choiceNames, choiceValues:

  List of names and values, respectively, that are displayed to the user
  in the app and correspond to the each choice (for this reason,
  `choiceNames` and `choiceValues` must have the same length). If either
  of these arguments is provided, then the other *must* be provided and
  `choices` *must not* be provided. The advantage of using both of these
  over a named list for `choices` is that `choiceNames` allows any type
  of UI object to be passed through (tag objects, icons, HTML code,
  ...), instead of just simple text. See Examples.

- disabled:

  Logical, disable or enable buttons, if `TRUE` users won't be able to
  select a value.

- disabledChoices:

  Vector of specific choices to disable.

## See also

[`radioGroupButtons()`](https://dreamrs.github.io/shinyWidgets/reference/radioGroupButtons.md)

## Examples

``` r
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  radioGroupButtons(
    inputId = "somevalue",
    choices = c("A", "B", "C"),
    label = "My label"
  ),

  verbatimTextOutput(outputId = "res"),

  actionButton(inputId = "updatechoices", label = "Random choices"),
  pickerInput(
    inputId = "updateselected", label = "Update selected:",
    choices = c("A", "B", "C"), multiple = FALSE
  ),
  textInput(inputId = "updatelabel", label = "Update label")
)

server <- function(input, output, session) {

  output$res <- renderPrint({
    input$somevalue
  })

  observeEvent(input$updatechoices, {
    newchoices <- sample(letters, sample(3:9, 1))
    updateRadioGroupButtons(
      session = session,
      inputId = "somevalue",
      choices = newchoices
    )
    updatePickerInput(
      session = session,
      inputId = "updateselected",
      choices = newchoices
    )
  })

  observeEvent(input$updateselected, {
    updateRadioGroupButtons(
      session = session, inputId = "somevalue",
      selected = input$updateselected
    )
  }, ignoreNULL = TRUE, ignoreInit = TRUE)

  observeEvent(input$updatelabel, {
    updateRadioGroupButtons(
      session = session, inputId = "somevalue",
      label = input$updatelabel
    )
  }, ignoreInit = TRUE)

}

if (interactive())
  shinyApp(ui = ui, server = server)
```
