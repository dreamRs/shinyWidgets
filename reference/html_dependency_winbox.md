# Winbox JavaScript Dependencies

Include dependencies, place anywhere in the shiny UI.

## Usage

``` r
html_dependency_winbox(
  css_rules = "body{min-height:100vh}.winbox.modal{display:block;overflow:unset}"
)
```

## Arguments

- css_rules:

  CSS rules to be included in a `style` tag in the document head. By
  default it set a `min-height` to the body element.

## Examples

``` r
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  html_dependency_winbox()
)

server <- function(input, output, session) {

  WinBox(
    title = "WinBox",
    ui = tagList(
      tags$h3("Hello from WinBox!")
    )
  )

}

if (interactive())
  shinyApp(ui, server)
```
