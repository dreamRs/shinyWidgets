# Prepare choices for [`virtualSelectInput()`](https://dreamrs.github.io/shinyWidgets/reference/virtualSelectInput.md)

Prepare choices for
[`virtualSelectInput()`](https://dreamrs.github.io/shinyWidgets/reference/virtualSelectInput.md)

## Usage

``` r
prepare_choices(
  .data,
  label,
  value,
  group_by = NULL,
  description = NULL,
  alias = NULL,
  classNames = NULL
)
```

## Arguments

- .data:

  An object of type
  [`data.frame()`](https://rdrr.io/r/base/data.frame.html).

- label:

  Variable to use as labels (displayed to user).

- value:

  Variable to use as values (retrieved server-side).

- group_by:

  Variable identifying groups to use option group feature.

- description:

  Optional variable allowing to show a text under the labels.

- alias:

  Optional variable containing text to use with search feature.

- classNames:

  Optional variable containing class names to customize specific
  options.

## Value

A `list` to use as `choices` argument of
[`virtualSelectInput()`](https://dreamrs.github.io/shinyWidgets/reference/virtualSelectInput.md).

## Examples

``` r
library(shiny)
library(shinyWidgets)

state_data <- data.frame(
  name = state.name,
  abb = state.abb,
  region = state.region,
  division = state.division
)

ui <- fluidPage(
  tags$h2("Virtual Select: prepare choices"),

  virtualSelectInput(
    inputId = "sel1",
    label = "Use a data.frame:",
    choices = prepare_choices(state_data, name, abb),
    search = TRUE
  ),
  verbatimTextOutput("res1"),

  virtualSelectInput(
    inputId = "sel2",
    label = "Group choices:",
    choices = prepare_choices(state_data, name, abb, region),
    multiple = TRUE
  ),
  verbatimTextOutput("res2"),

  virtualSelectInput(
    inputId = "sel3",
    label = "Add a description:",
    choices = prepare_choices(state_data, name, abb, description = division),
    multiple = TRUE,
    hasOptionDescription = TRUE
  ),
  verbatimTextOutput("res3")
)

server <- function(input, output, session) {
  output$res1 <- renderPrint(input$sel1)
  output$res2 <- renderPrint(input$sel2)
  output$res3 <- renderPrint(input$sel3)
}

if (interactive())
  shinyApp(ui, server)
```
