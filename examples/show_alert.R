library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h2("Sweet Alert examples"),
  actionButton(
    inputId = "success",
    label = "Launch a success sweet alert",
    icon = icon("check")
  ),
  actionButton(
    inputId = "error",
    label = "Launch an error sweet alert",
    icon = icon("xmark")
  ),
  actionButton(
    inputId = "sw_html",
    label = "Sweet alert with HTML",
    icon = icon("thumbs-up")
  )
)

server <- function(input, output, session) {

  observeEvent(input$success, {
    show_alert(
      title = "Success !!",
      text = "All in order",
      type = "success"
    )
  })

  observeEvent(input$error, {
    show_alert(
      title = "Error !!",
      text = "It's broken...",
      type = "error"
    )
  })

  observeEvent(input$sw_html, {
    show_alert(
      title = NULL,
      text = tags$span(
        tags$h3("With HTML tags",
                style = "color: steelblue;"),
        "In", tags$b("bold"), "and", tags$em("italic"),
        tags$br(),
        "and",
        tags$br(),
        "line",
        tags$br(),
        "breaks",
        tags$br(),
        "and an icon", icon("thumbs-up")
      ),
      html = TRUE
    )
  })

}

if (interactive())
  shinyApp(ui, server)
