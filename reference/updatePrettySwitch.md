# Change the value of a pretty switch on the client

Change the value of a pretty switch on the client

## Usage

``` r
updatePrettySwitch(
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
  tags$h1("Pretty switch update value"),
  br(),

  prettySwitch(inputId = "switch1", label = "Update me !"),
  verbatimTextOutput(outputId = "res1"),
  radioButtons(
    inputId = "update",
    label = "Value to set:",
    choices = c("FALSE", "TRUE")
  )

)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$switch1)

  observeEvent(input$update, {
    updatePrettySwitch(
      session = session,
      inputId = "switch1",
      value = as.logical(input$update)
    )
  })

}

if (interactive())
  shinyApp(ui, server)
```
