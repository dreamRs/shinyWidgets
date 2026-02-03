# Vertical tab panel

Vertical tab panel

## Usage

``` r
verticalTabsetPanel(
  ...,
  selected = NULL,
  id = NULL,
  color = "#112446",
  contentWidth = 9,
  menuSide = "left"
)

verticalTabPanel(title, ..., value = title, icon = NULL, box_height = "160px")
```

## Arguments

- ...:

  For `verticalTabsetPanel`, `verticalTabPanel` to include, and for the
  later, UI elements.

- selected:

  The `value` (or, if none was supplied, the `title`) of the tab that
  should be selected by default. If `NULL`, the first tab will be
  selected.

- id:

  If provided, you can use `input$id` in your server logic to determine
  which of the current tabs is active. The value will correspond to the
  `value` argument that is passed to `verticalTabPanel`.

- color:

  Color for the tab panels.

- contentWidth:

  Width of the content panel (must be between 1 and 12), menu width will
  be `12 - contentWidth`.

- menuSide:

  Side for the menu: right or left.

- title:

  Display title for tab.

- value:

  Not used yet.

- icon:

  Optional icon to appear on the tab.

- box_height:

  Height for the title box.

## See also

[`updateVerticalTabsetPanel`](https://dreamrs.github.io/shinyWidgets/reference/updateVerticalTabsetPanel.md)
for updating selected tabs.

## Examples

``` r
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  theme = bslib::bs_theme(version = 5L),
  fluidRow(
    column(
      width = 10, offset = 1,
      tags$h2("Vertical tab panel example"),
      tags$p(
        "Active tab is:", uiOutput("active", container = tags$b)
      ),
      verticalTabsetPanel(
        id = "my_vertical_tab_panel",
        verticalTabPanel(
          title = "Title 1",
          icon = icon("house", "fa-2x"),
          "Content panel 1"
        ),
        verticalTabPanel(
          title = "Title 2",
          icon = icon("map", "fa-2x"),
          "Content panel 2"
        ),
        verticalTabPanel(
          title = "Title 3",
          icon = icon("rocket", "fa-2x"),
          "Content panel 3"
        )
      )
    )
  )
)

server <- function(input, output, session) {
  output$active <- renderUI(input$my_vertical_tab_panel)
}

if (interactive()) {
  shinyApp(ui, server)
}
```
