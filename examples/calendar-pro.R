
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
        format = "%d/%m/%Y",
        value = Sys.Date() + 1,
        width = "100%"
      ),
      verbatimTextOutput("res3"),
      calendarProInput(
        inputId = "cal5",
        label = "Calendar without input field:",
        inputMode = FALSE,
        width = "300px"
      ),
      verbatimTextOutput("res5"),
      calendarProInput(
        inputId = "cal7",
        label = "Calendar with week numbers:",
        placeholder = "Select a date",
        enableWeekNumbers = TRUE,
        width = "100%"
      ),
      verbatimTextOutput("res7")
    ),
    column(
      width = 6,
      calendarProInput(
        inputId = "cal2",
        label = "Calendar with multiple selection:",
        mode = "multiple",
        placeholder = "Select multiple dates",
        width = "100%"
      ),
      verbatimTextOutput("res2"),
      calendarProInput(
        inputId = "cal4",
        label = "Calendar with range selection:",
        mode = "multiple-ranged",
        width = "100%"
      ),
      verbatimTextOutput("res4"),
      calendarProInput(
        inputId = "cal6",
        label = "Calendar (range) without input field:",
        mode = "multiple-ranged",
        type = "multiple",
        displayMonthsCount = 2,
        inputMode = FALSE,
        width = "100%"
      ),
      verbatimTextOutput("res6"),
      calendarProInput(
        inputId = "cal8",
        label = "Calendar select week:",
        mode = "multiple-ranged",
        enableWeekNumbers = TRUE,
        selectWeekNumbers = TRUE,
        width = "100%"
      ),
      verbatimTextOutput("res8")
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
  output$res7 <- renderPrint(input$cal7)
  output$res8 <- renderPrint(input$cal8)

}

if (interactive())
  shinyApp(ui, server)
