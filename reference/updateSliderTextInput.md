# Change the value of a slider text input on the client

Change the value of a slider text input on the client

## Usage

``` r
updateSliderTextInput(
  session = getDefaultReactiveDomain(),
  inputId,
  label = NULL,
  selected = NULL,
  choices = NULL,
  from_fixed = NULL,
  to_fixed = NULL
)
```

## Arguments

- session:

  The session object passed to function given to shinyServer.

- inputId:

  The id of the input object.

- label:

  The label to set.

- selected:

  The values selected.

- choices:

  The new choices for the input.

- from_fixed:

  Fix the left handle (or single handle).

- to_fixed:

  Fix the right handle.

## See also

[`sliderTextInput`](https://dreamrs.github.io/shinyWidgets/reference/sliderTextInput.md)

## Examples

``` r
if (interactive()) {
library("shiny")
library("shinyWidgets")

ui <- fluidPage(
  br(),
  sliderTextInput(
    inputId = "mySlider",
    label = "Pick a month :",
    choices = month.abb,
    selected = "Jan"
  ),
  verbatimTextOutput(outputId = "res"),
  radioButtons(
    inputId = "up",
    label = "Update choices:",
    choices = c("Abbreviations", "Full names")
  )
)

server <- function(input, output, session) {
  output$res <- renderPrint(str(input$mySlider))

  observeEvent(input$up, {
    choices <- switch(
      input$up,
      "Abbreviations" = month.abb,
      "Full names" = month.name
    )
    updateSliderTextInput(
      session = session,
      inputId = "mySlider",
      choices = choices
    )
  }, ignoreInit = TRUE)
}

shinyApp(ui = ui, server = server)
}
```
