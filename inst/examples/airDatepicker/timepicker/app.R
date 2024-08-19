

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
        inputId = "datetime_tz",
        label = "Pick date and time (specific timezone:",
        timepicker = TRUE,
        tz = "UTC"
      ),
      verbatimTextOutput(outputId = "res_datetime_tz"),

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
        label = sprintf(
          "With default value (%s) and options:",
          as.POSIXct("2018-05-01 20:00:00")
        ),
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
  output$res_datetime_tz <- renderPrint( input$datetime_tz )
  output$res_time <- renderPrint( input$time )
  output$res_options <- renderPrint( input$options )
  output$res_french <- renderPrint( input$french )

}

# app ----

shinyApp(ui = ui, server = server)

