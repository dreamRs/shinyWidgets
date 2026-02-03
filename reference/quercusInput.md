# Quercus Input Widget

A Lightweight and Customizable JavaScript Treeview Library with
absolutely no dependencies. See original widget
[quercus.js](https://github.com/stefaneichert/quercus.js).

## Usage

``` r
quercusInput(
  inputId,
  label,
  choices,
  selected = NULL,
  ...,
  nodeNameKey = "text",
  returnValue = c("text", "id", "all"),
  unsetMaxWidth = TRUE,
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

- ...:

  Arguments passed to Quercus.js's Treeview JavaScript method, see
  [online
  documentation](https://github.com/stefaneichert/quercus.js?tab=readme-ov-file#treeview-options)
  for available methods or examples.

- nodeNameKey:

  The key to retrieve label to use in `choices`. If
  [`create_tree()`](https://dreamrs.github.io/shinyWidgets/reference/create_tree.md)
  is used in `choices`, `nodeNameKey` must be set to `"text"`.

- returnValue:

  Value returned server-side, default to `"text"` the node text, other
  possibilities are `"id"` (if no ID provided in `choices = `, one is
  generated) or `"all"` to returned all the tree under the element
  selected.

- unsetMaxWidth:

  Default behavior in `quercus.js` is to set max-width to `600px`, this
  allow to disable this rule.

- width:

  The width of the input, e.g. `400px`, or `"100%`.

## Value

A `shiny.tag` object that can be used in a UI definition.

## See also

[`updateQuercusInput()`](https://dreamrs.github.io/shinyWidgets/reference/updateQuercusInput.md)
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
  theme = bslib::bs_theme(version = 5, preset = "bootstrap"),
  tags$h2("quercusInput() example"),
  fluidRow(
    column(
      width = 4,

      quercusInput(
        inputId = "ID1",
        label = "Select cities: (initiallyExpanded = TRUE)",
        choices = create_tree(cities),
        initiallyExpanded = TRUE,
        returnValue = "text",
        width = "100%"
      ),
      verbatimTextOutput("res1"),

      quercusInput(
        inputId = "ID4",
        label = "Select cities: (multiSelectEnabled = TRUE)",
        choices = create_tree(cities),
        multiSelectEnabled = TRUE,
        returnValue = "text",
        width = "100%"
      ),
      verbatimTextOutput("res4")

    ),
    column(
      width = 4,

      quercusInput(
        inputId = "ID2",
        label = "Select cities: (searchEnabled = TRUE)",
        choices = create_tree(cities),
        searchEnabled = TRUE,
        returnValue = "text",
        width = "100%"
      ),
      verbatimTextOutput("res2"),

      quercusInput(
        inputId = "ID5",
        label = "Select cities: (checkboxSelectionEnabled = TRUE)",
        choices = create_tree(cities),
        checkboxSelectionEnabled = TRUE,
        returnValue = "text",
        width = "100%"
      ),
      verbatimTextOutput("res5"),

      quercusInput(
        inputId = "ID7",
        label = "Select cities: (cascadeSelectChildren = TRUE)",
        choices = create_tree(cities),
        cascadeSelectChildren = TRUE,
        returnValue = "text",
        width = "100%"
      ),
      verbatimTextOutput("res7")

    ),
    column(
      width = 4,

      quercusInput(
        inputId = "ID3",
        label = "Select cities: (multiSelectEnabled = TRUE, returnValue = \"all\")",
        choices = create_tree(cities),
        multiSelectEnabled = TRUE,
        returnValue = "all",
        width = "100%"
      ),
      verbatimTextOutput("res3"),

      quercusInput(
        inputId = "ID6a",
        label = "Select cities: (selected value)",
        choices = create_tree(cities),
        selected = "Monastir",
        returnValue = "text",
        width = "100%"
      ),
      verbatimTextOutput("res6a"),

      quercusInput(
        inputId = "ID6b",
        label = "Select cities: (selected valueS)",
        choices = create_tree(cities),
        multiSelectEnabled = TRUE,
        selected = c("Monastir", "Madrid"),
        returnValue = "text",
        width = "100%"
      ),
      verbatimTextOutput("res6b")

    )
  )
)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$ID1)
  output$res2 <- renderPrint(input$ID2)
  output$res3 <- renderPrint(input$ID3)
  output$res4 <- renderPrint(input$ID4)
  output$res5 <- renderPrint(input$ID5)
  output$res6a <- renderPrint(input$ID6a)
  output$res6b <- renderPrint(input$ID6b)
  output$res7 <- renderPrint(input$ID7)

}

if (interactive())
  shinyApp(ui, server)
```
