# Prepare choices for [`slimSelectInput()`](https://dreamrs.github.io/shinyWidgets/reference/slimSelectInput.md)

Prepare choices for
[`slimSelectInput()`](https://dreamrs.github.io/shinyWidgets/reference/slimSelectInput.md)

## Usage

``` r
prepare_slim_choices(
  .data,
  label,
  value,
  html = NULL,
  selected = NULL,
  display = NULL,
  disabled = NULL,
  mandatory = NULL,
  class = NULL,
  style = NULL,
  .by = NULL,
  selectAll = NULL,
  closable = NULL
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

- html:

  Alternative HTML to be displayed instaed of label.

- selected:

  Is the option must be selected ?

- display:

  Allows to hide elements of selected values.

- disabled:

  Allows the ability to disable the select dropdown as well as
  individual options.

- mandatory:

  When using multi select you can set a mandatory on the option to
  prevent capability to deselect particular option. Note options with
  mandatory flag is not selected by default, you need select them
  yourselfs.

- class:

  Add CSS classes.

- style:

  Add custom styles to options.

- .by:

  Variable identifying groups to use option group feature.

- selectAll:

  Enable select all feature for options groups.

- closable:

  Allow to close options groups, one of: 'off', 'open', 'close'.

## Value

A `list` to use as `choices` argument of
[`slimSelectInput()`](https://dreamrs.github.io/shinyWidgets/reference/slimSelectInput.md).

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
  tags$h2("Slim Select examples"),
  fluidRow(
    column(
      width = 3,
      slimSelectInput(
        inputId = "slim1",
        label = "Disable some choices:",
        choices = prepare_slim_choices(
          state_data,
          label = name,
          value = abb,
          disabled = division == "Mountain"
        ),
        width = "100%"
      ),
      verbatimTextOutput("res1")
    ),
    column(
      width = 3,
      slimSelectInput(
        inputId = "slim2",
        label = "Custom styles:",
        choices = prepare_slim_choices(
          state_data,
          label = name,
          value = abb,
          style = ifelse(
            division == "Mountain",
            "color: blue;",
            "color: red;"
          )
        ),
        multiple = TRUE,
        placeholder = "Select a state",
        width = "100%"
      ),
      verbatimTextOutput("res2")
    ),
    column(
      width = 3,
      slimSelectInput(
        inputId = "slim3",
        label = "Options groups with options:",
        choices = prepare_slim_choices(
          state_data,
          label = name,
          value = abb,
          .by = region,
          selectAll = TRUE,
          closable = "close"
        ),
        multiple = TRUE,
        width = "100%"
      ),
      verbatimTextOutput("res3")
    )
  )
)

server <- function(input, output, session) {
  output$res1 <- renderPrint(input$slim1)

  output$res2 <- renderPrint(input$slim2)

  output$res3 <- renderPrint(input$slim3)
}

if (interactive())
  shinyApp(ui, server)
```
