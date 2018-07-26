library("shiny")
library("shinyWidgets")

ui <- fluidPage(
  fluidRow(
    column(
      width = 6,
      multiInput(
        inputId = "id", label = "Fruits :",
        choices = c("Banana", "Blueberry", "Cherry", "Coconut", "Grapefruit",
                    "Kiwi", "Lemon", "Lime", "Mango", "Orange", "Papaya"),
        options = list(search_placeholder = "Select your favorites:"),
        selected = "Banana", width = "350px"
      ),
      verbatimTextOutput(outputId = "res"),
      radioButtons(inputId = "up", label = "Update", choices = c("none", "random", "all"))
    ),
    column(
      width = 6,
      multiInput(
        inputId = "id2", label = "Fruits :",
        choices = c("Banana", "Blueberry", "Cherry", "Coconut", "Grapefruit",
                    "Kiwi", "Lemon", "Lime", "Mango", "Orange", "Papaya"),
        options = list(enable_search = FALSE),
        selected = "Banana", width = "350px"
      ),
      verbatimTextOutput(outputId = "res2"),
      radioButtons(inputId = "up2", label = "Update", choices = c("none", "random", "all"))
    )
  )
)

server <- function(input, output, session) {
  output$res <- renderPrint({
    input$id
  })
  observeEvent(input$up, {
    choices <- c("Banana", "Blueberry", "Cherry", "Coconut", "Grapefruit",
                 "Kiwi", "Lemon", "Lime", "Mango", "Orange", "Papaya")
    if (input$up == "none") {
      shinyWidgets:::updateMultiInput(session = session, inputId = "id", choices = choices, selected = character(0))
    } else if (input$up == "random") {
      shinyWidgets:::updateMultiInput(session = session, inputId = "id", choices = choices, selected = sample(choices, sample(1:2)))
    } else if (input$up == "all") {
      shinyWidgets:::updateMultiInput(session = session, inputId = "id", choices = choices, selected = choices)
    }
  }, ignoreInit = TRUE)

  output$res2 <- renderPrint({
    input$id2
  })
  observeEvent(input$up2, {
    choices <- c("Banana", "Blueberry", "Cherry", "Coconut", "Grapefruit",
                 "Kiwi", "Lemon", "Lime", "Mango", "Orange", "Papaya")
    if (input$up2 == "none") {
      shinyWidgets:::updateMultiInput(session = session, inputId = "id2", choices = choices, selected = character(0))
    } else if (input$up2 == "random") {
      shinyWidgets:::updateMultiInput(session = session, inputId = "id2", choices = choices, selected = sample(choices, sample(1:2)))
    } else if (input$up2 == "all") {
      shinyWidgets:::updateMultiInput(session = session, inputId = "id2", choices = choices, selected = choices)
    }
  }, ignoreInit = TRUE)
}

shinyApp(ui = ui, server = server)
