if (interactive()) {
  library(shiny)
  library(shinyWidgets)

  ui <- fluidPage(
    tags$h2("Drop Menu interactions"),
    dropMenu(
      actionButton("myid", "See what's inside"),
      "Drop menu content",
      actionButton("hide", "Close menu"),
      position = "right middle"
    ),
    tags$br(),
    tags$p("Is drop menu opened?"),
    verbatimTextOutput("isOpen"),
    actionButton("show", "show menu"),
    tags$br(),
    tags$br(),
    dropMenu(
      actionButton("dontclose", "Only closeable from server"),
      "Drop menu content",
      actionButton("close", "Close menu"),
      position = "right middle",
      hideOnClick = FALSE
    )
  )

  server <- function(input, output, session) {

    output$isOpen <- renderPrint({
      input$myid_dropmenu
    })

    observeEvent(input$show, {
      showDropMenu("myid_dropmenu")
    })

    observeEvent(input$hide, {
      hideDropMenu("myid_dropmenu")
    })

    observeEvent(input$close, {
      hideDropMenu("dontclose_dropmenu")
    })

  }

  shinyApp(ui, server)
}
