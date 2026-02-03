# WinBox controls

WinBox controls

## Usage

``` r
wbControls(
  animation = TRUE,
  shadow = TRUE,
  header = TRUE,
  min = TRUE,
  max = TRUE,
  full = FALSE,
  close = TRUE,
  resize = TRUE,
  move = TRUE
)
```

## Arguments

- animation:

  If `FALSE`, disables the windows transition animation.

- shadow:

  If `FALSE`, disables the windows drop shadow.

- header:

  If `FALSE`, hide the window header incl. title and toolbar.

- min:

  If `FALSE`, hide the minimize icon.

- max:

  If `FALSE`, hide the maximize icon.

- full:

  If `FALSE`, hide the fullscreen icon.

- close:

  If `FALSE`, hide the close icon.

- resize:

  If `FALSE`, disables the window resizing capability.

- move:

  If `FALSE`, disables the window moving capability.

## Value

A `list` of controls to use in
[`WinBox()`](https://dreamrs.github.io/shinyWidgets/reference/WinBox.md).

## Examples

``` r
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  html_dependency_winbox(),
  actionButton(inputId = "show", label = "Show WinBox")
)

server <- function(input, output, session) {

  observeEvent(input$show, {
    WinBox(
      title = "Custom controls",
      ui = tagList(
        tags$h2("Hello from WinBox!"),
        "Text content of winbox."
      ),
      controls = wbControls(
        min = FALSE,
        max = FALSE,
        resize = FALSE
      )
    )
  })

}

if (interactive())
  shinyApp(ui, server)
```
