
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  theme = bslib::bs_theme(5),
  tags$h2("Calendar Pro Input: disable/enable days"),
  fluidRow(
    column(
      width = 6,
      calendarProInput(
        inputId = "cal1",
        label = "Disable past:",
        placeholder = "Select a date",
        disablePast = TRUE,
        width = "100%"
      ),
      verbatimTextOutput("res1"),
      calendarProInput(
        inputId = "cal3",
        label = "Disable week-ends:",
        disableWeekday = c(0, 6),
        width = "100%"
      ),
      verbatimTextOutput("res3"),
      calendarProInput(
        inputId = "cal5",
        label = "Disable wednesdays:",
        disableWeekday = 3,
        width = "100%"
      ),
      verbatimTextOutput("res5"),
      calendarProInput(
        inputId = "cal7",
        label = "Set range:",
        placeholder = "Select a date",
        min = Sys.Date() - 14,
        max = Sys.Date() + 7,
        width = "100%"
      ),
      verbatimTextOutput("res7")
    ),
    column(
      width = 6,
      calendarProInput(
        inputId = "cal2",
        label = "Disable select range with gaps (cannot select range with today included):",
        type = "range",
        disableGaps = TRUE,
        disabled = Sys.Date(),
        positionToInput = c("bottom", "left"),
        width = "100%"
      ),
      verbatimTextOutput("res2"),
      calendarProInput(
        inputId = "cal4",
        label = "Disable days:",
        disabled = c(Sys.Date() + c(-5, -2, 3, 6, 7, 9, 14)),
        positionToInput = c("bottom", "left"),
        width = "100%"
      ),
      verbatimTextOutput("res4"),
      calendarProInput(
        inputId = "cal6",
        label = "Disable range of days (today -/+ 3):",
        disabled = paste(Sys.Date() - 3, Sys.Date() + 3, sep = ":"),
        positionToInput = c("bottom", "left"),
        width = "100%"
      ),
      verbatimTextOutput("res6"),
      calendarProInput(
        inputId = "cal8",
        label = "Enable specifics days:",
        disableAllDays = TRUE,
        enabled = c(Sys.Date() + c(-5, -2, 3, 6, 7, 9, 14)),
        positionToInput = c("bottom", "left"),
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
