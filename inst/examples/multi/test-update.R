library("shiny")
library("shinyWidgets")

ui <- fluidPage(
  multiInput(
    inputId = "id", label = "Fruits :",
    choices = c("Banana", "Blueberry", "Cherry", "Coconut", "Grapefruit",
                "Kiwi", "Lemon", "Lime", "Mango", "Orange", "Papaya"),
    selected = "Banana", width = "350px"
  ),
  verbatimTextOutput(outputId = "res"),
  radioButtons(inputId = "up", label = "Update", choices = c("none", "random", "all"))
)

server <- function(input, output, session) {
  output$res <- renderPrint({
    input$id
  })
  observeEvent(input$up, {
    choices <- c("Banana", "Blueberry", "Cherry", "Coconut", "Grapefruit",
                 "Kiwi", "Lemon", "Lime", "Mango", "Orange", "Papaya")
    if (input$up == "none") {
      shinyWidgets:::updateMultiInput(session = session, inputId = "id", selected = character(0))
    } else if (input$up == "random") {
      shinyWidgets:::updateMultiInput(session = session, inputId = "id", selected = sample(choices, sample(1:2)))
    } else if (input$up == "all") {
      shinyWidgets:::updateMultiInput(session = session, inputId = "id", selected = choices)
    }
  }, ignoreInit = TRUE)
}

shinyApp(ui = ui, server = server)
