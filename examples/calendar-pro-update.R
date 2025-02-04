
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  theme = bslib::bs_theme(5),
  tags$h2("Calendar Pro Input: update from server"),
  fluidRow(
    column(
      width = 6,
      calendarProInput(
        inputId = "calendar",
        label = "Select a date:",
        placeholder = "Select a date",
        width = "100%"
      ),
      verbatimTextOutput("res1"),
      textInput(
        inputId = "label",
        label = "Update label:"
      ),
      actionButton(
        inputId = "today",
        label = "Set value as today"
      ),
      actionButton(
        inputId = "today3",
        label = "Set value as today + 3"
      ),
      radioButtons(
        inputId = "mode",
        label = "Update mode:",
        choices = c("single", "multiple", "multiple-ranged"),
        inline = TRUE
      )
    ),
    column(
      width = 6
    )
  )
)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$calendar)

  observeEvent(input$label, {
    if (isTruthy(input$label)) {
      updateCalendarPro(inputId = "calendar", label = input$label)
    }
  })

  observeEvent(input$today, {
    updateCalendarPro(inputId = "calendar", value = Sys.Date())
  })

  observeEvent(input$today3, {
    updateCalendarPro(inputId = "calendar", value = Sys.Date() + 3)
  })

  observeEvent(input$mode, {
    updateCalendarPro(inputId = "calendar", selectionDatesMode = input$mode)
  }, ignoreInit = TRUE)

}

if (interactive())
  shinyApp(ui, server)
