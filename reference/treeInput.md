# Tree Input Widget

A tree input widget allowing to select values in a hierarchical
structure.

## Usage

``` r
treeInput(
  inputId,
  label,
  choices,
  selected = NULL,
  closeDepth = 1,
  returnValue = c("text", "id", "all"),
  width = NULL
)
```

## Arguments

- inputId:

  The `input` slot that will be used to access the value.

- label:

  Display label for the control, or `NULL` for no label.

- choices:

  A `list` of `list` in a tree structure, see
  [`create_tree()`](https://dreamrs.github.io/shinyWidgets/reference/create_tree.md)
  for examples creating the right structure.

- selected:

  Inital selected values, note that you have to use node ID.

- closeDepth:

  Expand level, default to only first one visible.

- returnValue:

  Value returned server-side, default to `"text"` the node text, other
  possibilities are `"id"` (if no ID provided in `choices = `, one is
  generated) or `"all"` to returned all the tree under the element
  selected.

- width:

  The width of the input, e.g. `400px`, or `"100%`.

## Value

A `shiny.tag` object that can be used in a UI definition.

## See also

[`updateTreeInput()`](https://dreamrs.github.io/shinyWidgets/reference/updateTreeInput.md)
for updating from server.

## Examples

``` r
library(shiny)
library(shinyWidgets)

# data
cities <- data.frame(
  continent = c("America", "America", "America", "Africa",
                "Africa", "Africa", "Africa", "Africa",
                "Europe", "Europe", "Europe", "Antarctica"),
  country = c("Canada", "Canada", "USA", "Tunisia", "Tunisia",
              "Tunisia", "Algeria", "Algeria", "Italy", "Germany", "Spain", NA),
  city = c("Trois-Rivières", "Québec", "San Francisco", "Tunis",
           "Monastir", "Sousse", "Alger", "Oran", "Rome", "Berlin", "Madrid", NA),
  stringsAsFactors = FALSE
)

# app
ui <- fluidPage(
  tags$h2("treeInput() example"),
  fluidRow(
    column(
      width = 4,
      treeInput(
        inputId = "ID1",
        label = "Select cities:",
        choices = create_tree(cities),
        selected = "San Francisco",
        returnValue = "text",
        closeDepth = 0
      ),
      verbatimTextOutput("res1")
    ),
    column(
      width = 4,
      treeInput(
        inputId = "ID2",
        label = "Select cities:",
        choices = create_tree(cities),
        selected = "San Francisco",
        returnValue = "text",
        closeDepth = 1
      ),
      verbatimTextOutput("res2")
    ),
    column(
      width = 4,
      treeInput(
        inputId = "ID3",
        label = "Select cities:",
        choices = create_tree(cities),
        selected = c("San Francisco", "Monastir"),
        returnValue = "text",
        closeDepth = 2
      ),
      verbatimTextOutput("res3")
    )
  )
)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$ID1)
  output$res2 <- renderPrint(input$ID2)
  output$res3 <- renderPrint(input$ID3)

}

if (interactive())
  shinyApp(ui, server)
```
