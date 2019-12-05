if (interactive()) {

  library(shiny)
  library(shinyWidgets)

  ui <- fluidPage(

    useSweetAlert("borderless"),

    tags$h2("Sweet Alert examples (with custom theme)"),
    actionButton(
      inputId = "success",
      label = "Launch a success sweet alert",
      icon = icon("check")
    ),
    actionButton(
      inputId = "error",
      label = "Launch an error sweet alert",
      icon = icon("remove")
    ),
    actionButton(
      inputId = "sw_html",
      label = "Sweet alert with HTML",
      icon = icon("thumbs-up")
    )
  )

  server <- function(input, output, session) {

    observeEvent(input$success, {
      sendSweetAlert(
        session = session,
        title = "Success !!",
        text = "All in order",
        type = "success"
      )
    })

    observeEvent(input$error, {
      sendSweetAlert(
        session = session,
        title = "Error !!",
        text = "It's broken...",
        type = "error"
      )
    })

    observeEvent(input$sw_html, {
      sendSweetAlert(
        session = session,
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

  shinyApp(ui, server)
}
