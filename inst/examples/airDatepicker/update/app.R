

# timepicker examples --------------------------------------------------

library(shiny)
library(shinyWidgets)




# ui ----

ui <- fluidPage(
  tags$h2("Update airDatepickerInput"),
  tags$br(),

  fluidRow(

    column(
      width = 6,

      airDatepickerInput(
        inputId = "airup1",
        label = "Update by selecting a date below:"
      ),
      verbatimTextOutput(outputId = "res_airup1"),
      sliderInput(
        inputId = "update_airup1",
        label = "Choose a date to update air datepicker:",
        min = Sys.Date() - 7, value = Sys.Date(), max = Sys.Date() + 7
      ),

      tags$br(),

      airDatepickerInput(
        inputId = "airuplabel",
        label = "Update label:"
      ),
      verbatimTextOutput(outputId = "res_airuplabel"),
      textInput(
        inputId = "updatelabel",
        label = "Update label above"
      )

    ),

    column(
      width = 6,

      airDatepickerInput(
        inputId = "airclear",
        label = "Clear all dates selected:",
        multiple = TRUE,
        value = Sys.Date() + 1:7
      ),
      verbatimTextOutput(outputId = "res_airclear"),
      actionButton(
        inputId = "upclear", label = "Clear dates"
      )

    )

  )
)

# server ----

server <- function(input, output, session) {

  # Update selected date
  output$res_airup1 <- renderPrint( str(input$airup1) )
  observeEvent(input$update_airup1, {
    updateAirDateInput(
      session = session,
      inputId = "airup1",
      value = input$update_airup1
    )
  })

  # Clear all dates selected
  output$res_airclear <- renderPrint( str(input$airclear) )
  observeEvent(input$upclear, {
    updateAirDateInput(
      session = session,
      inputId = "airclear",
      clear = TRUE
    )
  })

  observeEvent(input$updatelabel, {
    updateAirDateInput(
      session = session,
      inputId = "airuplabel",
      label = input$updatelabel
    )
  }, ignoreInit = TRUE)

}

# app ----

shinyApp(ui = ui, server = server)

