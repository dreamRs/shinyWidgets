# Create a multiselect input control

A user-friendly replacement for select boxes with the multiple attribute

## Usage

``` r
multiInput(
  inputId,
  label,
  choices = NULL,
  selected = NULL,
  options = NULL,
  width = NULL,
  choiceNames = NULL,
  choiceValues = NULL,
  autocomplete = FALSE
)
```

## Arguments

- inputId:

  The `input` slot that will be used to access the value.

- label:

  Display label for the control, or `NULL` for no label.

- choices:

  List of values to select from.

- selected:

  The initially selected value.

- options:

  List of options passed to multi (`enable_search = FALSE` for disabling
  the search bar for example).

- width:

  The width of the input, e.g. `400px`, or `100%`.

- choiceNames:

  List of names to display to the user.

- choiceValues:

  List of values corresponding to `choiceNames`.

- autocomplete:

  Sets the initial state of the autocomplete property.

## Value

A multiselect control that can be added to the UI of a shiny app.

## References

Fabian Lindfors, "A user-friendly replacement for select boxes with
multiple attribute enabled",
<https://github.com/fabianlindfors/multi.js>.

## See also

[updateMultiInput](https://dreamrs.github.io/shinyWidgets/reference/updateMultiInput.md)
to update value server-side.

## Examples

``` r
## Only run examples in interactive R sessions
if (interactive()) {

library("shiny")
library("shinyWidgets")


# simple use

ui <- fluidPage(
  multiInput(
    inputId = "id", label = "Fruits :",
    choices = c("Banana", "Blueberry", "Cherry",
                "Coconut", "Grapefruit", "Kiwi",
                "Lemon", "Lime", "Mango", "Orange",
                "Papaya"),
    selected = "Banana", width = "350px"
  ),
  verbatimTextOutput(outputId = "res")
)

server <- function(input, output, session) {
  output$res <- renderPrint({
    input$id
  })
}

shinyApp(ui = ui, server = server)


# with options

ui <- fluidPage(
  multiInput(
    inputId = "id", label = "Fruits :",
    choices = c("Banana", "Blueberry", "Cherry",
                "Coconut", "Grapefruit", "Kiwi",
                "Lemon", "Lime", "Mango", "Orange",
                "Papaya"),
    selected = "Banana", width = "400px",
    options = list(
      enable_search = FALSE,
      non_selected_header = "Choose between:",
      selected_header = "You have selected:"
    )
  ),
  verbatimTextOutput(outputId = "res")
)

server <- function(input, output, session) {
  output$res <- renderPrint({
    input$id
  })
}

shinyApp(ui = ui, server = server)

}
```
