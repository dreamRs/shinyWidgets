# Change the value of a pretty checkbox on the client

Change the value of a pretty checkbox on the client

## Usage

``` r
updatePrettyCheckbox(
  session = getDefaultReactiveDomain(),
  inputId,
  label = NULL,
  value = NULL
)
```

## Arguments

- session:

  The session object passed to function given to shinyServer.

- inputId:

  The id of the input object.

- label:

  The label to set for the input object.

- value:

  The value to set for the input object.

## Examples

``` r
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h1("Pretty checkbox update value"),
  br(),

  prettyCheckbox(
    inputId = "checkbox1",
    label = "Update me!",
    shape = "curve",
    thick = TRUE,
    outline = TRUE
  ),
  verbatimTextOutput(outputId = "res1"),
  radioButtons(
    inputId = "update",
    label = "Value to set:",
    choices = c("FALSE", "TRUE")
  )

)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$checkbox1)

  observeEvent(input$update, {
    updatePrettyCheckbox(
      session = session,
      inputId = "checkbox1",
      value = as.logical(input$update)
    )
  })

}

if (interactive())
  shinyApp(ui, server)
```
