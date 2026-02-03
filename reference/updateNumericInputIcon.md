# Change the value of a numeric input icon on the client

Change the value of a numeric input icon on the client

## Usage

``` r
updateNumericInputIcon(
  session = getDefaultReactiveDomain(),
  inputId,
  label = NULL,
  value = NULL,
  min = NULL,
  max = NULL,
  step = NULL,
  icon = NULL
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

- value:

  Initial value.

- min:

  Minimum allowed value

- max:

  Maximum allowed value

- step:

  Interval to use when stepping between min and max

- icon:

  Icon to update, note that you can update icon only if initialized in
  [`numericInputIcon()`](https://dreamrs.github.io/shinyWidgets/reference/numericInputIcon.md).

## Value

No value.

## See also

[`numericInputIcon()`](https://dreamrs.github.io/shinyWidgets/reference/numericInputIcon.md)

## Examples

``` r
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  numericInputIcon(
    inputId = "id",
    label = "With an icon",
    value = 10,
    icon = icon("percent")
  ),
  actionButton("updateValue", "Update value"),
  actionButton("updateIcon", "Update icon"),
  verbatimTextOutput("value")
)

server <- function(input, output, session) {

  output$value <- renderPrint(input$id)

  observeEvent(input$updateValue, {
    updateNumericInputIcon(
      session = session,
      inputId = "id",
      value = sample.int(100, 1)
    )
  })

  observeEvent(input$updateIcon, {
    i <- sample(c("home", "gears", "dollar-sign", "globe", "sliders-h"), 1)
    updateNumericInputIcon(
      session = session,
      inputId = "id",
      icon = icon(i)
    )
  })

}

if (interactive())
  shinyApp(ui, server)
```
