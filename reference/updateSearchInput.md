# Change the value of a search input on the client

Change the value of a search input on the client

## Usage

``` r
updateSearchInput(
  session,
  inputId,
  label = NULL,
  value = NULL,
  placeholder = NULL,
  trigger = FALSE
)
```

## Arguments

- session:

  The `session` object passed to function given to `shinyServer`.

- inputId:

  The id of the input object.

- label:

  The label to set for the input object.

- value:

  The value to set for the input object.

- placeholder:

  The placeholder to set for the input object.

- trigger:

  Logical, update value server-side as well.

## Note

By default, only UI value is updated, use `trigger = TRUE` to update
both UI and Server value.

## Examples

``` r
if (interactive()) {

library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h2("Update searchinput"),
  searchInput(
    inputId = "search", label = "Enter your text",
    placeholder = "A placeholder",
    btnSearch = icon("magnifying-glass"),
    btnReset = icon("xmark"),
    width = "450px"
  ),
  br(),
  verbatimTextOutput(outputId = "res"),
  br(),
  textInput(
    inputId = "update_search",
    label = "Update search"
  ),
  checkboxInput(
    inputId = "trigger_search",
    label = "Trigger update search",
    value = TRUE
  )
)

server <- function(input, output, session) {

  output$res <- renderPrint({
    input$search
  })

  observeEvent(input$update_search, {
    updateSearchInput(
      session = session,
      inputId = "search",
      value = input$update_search,
      trigger = input$trigger_search
    )
  }, ignoreInit = TRUE)
}

shinyApp(ui, server)

}
```
