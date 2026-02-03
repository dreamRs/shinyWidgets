# Mutate Vertical Tabset Panel

Mutate Vertical Tabset Panel

## Usage

``` r
appendVerticalTab(inputId, tab, session = shiny::getDefaultReactiveDomain())

removeVerticalTab(inputId, index, session = shiny::getDefaultReactiveDomain())

reorderVerticalTabs(
  inputId,
  newOrder,
  session = shiny::getDefaultReactiveDomain()
)
```

## Arguments

- inputId:

  The id of the `verticalTabsetPanel` object.

- tab:

  The verticalTab to append.

- session:

  The `session` object passed to function given to `shinyServer.`

- index:

  The index of the the tab to remove.

- newOrder:

  The new index order.

## Examples

``` r
if (interactive()) {

library(shiny)
library(shinyWidgets)

ui <- fluidPage(

  verticalTabsetPanel(
    verticalTabPanel("blaa","foo"),
    verticalTabPanel("yarp","bar"),
    id="hippi"
  )
)

server <- function(input, output, session) {
  appendVerticalTab("hippi", verticalTabPanel("bipi","long"))
  removeVerticalTab("hippi", 1)
  appendVerticalTab("hippi", verticalTabPanel("howdy","fair"))
  reorderVerticalTabs("hippi", c(3,2,1))
}

# Run the application
shinyApp(ui = ui, server = server)

}
```
