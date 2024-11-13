
library(shiny)
library(shinyWidgets)

parseValue <- TRUE

ui <- fluidPage(
  theme = bslib::bs_theme(5),
  tags$h2("Calendar Pro Input"),
  fluidRow(
    column(
      width = 6,
      calendarProInput(
        inputId = "cal1",
        label = "Date selection:",
        placeholder = "Select a date",
        width = "100%",
        parseValue = parseValue
      ),
      verbatimTextOutput("res1"),

      calendarProInput(
        inputId = "cal3",
        label = "Date selection (with default):",
        value = Sys.Date() + 2,
        placeholder = "Select a date",
        width = "100%",
        parseValue = parseValue
      ),
      verbatimTextOutput("res3"),

      calendarProInput(
        inputId = "cal5",
        label = "Month selection:",
        placeholder = "Select a month",
        type = "month",
        width = "100%",
        parseValue = parseValue
      ),
      verbatimTextOutput("res5"),

      calendarProInput(
        inputId = "cal7",
        label = "Year selection:",
        placeholder = "Select a year",
        # settings = list(selection = list(month = FALSE)),
        type = "year",
        width = "100%",
        parseValue = parseValue
      ),
      verbatimTextOutput("res7")
    ),
    column(
      width = 6,
      calendarProInput(
        inputId = "cal2",
        label = "Multiple date selection:",
        type = "multiple",
        placeholder = "Select multiple date ",
        width = "100%",
        parseValue = parseValue
      ),
      verbatimTextOutput("res2"),

      calendarProInput(
        inputId = "cal4",
        label = "Datetime selection:",
        placeholder = "Select date and time",
        time = 12,
        width = "100%",
        parseValue = parseValue
      ),
      verbatimTextOutput("res4"),

      calendarProInput(
        inputId = "cal6",
        label = "Datetime selection (with default):",
        value = Sys.Date(),
        time = 24,
        timeValue = "10:00",
        placeholder = "Select date and time",
        width = "100%",
        parseValue = parseValue,
        format = "YYYY-MM-DD HH:mm"
      ),
      verbatimTextOutput("res6")
    )
  )
)

server <- function(input, output, session) {

  output$res1 <- renderPrint(str(input$cal1))
  output$res2 <- renderPrint(str(input$cal2))
  output$res3 <- renderPrint(str(input$cal3))
  output$res4 <- renderPrint(str(input$cal4))
  output$res5 <- renderPrint(str(input$cal5))
  output$res6 <- renderPrint(str(input$cal6))
  output$res7 <- renderPrint(str(input$cal7))

}

if (interactive())
  shinyApp(ui, server)
