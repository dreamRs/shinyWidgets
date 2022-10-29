library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h1("Pretty toggle update value"),
  br(),
  prettyToggle(
    inputId = "toggle1",
    label_on = "Checked!",
    label_off = "Unchecked..."
  ),
  verbatimTextOutput(outputId = "res1"),
  radioButtons(
    inputId = "update",
    label = "Value to set:",
    choices = c("FALSE", "TRUE")
  )
)

server <- function(input, output, session) {
  output$res1 <- renderPrint(input$toggle1)

  observeEvent(input$update, {
    updatePrettyToggle(
      session = session,
      inputId = "toggle1",
      value = as.logical(input$update)
    )
  })
}

if (interactive()) {
  shinyApp(ui, server)
}
