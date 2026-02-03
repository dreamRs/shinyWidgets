# Show a toast notification

Show a toast notification

## Usage

``` r
show_toast(
  title,
  text = NULL,
  type = c("default", "success", "error", "info", "warning", "question"),
  timer = 3000,
  timerProgressBar = TRUE,
  position = c("bottom-end", "top", "top-start", "top-end", "center", "center-start",
    "center-end", "bottom", "bottom-start"),
  width = NULL,
  session = shiny::getDefaultReactiveDomain()
)
```

## Arguments

- title:

  Title for the toast.

- text:

  Text for the toast.

- type:

  Type of the toast: `"default"`, `"success"`, `"error"`, `"info"`,
  `"warning"` or `"question"`.

- timer:

  Auto close timer of the modal. Set in ms (milliseconds).

- timerProgressBar:

  If set to true, the timer will have a progress bar at the bottom of a
  popup.

- position:

  Modal window position, can be `"top"`, `"top-start"`, `"top-end"`,
  `"center"`, `"center-start"`, `"center-end"`, `"bottom"`,
  `"bottom-start"`, or `"bottom-end"`.

- width:

  Modal window width, including paddings.

- session:

  The `session` object passed to function given to shinyServer.

## Value

No value.

## See also

[`show_alert()`](https://dreamrs.github.io/shinyWidgets/reference/sweetalert.md),
[`ask_confirmation()`](https://dreamrs.github.io/shinyWidgets/reference/sweetalert-confirmation.md),
[`closeSweetAlert()`](https://dreamrs.github.io/shinyWidgets/reference/closeSweetAlert.md).

## Examples

``` r
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h2("Sweet Alert Toast"),
  actionButton(
    inputId = "toast",
    label = "Show default toast"
  ),
  actionButton(
    inputId = "success",
    label = "Show success toast",
    icon = icon("check")
  ),
  actionButton(
    inputId = "error",
    label = "Show error toast",
    icon = icon("xmark")
  ),
  actionButton(
    inputId = "warning",
    label = "Show warning toast",
    icon = icon("triangle-exclamation")
  ),
  actionButton(
    inputId = "info",
    label = "Show info toast",
    icon = icon("info")
  )
)

server <- function(input, output, session) {

  observeEvent(input$toast, {
    show_toast(
      title = "Notification",
      text = "An imortant message"
    )
  })

  observeEvent(input$success, {
    show_toast(
      title = "Bravo",
      text = "Well done!",
      type = "success"
    )
  })

  observeEvent(input$error, {
    show_toast(
      title = "Ooops",
      text = "It's broken",
      type = "error",
      width = "800px",
      position = "bottom"
    )
  })

  observeEvent(input$warning, {
    show_toast(
      title = "Careful!",
      text = "Almost broken",
      type = "warning",
      position = "top-end"
    )
  })

  observeEvent(input$info, {
    show_toast(
      title = "Heads up",
      text = "Just a message",
      type = "info",
      position = "top-end"
    )
  })
}

if (interactive())
  shinyApp(ui, server)
```
