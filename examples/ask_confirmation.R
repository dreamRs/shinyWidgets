library(shiny)
library(shinyWidgets)


ui <- fluidPage(
  tags$h1("Ask the user for confirmation"),
  actionButton(
    inputId = "launch",
    label = "Ask for confirmation"
  ),
  verbatimTextOutput(outputId = "res"),
  uiOutput(outputId = "count")
)

server <- function(input, output, session) {

  # Launch sweet alert confirmation
  observeEvent(input$launch, {
    ask_confirmation(
      inputId = "myconfirmation",
      title = "Want to confirm ?"
    )
  })

  # raw output
  output$res <- renderPrint(input$myconfirmation)

  # count click
  true <- reactiveVal(0)
  false <- reactiveVal(0)
  observeEvent(input$myconfirmation, {
    if (isTRUE(input$myconfirmation)) {
      x <- true() + 1
      true(x)
    } else {
      x <- false() + 1
      false(x)
    }
  }, ignoreNULL = TRUE)

  output$count <- renderUI({
    tags$span(
      "Confirm:", tags$b(true()),
      tags$br(),
      "Cancel:", tags$b(false())
    )
  })
}

if (interactive())
  shinyApp(ui, server)

