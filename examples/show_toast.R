
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
