# WinBox

A window manager with JavaScript library
[WinBox.js](https://nextapps-de.github.io/winbox/).

## Usage

``` r
WinBox(
  title,
  ui,
  options = wbOptions(),
  controls = wbControls(),
  id = NULL,
  padding = "5px 10px",
  auto_height = FALSE,
  auto_index = TRUE,
  session = shiny::getDefaultReactiveDomain()
)

closeWinBox(id, session = shiny::getDefaultReactiveDomain())

applyWinBox(id, method, ..., session = shiny::getDefaultReactiveDomain())
```

## Arguments

- title:

  Title for the window.

- ui:

  Content of the window.

- options:

  List of options, see
  [`wbOptions()`](https://dreamrs.github.io/shinyWidgets/reference/wbOptions.md).

- controls:

  List of controls, see
  [`wbControls()`](https://dreamrs.github.io/shinyWidgets/reference/wbControls.md).

- id:

  An unique identifier for the window, if a window with the same `id` is
  already open, it will be closed before opening the new one. When
  closing windows, use `id = NULL` to close last one opened.

- padding:

  Padding for the window content.

- auto_height:

  Automatically set height of the window according to content. Note that
  if content does not have a fix height it may not work properly.

- auto_index:

  Automatically set z-index property to show the winbox above all
  content, including modal windows.

- session:

  Shiny session.

- method:

  Method to apply on WinBox, see avaialable ones here :
  https://github.com/nextapps-de/winbox?tab=readme-ov-file#overview

- ...:

  Parameters for the method.

## Value

No value, a window is openned in the UI.

## Note

You need to include
[`html_dependency_winbox()`](https://dreamrs.github.io/shinyWidgets/reference/html_dependency_winbox.md)
in your UI definition for this function to work.

## Examples

``` r
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  html_dependency_winbox(),
  actionButton(inputId = "show", label = "Show WinBox"),
  verbatimTextOutput("res")
)

server <- function(input, output, session) {

  observeEvent(input$show, {
    WinBox(
      title = "WinBox window",
      ui = tagList(
        tags$h2("Hello from WinBox!"),
        "Text content of winbox.",
        selectInput("month", "Select a month:", month.name)
      )
    )
  })

  output$res <- renderPrint(input$month)

}

if (interactive())
  shinyApp(ui, server)


library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  html_dependency_winbox(),
  actionButton("minimize", "Minimize WinBox"),
  actionButton("maximize", "Maximize WinBox"),
  actionButton("setBackground", "Set background"),
  actionButton("setTitle", "Set title"),
  actionButton("resize", "Resize"),
  actionButton("move", "Move")
)

server <- function(input, output, session) {

  WinBox(
    id = "myWb",
    title = "WinBox",
    ui = tagList(
      tags$h3("Hello from WinBox!"),
      tags$p("Some content for the WinBox")
    )
  )

  observeEvent(input$minimize, {
    applyWinBox("myWb", "minimize")
  })

  observeEvent(input$maximize, {
    applyWinBox("myWb", "maximize")
  })

  observeEvent(input$setBackground, {
    applyWinBox("myWb", "setBackground", "#ff005d")
  })

  observeEvent(input$setTitle, {
    applyWinBox("myWb", "setTitle", "This is a new title")
  })

  observeEvent(input$resize, {
    applyWinBox("myWb", "resize", "50%", "50%")
  })

  observeEvent(input$move, {
    applyWinBox("myWb", "move", "center", "center")
  })

}

if (interactive())
  shinyApp(ui, server)
```
