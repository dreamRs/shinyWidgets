# Change the value of a multi input on the client

Change the value of a multi input on the client

## Usage

``` r
updateMultiInput(
  session,
  inputId,
  label = NULL,
  selected = NULL,
  choices = NULL
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

  The values selected. To select none, use `character(0)`.

- choices:

  The new choices for the input.

## Note

Thanks to [Ian Fellows](https://github.com/ifellows) for this one !

## See also

[`multiInput`](https://dreamrs.github.io/shinyWidgets/reference/multiInput.md)

## Examples

``` r
if (interactive()) {

library(shiny)
library(shinyWidgets)

fruits <- c("Banana", "Blueberry", "Cherry",
            "Coconut", "Grapefruit", "Kiwi",
            "Lemon", "Lime", "Mango", "Orange",
            "Papaya")

ui <- fluidPage(
  tags$h2("Multi update"),
  multiInput(
    inputId = "my_multi",
    label = "Fruits :",
    choices = fruits,
    selected = "Banana",
    width = "350px"
  ),
  verbatimTextOutput(outputId = "res"),
  selectInput(
    inputId = "selected",
    label = "Update selected:",
    choices = fruits,
    multiple = TRUE
  ),
  textInput(inputId = "label", label = "Update label:")
)

server <- function(input, output, session) {

  output$res <- renderPrint(input$my_multi)

  observeEvent(input$selected, {
    updateMultiInput(
      session = session,
      inputId = "my_multi",
      selected = input$selected
    )
  })

  observeEvent(input$label, {
    updateMultiInput(
      session = session,
      inputId = "my_multi",
      label = input$label
    )
  }, ignoreInit = TRUE)
}

shinyApp(ui, server)

}
```
