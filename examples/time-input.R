
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h2("Time Input"),
  fluidRow(
    column(
      width = 6,
      timeInput(
        inputId = "time1",
        label = "Time:"
      ),
      verbatimTextOutput("res1"),
      timeInput(
        inputId = "time2",
        label = "Time (default value):",
        value = "09:30"
      ),
      verbatimTextOutput("res2"),
      timeInput(
        inputId = "time3",
        label = "Time (with seconds):",
        step = 1
      ),
      verbatimTextOutput("res3")
    ),
    column(
      width = 6,
      timeInput(inputId = "time4", label = "Time:"),
      verbatimTextOutput("res4"),
      numericInput("up_h", "Update hour;", value = 0),
      numericInput("up_m", "Update minute;", value = 0)
    )
  )
)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$time1)
  output$res2 <- renderPrint(input$time2)
  output$res3 <- renderPrint(input$time3)
  output$res4 <- renderPrint(input$time4)

  observe({
    updateTimeInput(
      inputId = "time4",
      value = paste(
        # Hour and minute need to be a field of minimum width 2,
        # with zero-padding on the left
        sprintf("%02d", input$up_h),
        sprintf("%02d", input$up_m),
        sep = ":"
      )
    )
  })
}

if (interactive())
  shinyApp(ui, server)
