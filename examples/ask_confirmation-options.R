library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h1("Ask for confirmation"),
  actionButton(
    inputId = "launch1",
    label = "Launch confirmation dialog"
  ),
  verbatimTextOutput(outputId = "res1"),
  tags$br(),
  actionButton(
    inputId = "launch2",
    label = "Launch confirmation dialog (with normal mode)"
  ),
  verbatimTextOutput(outputId = "res2"),
  tags$br(),
  actionButton(
    inputId = "launch3",
    label = "Launch confirmation dialog (with HTML)"
  ),
  verbatimTextOutput(outputId = "res3")
)

server <- function(input, output, session) {

  observeEvent(input$launch1, {
    ask_confirmation(
      inputId = "myconfirmation1",
      type = "warning",
      title = "Want to confirm ?"
    )
  })
  output$res1 <- renderPrint(input$myconfirmation1)

  observeEvent(input$launch2, {
    ask_confirmation(
      inputId = "myconfirmation2",
      type = "warning",
      title = "Are you sure ??",
      btn_labels = c("Nope", "Yep"),
      btn_colors = c("#FE642E", "#04B404")
    )
  })
  output$res2 <- renderPrint(input$myconfirmation2)

  observeEvent(input$launch3, {
    ask_confirmation(
      inputId = "myconfirmation3",
      title = NULL,
      text = tags$b(
        icon("file"),
        "Do you really want to delete this file ?",
        style = "color: #FA5858;"
      ),
      btn_labels = c("Cancel", "Delete file"),
      btn_colors = c("#00BFFF", "#FE2E2E"),
      html = TRUE
    )
  })
  output$res3 <- renderPrint(input$myconfirmation3)

}

if (interactive())
  shinyApp(ui, server)
