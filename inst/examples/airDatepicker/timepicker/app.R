

# timepicker examples --------------------------------------------------

library(shiny)
library(shinyWidgets)



# ui ----

ui <- fluidPage(
  tags$h2("Air datepicker with timepicker example"),
  tags$br(),

  fluidRow(

    column(
      width = 6,

      airDatepickerInput(
        inputId = "datetime",
        label = "Pick date and time:",
        timepicker = TRUE
      ),
      verbatimTextOutput(outputId = "res_datetime"),

      airDatepickerInput(
        inputId = "time",
        label = "Pick time:",
        timepicker = TRUE,
        onlyTimepicker = TRUE
      ),
      verbatimTextOutput(outputId = "res_time")

    ),

    column(
      width = 6,

      airDatepickerInput(
        inputId = "options",
        label = "With some options:",
        multiple = TRUE,
        value = as.POSIXct("2018-05-01 20:00:00"),
        timepicker = TRUE,
        timepickerOpts = timepickerOptions(
          dateTimeSeparator = " at ",
          minutesStep = 10,
          hoursStep = 2
        )
      ),
      verbatimTextOutput(outputId = "res_options"),

      airDatepickerInput(
        inputId = "french",
        label = "French locale:",
        value = "2018-05-01 20:00:00",
        timepicker = TRUE,
        language = "fr",
        timepickerOpts = timepickerOptions(
          dateTimeSeparator = " \u00e0 ",
          minutesStep = 10,
          hoursStep = 2
        )
      ),
      verbatimTextOutput(outputId = "res_french")

    )

  )
)

# server ----

server <- function(input, output, session) {

  output$res_datetime <- renderPrint( input$datetime )
  output$res_time <- renderPrint( input$time )
  output$res_options <- renderPrint( input$options )
  output$res_french <- renderPrint( input$french )

}

# app ----

shinyApp(ui = ui, server = server)

