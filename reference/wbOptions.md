# WinBox Options

WinBox Options

## Usage

``` r
wbOptions(
  width = NULL,
  height = NULL,
  minwidth = NULL,
  minheight = NULL,
  x = NULL,
  y = NULL,
  max = NULL,
  min = NULL,
  top = NULL,
  right = NULL,
  bottom = NULL,
  left = NULL,
  background = NULL,
  border = NULL,
  modal = NULL,
  index = NULL,
  ...
)
```

## Arguments

- width, height:

  Set the initial width/height of the window (supports units "px" and
  "%").

- minwidth, minheight:

  Set the minimal width/height of the window (supports units "px" and
  "%").

- x, y:

  Set the initial position of the window (supports: "right" for x-axis,
  "bottom" for y-axis, "center" for both, units "px" and "%" for both).

- max, min:

  Automatically toggles the window into maximized / minimized state when
  created.

- top, right, bottom, left:

  Set or limit the viewport of the window's available area (supports
  units "px" and "%").

- background:

  Set the background of the window (supports all CSS styles which are
  also supported by the style-attribute "background", e.g. colors,
  transparent colors, hsl, gradients, background images).

- border:

  Set the border width of the window (supports all css units, like px,
  %, em, rem, vh, vmax).

- modal:

  Shows the window as modal.

- index:

  Set the initial z-index of the window to this value (could be
  increased automatically when unfocused/focused).

- ...:

  Other options, see
  https://github.com/nextapps-de/winbox?tab=readme-ov-file#options.

## Value

A `list` of options to use in
[`WinBox()`](https://dreamrs.github.io/shinyWidgets/reference/WinBox.md).

## Examples

``` r
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  html_dependency_winbox(),
  actionButton(inputId = "show1", label = "Show WinBox"),
  actionButton(inputId = "show2", label = "Show WinBox as modal")
)

server <- function(input, output, session) {

  observeEvent(input$show1, {
    WinBox(
      title = "Custom background color and border",
      ui = tagList(
        tags$h2("Hello from WinBox!"),
        "Text content of winbox."
      ),
      options = wbOptions(
        background = "#112446",
        border = "0.5em",
        x = "center",
        y = "center",
        width = "50%",
        height = "50%"
      )
    )
  })

  observeEvent(input$show2, {
    WinBox(
      title = "WinBox as modal",
      ui = tagList(
        tags$h2("Hello from WinBox!"),
        "Text content of winbox."
      ),
      options = wbOptions(modal = TRUE)
    )
  })

}

if (interactive())
  shinyApp(ui, server)
```
