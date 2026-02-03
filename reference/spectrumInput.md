# Palette Color Picker with Spectrum Library

A widget to select a color within palettes, and with more options if
needed.

## Usage

``` r
spectrumInput(
  inputId,
  label,
  choices = NULL,
  selected = NULL,
  flat = FALSE,
  options = list(),
  update_on = c("move", "dragstop", "change"),
  width = NULL
)
```

## Arguments

- inputId:

  The `input` slot that will be used to access the value.

- label:

  Display label for the control, or `NULL` for no label.

- choices:

  List of colors to display in the menu.

- selected:

  The initially selected value.

- flat:

  Display the menu inline.

- options:

  Additional options to pass to spectrum, possible values are described
  here : <https://bgrins.github.io/spectrum/#options>.

- update_on:

  When to update value server-side: `"move"` (default, each time a new
  color is selected), `"dragstop"` (when use user stop dragging cursor),
  `"change"` (when the input is closed).

- width:

  The width of the input, e.g. `400px`, or `100%`.

## Value

The selected color in Hex format server-side

## Examples

``` r
if (interactive()) {

library("shiny")
library("shinyWidgets")
library("scales")

ui <- fluidPage(
  tags$h1("Spectrum color picker"),

  br(),

  spectrumInput(
    inputId = "myColor",
    label = "Pick a color:",
    choices = list(
      list('black', 'white', 'blanchedalmond', 'steelblue', 'forestgreen'),
      as.list(brewer_pal(palette = "Blues")(9)),
      as.list(brewer_pal(palette = "Greens")(9)),
      as.list(brewer_pal(palette = "Spectral")(11)),
      as.list(brewer_pal(palette = "Dark2")(8))
    ),
    options = list(`toggle-palette-more-text` = "Show more")
  ),
  verbatimTextOutput(outputId = "res")

)

server <- function(input, output, session) {

  output$res <- renderPrint(input$myColor)

}

shinyApp(ui, server)

}
```
