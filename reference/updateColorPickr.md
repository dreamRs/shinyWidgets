# Update color pickr server-side

Update color pickr server-side

## Usage

``` r
updateColorPickr(
  session = getDefaultReactiveDomain(),
  inputId,
  label = NULL,
  value = NULL,
  action = NULL,
  swatches = NULL
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

- action:

  Action to perform on color-picker: enable, disable, show or hide.

- swatches:

  Optional color swatches.

## Value

No return value.

## See also

[`colorPickr()`](https://dreamrs.github.io/shinyWidgets/reference/colorPickr.md)
for creating a widget in the UI.

## Examples

``` r
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h2("Update colorPickr example"),
  fluidRow(
    column(
      width = 6,
      colorPickr(
        inputId = "id1",
        label = "Update this label:",
        width = "300px"
      ),
      textInput(
        inputId = "update_label",
        label = "Update label above :"
      )
    ),
    column(
      width = 6,
      colorPickr(
        inputId = "id2",
        label = "Swatches :",
        selected = "#440154",
        swatches = c(
          scales::viridis_pal()(9)
        ),
        update = "change",
        opacity = FALSE,
        preview = FALSE,
        hue = FALSE,
        interaction = list(
          hex= FALSE,
          rgba = FALSE,
          input = FALSE,
          save = FALSE,
          clear = FALSE
        ),
        pickr_width = "245px",
        inline = TRUE
      ),
      verbatimTextOutput("res"),
      actionButton("red", "Update red"),
      actionButton("green", "Update green"),
      actionButton("blue", "Update blue")
    )
  )
)

server <- function(input, output, session) {

  observeEvent(
    input$update_label,
    updateColorPickr(inputId = "id1", label = input$update_label),
    ignoreInit = TRUE
  )


  output$res <- renderPrint(input$id1)

  observeEvent(
    input$red,
    updateColorPickr(inputId = "id2", swatches = scales::brewer_pal(palette = "Reds")(9))
  )
  observeEvent(
    input$green,
    updateColorPickr(inputId = "id2", swatches = scales::brewer_pal(palette = "Greens")(9))
  )
  observeEvent(
    input$blue,
    updateColorPickr(inputId = "id2", swatches = scales::brewer_pal(palette = "Blues")(9))
  )

}

if (interactive())
  shinyApp(ui, server)
```
