# Selectize Group

Group of mutually dependent `selectizeInput` for filtering data.frame's
columns (like in Excel).

## Usage

``` r
selectizeGroupUI(
  id,
  params,
  label = NULL,
  btn_label = "Reset filters",
  inline = TRUE
)

selectizeGroupServer(input, output, session, data, vars, inline = TRUE)
```

## Arguments

- id:

  Module's id.

- params:

  A named list of parameters passed to each `selectizeInput`, you can
  use : `inputId` (obligatory, must be variable name), `label`,
  `placeholder`.

- label:

  Character, global label on top of all labels.

- btn_label:

  Character, reset button label.

- inline:

  If `TRUE` (the default), `selectizeInput`s are horizontally
  positioned, otherwise vertically. Use this argument in
  `selectizeGroupUI` **and** in `selectizeGroupServer` to make it work
  properly.

- input, output, session:

  standards `shiny` server arguments.

- data:

  Either a [`data.frame()`](https://rdrr.io/r/base/data.frame.html) or a
  [`shiny::reactive()`](https://rdrr.io/pkg/shiny/man/reactive.html)
  function returning a `data.frame` (do not use parentheses).

- vars:

  character, columns to use to create filters, must correspond to
  variables listed in `params`. Can be a `reactive` function, but values
  must be included in the initial ones (in `params`).

## Value

a [`shiny::reactive()`](https://rdrr.io/pkg/shiny/man/reactive.html)
function containing data filtered.

## Examples

``` r
# Default -----------------------------------------------------------------

if (interactive()) {

  library(shiny)
  library(shinyWidgets)

  data("mpg", package = "ggplot2")

  ui <- fluidPage(
    fluidRow(
      column(
        width = 10, offset = 1,
        tags$h3("Filter data with selectize group"),
        panel(
          selectizeGroupUI(
            id = "my-filters",
            params = list(
              manufacturer = list(inputId = "manufacturer", title = "Manufacturer:"),
              model = list(inputId = "model", title = "Model:"),
              trans = list(inputId = "trans", title = "Trans:"),
              class = list(inputId = "class", title = "Class:")
            )
          ), status = "primary"
        ),
        DT::dataTableOutput(outputId = "table")
      )
    )
  )

  server <- function(input, output, session) {
    res_mod <- callModule(
      module = selectizeGroupServer,
      id = "my-filters",
      data = mpg,
      vars = c("manufacturer", "model", "trans", "class")
    )
    output$table <- DT::renderDataTable(res_mod())
  }

  shinyApp(ui, server)

}

# Select variables --------------------------------------------------------

if (interactive()) {

  library(shiny)
  library(shinyWidgets)

  data("mpg", package = "ggplot2")

  ui <- fluidPage(
    fluidRow(
      column(
        width = 10, offset = 1,
        tags$h3("Filter data with selectize group"),
        panel(
          checkboxGroupInput(
            inputId = "vars",
            label = "Variables to use:",
            choices = c("manufacturer", "model", "trans", "class"),
            selected = c("manufacturer", "model", "trans", "class"),
            inline = TRUE
          ),
          selectizeGroupUI(
            id = "my-filters",
            params = list(
              manufacturer = list(inputId = "manufacturer", title = "Manufacturer:"),
              model = list(inputId = "model", title = "Model:"),
              trans = list(inputId = "trans", title = "Trans:"),
              class = list(inputId = "class", title = "Class:")
            )
          ),
          status = "primary"
        ),
        DT::dataTableOutput(outputId = "table")
      )
    )
  )

  server <- function(input, output, session) {

    vars_r <- reactive({
      input$vars
    })

    res_mod <- callModule(
      module = selectizeGroupServer,
      id = "my-filters",
      data = mpg,
      vars = vars_r
    )

    output$table <- DT::renderDataTable({
      req(res_mod())
      res_mod()
    })
  }

  shinyApp(ui, server)
}

# Subset data -------------------------------------------------------------

if (interactive()) {

  library(shiny)
  library(shinyWidgets)

  data("mpg", package = "ggplot2")

  ui <- fluidPage(
    fluidRow(
      column(
        width = 10, offset = 1,
        tags$h3("Filter data with selectize group"),
        panel(
          pickerInput(
            inputId = "car_select",
            choices = unique(mpg$manufacturer),
            options = list(
              `live-search` = TRUE,
              title = "None selected"
            )
          ),
          selectizeGroupUI(
            id = "my-filters",
            params = list(
              manufacturer = list(inputId = "manufacturer", title = "Manufacturer:"),
              model = list(inputId = "model", title = "Model:"),
              trans = list(inputId = "trans", title = "Trans:"),
              class = list(inputId = "class", title = "Class:")
            )
          ),
          status = "primary"
        ),
        DT::dataTableOutput(outputId = "table")
      )
    )
  )

  server <- function(input, output, session) {

    mpg_filter <- reactive({
      subset(mpg, manufacturer %in% input$car_select)
    })

    res_mod <- callModule(
      module = selectizeGroupServer,
      id = "my-filters",
      data = mpg_filter,
      vars = c("manufacturer", "model", "trans", "class")
    )

    output$table <- DT::renderDataTable({
      req(res_mod())
      res_mod()
    })
  }

  shinyApp(ui, server)
}
```
