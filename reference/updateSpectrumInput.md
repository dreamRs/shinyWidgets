# Change the value of a spectrum input on the client

Change the value of a spectrum input on the client

## Usage

``` r
updateSpectrumInput(session = getDefaultReactiveDomain(), inputId, selected)
```

## Arguments

- session:

  The session object passed to function given to shinyServer.

- inputId:

  The id of the input object.

- selected:

  The value to select.

## Examples

``` r
if (interactive()) {

library("shiny")
library("shinyWidgets")

ui <- fluidPage(
  tags$h1("Spectrum color picker"),

  br(),

  spectrumInput(
    inputId = "myColor",
    label = "Pick a color:",
    choices = list(
      list('black', 'white', 'blanchedalmond', 'steelblue', 'forestgreen')
    )
  ),
  verbatimTextOutput(outputId = "res"),
  radioButtons(
    inputId = "update", label = "Update:",
    choices = c(
      'black', 'white', 'blanchedalmond', 'steelblue', 'forestgreen'
    )

  )

)

server <- function(input, output, session) {

  output$res <- renderPrint(input$myColor)

  observeEvent(input$update, {
    updateSpectrumInput(session = session, inputId = "myColor", selected = input$update)
  }, ignoreInit = TRUE)

}

shinyApp(ui, server)

}
```
