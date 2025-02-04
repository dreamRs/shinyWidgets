
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
        label = "Multiple date selection:",
        mode = "multiple",
        placeholder = "Select multiple date ",
        width = "100%",
        parseValue = parseValue
      ),
      verbatimTextOutput("res5"),

      calendarProInput(
        inputId = "cal7",
        label = "Range date selection:",
        mode = "multiple-ranged",
        placeholder = "Select range of dates ",
        width = "100%",
        parseValue = parseValue
      ),
      verbatimTextOutput("res7"),

      calendarProInput(
        inputId = "cal9",
        label = "Month selection:",
        placeholder = "Select a month",
        type = "month",
        # selectedYear = 2022, # to change default year
        width = "100%",
        parseValue = parseValue,
        format = "%Y-%m"
      ),
      verbatimTextOutput("res9"),

      calendarProInput(
        inputId = "cal11",
        label = "Year selection:",
        placeholder = "Select a year",
        type = "year",
        selectionMonthsMode = FALSE,
        selectedMonth = 0,
        width = "100%",
        parseValue = parseValue,
        format = "%Y"
      ),
      verbatimTextOutput("res11")
    ),
    column(
      width = 6,

      calendarProInput(
        inputId = "cal2",
        label = "Datetime selection:",
        placeholder = "Select date and time",
        selectionTimeMode = 12,
        width = "100%",
        parseValue = parseValue,
        format = "%Y-%m-%d %H:%M"
      ),
      verbatimTextOutput("res2"),

      calendarProInput(
        inputId = "cal4",
        label = "Datetime selection (with default as POSIXct):",
        value = as.POSIXct(paste(Sys.Date(), "9:00")),
        selectionTimeMode = 24,
        placeholder = "Select date and time",
        width = "100%",
        parseValue = parseValue,
        format = "%Y-%m-%d %H:%M"
      ),
      verbatimTextOutput("res4"),

      calendarProInput(
        inputId = "cal6",
        label = "Datetime selection (with selectedTime default):",
        value = Sys.Date(),
        selectionTimeMode = 24,
        selectedTime = "10:00",
        placeholder = "Select date and time",
        width = "100%",
        parseValue = parseValue,
        format = "%Y-%m-%d %H:%M"
      ),
      verbatimTextOutput("res6"),

      calendarProInput(
        inputId = "cal8",
        label = "Datetime multiple selection (with default):",
        value = as.POSIXct(paste(Sys.Date(), "9:00")),
        selectionTimeMode = 24,
        mode = "multiple",
        placeholder = "Select date and time",
        width = "100%",
        parseValue = parseValue,
        format = "%Y-%m-%d %H:%M"
      ),
      verbatimTextOutput("res8"),

      calendarProInput(
        inputId = "cal10",
        label = "Datetime range selection (with default):",
        value = as.POSIXct(paste(Sys.Date(), "9:00")),
        selectionTimeMode = 24,
        mode = "multiple-ranged",
        placeholder = "Select date and time",
        width = "100%",
        parseValue = parseValue,
        format = "%Y-%m-%d %H:%M"
      ),
      verbatimTextOutput("res10")
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
  output$res8 <- renderPrint(str(input$cal8))
  output$res9 <- renderPrint(str(input$cal9))
  output$res10 <- renderPrint(str(input$cal10))
  output$res11 <- renderPrint(str(input$cal11))

}

if (interactive())
  shinyApp(ui, server)
