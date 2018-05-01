

#  ------------------------------------------------------------------------
#
# Title : noUiSlider in Shiny
#    By : VP
#  Date : 2018-02-22
#
#  ------------------------------------------------------------------------



# app ---------------------------------------------------------------------


ui <- fluidPage(
  tags$h3("Update method"),
  tags$br(),

  fluidRow(

    column(
      width = 6,
      panel(
        status = "danger", heading = "Update single slider",
        noUiSliderInput(
          inputId = "to_update",
          label = "Slider update:",
          min = 0, max = 1000,
          value = 50, step = 50,
          colo = "#F2DEDE"
        ),
        verbatimTextOutput(outputId = "res_updated"),
        sliderInput(
          inputId = "update",
          label = "Update value",
          min = 0, max = 1000,
          step = 50, value = 50
        )
      ),

      panel(
        status = "danger", heading = "Update range slider",
        noUiSliderInput(
          inputId = "to_update_range",
          label = "Slider update:",
          min = 0, max = 1000,
          value = c(50, 200), step = 50,
          colo = "#F2DEDE"
        ),
        verbatimTextOutput(outputId = "res_updated_range"),
        sliderInput(
          inputId = "update_range",
          label = "Update value",
          min = 0, max = 1000,
          step = 50, value = c(50, 200)
        )
      )

    ),

    column(
      width = 6,

      panel(
        status = "danger", heading = "Update min/max",
        noUiSliderInput(
          inputId = "to_update_minmax",
          label = "Slider disable:",
          min = 0, max = 100, value = 50,
          colo = "#F2DEDE"
        ),
        verbatimTextOutput(outputId = "res_update_minmax"),
        actionButton(inputId = "minmax_0_100", label = "Set min=0 & max=100"),
        actionButton(inputId = "minmax_1000_5000", label = "Set min=1000 & max=5000")
      ),

      panel(
        status = "danger", heading = "Disable",
        noUiSliderInput(
          inputId = "to_disable",
          label = "Slider disable:",
          min = 0, max = 1000, value = 500,
          colo = "#F2DEDE"
        ),
        verbatimTextOutput(outputId = "res_disabled"),
        checkboxInput(
          inputId = "disable",
          label = "Disable slider",
          value = FALSE
        )
      )
    )

  )

)

server <- function(input, output, session) {

  output$res_updated <- renderPrint(input$to_update)
  observeEvent(input$update, {
    updateNoUiSliderInput(session, "to_update", input$update)
  }, ignoreInit = TRUE)

  output$res_updated_range <- renderPrint(input$to_update_range)
  observeEvent(input$update_range, {
    updateNoUiSliderInput(session, "to_update_range", input$update_range)
  }, ignoreInit = TRUE)


  output$res_update_minmax <- renderPrint(input$to_update_minmax)
  observeEvent(input$minmax_0_100, {
    updateNoUiSliderInput(
      session = session,
      inputId = "to_update_minmax",
      range = c(0, 100)
    )
  })
  observeEvent(input$minmax_1000_5000, {
    updateNoUiSliderInput(
      session = session,
      inputId = "to_update_minmax",
      range = c(1000, 5000)
    )
  })

  output$res_disabled <- renderPrint(input$to_disable)
  observeEvent(input$disable, {
    updateNoUiSliderInput(
      session = session,
      inputId = "to_disable",
      disable = input$disable
    )
  })

}

shinyApp(ui, server)
