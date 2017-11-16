
library("shiny")
library("shinyWidgets")


ui <- fluidPage(
  tags$h1("Update", tags$code("switchInput")),
  br(),
  fluidRow(

    column(
      width = 4,
      panel(
        switchInput(inputId = "switch1"),
        verbatimTextOutput(outputId = "resup1"),
        tags$div(
          class = "btn-group",
          actionButton(inputId = "updatevaluetrue", label = "Set to TRUE"),
          actionButton(inputId = "updatevaluefalse", label = "Set to FALSE")
        ),
        heading = "Update value"
      )
    ),

    column(
      width = 4,
      panel(
        switchInput(inputId = "switch2", label = "My label"),
        verbatimTextOutput(outputId = "resup2"),
        textInput(inputId = "updatelabeltext", label = "Update label:"),
        heading = "Update label"
      )
    ),

    column(
      width = 4,
      panel(
        switchInput(inputId = "switch3", onLabel = "Yeaah", offLabel = "Noooo"),
        verbatimTextOutput(outputId = "resup3"),
        fluidRow(
          column(
            width = 6,
            textInput(inputId = "updateonLabel", label = "Update onLabel:")
          ),
          column(
            width = 6,
            textInput(inputId = "updateoffLabel", label = "Update offLabel:")
          )
        ),
        heading = "Update onLabel & offLabel"
      )
    )
  ),

  fluidRow(

    column(
      width = 4,
      panel(
        switchInput(inputId = "switch4"),
        verbatimTextOutput(outputId = "resup4"),
        fluidRow(
          column(
            width = 6,
            pickerInput(inputId = "updateonStatus", label = "Update onStatus:",
                        choices = c("default", "primary", "success", "info", "warning", "danger"))
          ),
          column(
            width = 6,
            pickerInput(inputId = "updateoffStatus", label = "Update offStatus:",
                        choices = c("default", "primary", "success", "info", "warning", "danger"))
          )
        ),
        heading = "Update onStatus & offStatusr"
      )
    ),

    column(
      width = 4,
      panel(
        switchInput(inputId = "switch5"),
        verbatimTextOutput(outputId = "resup5"),
        checkboxInput(inputId = "disabled", label = "Disabled", value = FALSE),
        heading = "Disabled"
      )
    )

  )

)

server <- function(input, output, session) {

  # Update value
  observeEvent(input$updatevaluetrue, {
    updateSwitchInput(session = session, inputId = "switch1", value = TRUE)
  })
  observeEvent(input$updatevaluefalse, {
    updateSwitchInput(session = session, inputId = "switch1", value = FALSE)
  })
  output$resup1 <- renderPrint({
    input$switch1
  })


  # Update label
  observeEvent(input$updatelabeltext, {
    updateSwitchInput(session = session, inputId = "switch2", label = input$updatelabeltext)
  }, ignoreInit = TRUE)
  output$resup2 <- renderPrint({
    input$switch2
  })


  # Update onLabel & offLabel
  observeEvent(input$updateonLabel, {
    updateSwitchInput(session = session, inputId = "switch3", onLabel = input$updateonLabel)
  }, ignoreInit = TRUE)
  observeEvent(input$updateoffLabel, {
    updateSwitchInput(session = session, inputId = "switch3", offLabel = input$updateoffLabel)
  }, ignoreInit = TRUE)
  output$resup3 <- renderPrint({
    input$switch3
  })


  # Update onStatus & offStatus
  observeEvent(input$updateonStatus, {
    updateSwitchInput(session = session, inputId = "switch4", onStatus = input$updateonStatus)
  }, ignoreInit = TRUE)
  observeEvent(input$updateoffStatus, {
    updateSwitchInput(session = session, inputId = "switch4", offStatus = input$updateoffStatus)
  }, ignoreInit = TRUE)
  output$resup4 <- renderPrint({
    input$switch4
  })


  # Disabled
  observeEvent(input$disabled, {
    updateSwitchInput(session = session, inputId = "switch5", disabled = input$disabled)
  }, ignoreInit = TRUE)
  output$resup5 <- renderPrint({
    input$switch5
  })

}

shinyApp(ui = ui, server = server)
