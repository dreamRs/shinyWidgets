
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  theme = bslib::bs_theme(5),
  tags$h2("Calendar Pro Input"),
  fluidRow(
    column(
      width = 6,
      calendarProInput(
        inputId = "cal1",
        label = "Calendar default:",
        placeholder = "Select a date",
        width = "100%"
      ),
      verbatimTextOutput("res1"),
      calendarProInput(
        inputId = "cal3",
        label = "Calendar with initial value:",
        value = Sys.Date() + 1,
        width = "100%"
      ),
      verbatimTextOutput("res3"),
      calendarProInput(
        inputId = "cal5",
        label = "Calendar without input field:",
        input = FALSE,
        width = "100%"
      ),
      verbatimTextOutput("res5")
    ),
    column(
      width = 6,
      calendarProInput(
        inputId = "cal2",
        label = "Calendar with multiple selection:",
        type = "multiple",
        placeholder = "Select multiple dates",
        width = "100%"
      ),
      verbatimTextOutput("res2"),
      calendarProInput(
        inputId = "cal4",
        label = "Calendar with range selection:",
        type = "multiple",
        range = TRUE,
        width = "100%"
      ),
      verbatimTextOutput("res4"),
      calendarProInput(
        inputId = "cal6",
        label = "Calendar  without input field:",
        type = "multiple",
        range = TRUE,
        months = 3,
        input = FALSE,
        width = "100%"
      ),
      verbatimTextOutput("res6")
    )
  )
)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$cal1)
  output$res2 <- renderPrint(input$cal2)
  output$res3 <- renderPrint(input$cal3)
  output$res4 <- renderPrint(input$cal4)
  output$res5 <- renderPrint(input$cal5)
  output$res6 <- renderPrint(input$cal6)

}

if (interactive())
  shinyApp(ui, server)
