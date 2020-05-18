library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h1("Pretty switch update value"),
  br(),

  prettySwitch(inputId = "switch1", label = "Update me !"),
  verbatimTextOutput(outputId = "res1"),
  radioButtons(
    inputId = "update",
    label = "Value to set:",
    choices = c("FALSE", "TRUE")
  )

)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$switch1)

  observeEvent(input$update, {
    updatePrettySwitch(
      session = session,
      inputId = "switch1",
      value = as.logical(input$update)
    )
  })

}

if (interactive())
  shinyApp(ui, server)
