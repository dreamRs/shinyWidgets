# Update selected vertical tab

Update selected vertical tab

## Usage

``` r
updateVerticalTabsetPanel(session, inputId, selected = NULL)
```

## Arguments

- session:

  The `session` object passed to function given to `shinyServer.`

- inputId:

  The id of the `verticalTabsetPanel` object.

- selected:

  The name of the tab to make active.

## See also

[`verticalTabsetPanel`](https://dreamrs.github.io/shinyWidgets/reference/vertical-tab.md)

## Examples

``` r
if (interactive()) {

library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  fluidRow(
    column(
      width = 10, offset = 1,
      tags$h2("Update vertical tab panel example:"),
      verbatimTextOutput("res"),
      radioButtons(
        inputId = "update", label = "Update selected:",
        choices = c("Title 1", "Title 2", "Title 3"),
        inline = TRUE
      ),
      verticalTabsetPanel(
        id = "TABS",
        verticalTabPanel(
          title = "Title 1", icon = icon("house", "fa-2x"),
          "Content panel 1"
        ),
        verticalTabPanel(
          title = "Title 2", icon = icon("map", "fa-2x"),
          "Content panel 2"
        ),
        verticalTabPanel(
          title = "Title 3", icon = icon("rocket", "fa-2x"),
          "Content panel 3"
        )
      )
    )
  )
)

server <- function(input, output, session) {
  output$res <- renderPrint(input$TABS)
  observeEvent(input$update, {
    shinyWidgets:::updateVerticalTabsetPanel(
      session = session,
      inputId = "TABS",
      selected = input$update
    )
  }, ignoreInit = TRUE)
}

shinyApp(ui, server)

}
```
