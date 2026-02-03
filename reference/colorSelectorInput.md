# Color Selector Input

Choose between a restrictive set of colors.

## Usage

``` r
colorSelectorInput(
  inputId,
  label,
  choices,
  selected = NULL,
  mode = c("radio", "checkbox"),
  display_label = FALSE,
  ncol = 10
)

colorSelectorExample()
```

## Arguments

- inputId:

  The `input` slot that will be used to access the value.

- label:

  Display label for the control, or `NULL` for no label.

- choices:

  A list of colors, can be a list of named list, see example.

- selected:

  Default selected color, if `NULL` the first color for `mode = 'radio'`
  and none for `mode = 'checkbox'`

- mode:

  `'radio'` for only one choice, `'checkbox'` for selecting multiple
  values.

- display_label:

  Display list's names after palette of color.

- ncol:

  If choices is not a list but a vector, go to line after n elements.

## Functions

- `colorSelectorExample()`: Examples of use for colorSelectorInput

## Examples

``` r
if (interactive()) {

# Full example
colorSelectorExample()

# Simple example
ui <- fluidPage(
  colorSelectorInput(
    inputId = "mycolor1", label = "Pick a color :",
    choices = c("steelblue", "cornflowerblue",
                "firebrick", "palegoldenrod",
                "forestgreen")
  ),
  verbatimTextOutput("result1")
)

server <- function(input, output, session) {
  output$result1 <- renderPrint({
    input$mycolor1
  })
}

shinyApp(ui = ui, server = server)

}
```
