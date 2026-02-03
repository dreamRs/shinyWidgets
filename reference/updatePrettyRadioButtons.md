# Change the value pretty radio buttons on the client

Change the value pretty radio buttons on the client

## Usage

``` r
updatePrettyRadioButtons(
  session = getDefaultReactiveDomain(),
  inputId,
  label = NULL,
  choices = NULL,
  selected = NULL,
  inline = FALSE,
  choiceNames = NULL,
  choiceValues = NULL,
  prettyOptions = list()
)
```

## Arguments

- session:

  The `session` object passed to function given to shinyServer.

- inputId:

  The id of the input object.

- label:

  The label to set for the input object.

- choices:

  The choices to set for the input object, updating choices will reset
  parameters like `status`, `shape`, ... on the radio buttons, you can
  re-specify (or change them) in argument `prettyOptions`.

- selected:

  The value to set for the input object.

- inline:

  If `TRUE`, render the choices inline (i.e. horizontally).

- choiceNames:

  The choices names to set for the input object.

- choiceValues:

  The choices values to set for the input object.

- prettyOptions:

  Arguments passed to
  [`prettyRadioButtons`](https://dreamrs.github.io/shinyWidgets/reference/prettyRadioButtons.md)
  for styling radio buttons. This can be needed if you update choices.

## Examples

``` r
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h1("Update pretty radio buttons"),
  br(),

  fluidRow(
    column(
      width = 6,
      prettyRadioButtons(
        inputId = "radio1",
        label = "Update my value!",
        choices = month.name[1:4],
        status = "danger",
        icon = icon("xmark")
      ),
      verbatimTextOutput(outputId = "res1"),
      br(),
      radioButtons(
        inputId = "update1", label = "Update value :",
        choices = month.name[1:4], inline = TRUE
      )
    ),
    column(
      width = 6,
      prettyRadioButtons(
        inputId = "radio2",
        label = "Update my choices!",
        thick = TRUE,
        choices = month.name[1:4],
        animation = "pulse",
        status = "info"
      ),
      verbatimTextOutput(outputId = "res2"),
      br(),
      actionButton(inputId = "update2", label = "Update choices !")
    )
  )

)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$radio1)

  observeEvent(input$update1, {
    updatePrettyRadioButtons(
      session = session,
      inputId = "radio1",
      selected = input$update1
    )
  }, ignoreNULL = FALSE)

  output$res2 <- renderPrint(input$radio2)
  observeEvent(input$update2, {
    updatePrettyRadioButtons(
      session = session,
      inputId = "radio2",
      choices = sample(month.name, 4),
      prettyOptions = list(animation = "pulse",
                           status = "info",
                           shape = "round")
    )
  }, ignoreInit = TRUE)

}

if (interactive())
  shinyApp(ui, server)
```
