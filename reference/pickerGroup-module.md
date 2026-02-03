# Picker Group

Group of mutually dependent
[`pickerInput`](https://dreamrs.github.io/shinyWidgets/reference/pickerInput.md)
for filtering `data.frame`'s columns.

## Usage

``` r
pickerGroupUI(
  id,
  params,
  label = NULL,
  btn_label = "Reset filters",
  options = list(),
  inline = TRUE
)

pickerGroupServer(input, output, session, data, vars)
```

## Arguments

- id:

  Module's id.

- params:

  A named list of parameters passed to each
  [`pickerInput`](https://dreamrs.github.io/shinyWidgets/reference/pickerInput.md),
  you can use : `inputId` (obligatory, must be variable name), `label`,
  `placeholder`.

- label:

  Character, global label on top of all labels.

- btn_label:

  Character, reset button label.

- options:

  See
  [`pickerInput`](https://dreamrs.github.io/shinyWidgets/reference/pickerInput.md)
  options argument.

- inline:

  If `TRUE` (the default), `pickerInput`s are horizontally positioned,
  otherwise vertically.

- input:

  standard `shiny` input.

- output:

  standard `shiny` output.

- session:

  standard `shiny` session.

- data:

  a `data.frame`, or an object that can be coerced to `data.frame`.

- vars:

  character, columns to use to create filters, must correspond to
  variables listed in `params`.

## Value

a `reactive` function containing data filtered.

## Examples

``` r
if (interactive()) {

library(shiny)
library(shinyWidgets)


data("mpg", package = "ggplot2")


ui <- fluidPage(
  fluidRow(
    column(
      width = 10, offset = 1,
      tags$h3("Filter data with picker group"),
      panel(
        pickerGroupUI(
          id = "my-filters",
          params = list(
            manufacturer = list(inputId = "manufacturer", label = "Manufacturer:"),
            model = list(inputId = "model", label = "Model:"),
            trans = list(inputId = "trans", label = "Trans:"),
            class = list(inputId = "class", label = "Class:")
          )
        ), status = "primary"
      ),
      DT::dataTableOutput(outputId = "table")
    )
  )
)

server <- function(input, output, session) {
  res_mod <- callModule(
    module = pickerGroupServer,
    id = "my-filters",
    data = mpg,
    vars = c("manufacturer", "model", "trans", "class")
  )
  output$table <- DT::renderDataTable(res_mod())
}

shinyApp(ui, server)

}


### Not inline example

if (interactive()) {

  library(shiny)
  library(shinyWidgets)


  data("mpg", package = "ggplot2")


  ui <- fluidPage(
    fluidRow(
      column(
        width = 4,
        tags$h3("Filter data with picker group"),
        pickerGroupUI(
          id = "my-filters",
          inline = FALSE,
          params = list(
            manufacturer = list(inputId = "manufacturer", label = "Manufacturer:"),
            model = list(inputId = "model", label = "Model:"),
            trans = list(inputId = "trans", label = "Trans:"),
            class = list(inputId = "class", label = "Class:")
          )
        )
      ),
      column(
        width = 8,
        DT::dataTableOutput(outputId = "table")
      )
    )
  )

  server <- function(input, output, session) {
    res_mod <- callModule(
      module = pickerGroupServer,
      id = "my-filters",
      data = mpg,
      vars = c("manufacturer", "model", "trans", "class")
    )
    output$table <- DT::renderDataTable(res_mod())
  }

  shinyApp(ui, server)

}
```
