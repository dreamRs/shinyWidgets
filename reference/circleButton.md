# Circle Action button

Create a rounded action button.

## Usage

``` r
circleButton(inputId, icon = NULL, status = "default", size = "default", ...)
```

## Arguments

- inputId:

  The `input` slot that will be used to access the value.

- icon:

  An icon to appear on the button.

- status:

  Color of the button.

- size:

  Size of the button : default, lg, sm, xs.

- ...:

  Named attributes to be applied to the button.

## Examples

``` r
if (interactive()) {
  library(shiny)
  library(shinyWidgets)

  ui <- fluidPage(
    tags$h3("Rounded actionBution"),
    circleButton(inputId = "btn1", icon = icon("gear")),
    circleButton(
      inputId = "btn2",
      icon = icon("sliders"),
      status = "primary"
    ),
    verbatimTextOutput("res1"),
    verbatimTextOutput("res2")
  )

  server <- function(input, output, session) {

    output$res1 <- renderPrint({
      paste("value button 1:", input$btn1)
    })
    output$res2 <- renderPrint({
      paste("value button 2:", input$btn2)
    })

  }

  shinyApp(ui, server)
}
```
