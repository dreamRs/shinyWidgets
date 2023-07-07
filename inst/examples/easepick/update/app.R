
library(shiny)
library(htmltools)


ui <- fluidPage(

  tags$h2("updateDatepicker example"),

  fluidRow(
    column(
      width = 6,

      datepickerInput(
        inputId = "id1",
        label = "Update a (single) date:",
        value = Sys.Date()
      ),
      verbatimTextOutput("res1"),
      actionButton("update1", "Update date"),

      datepickerInput(
        "id2",
        "Update a range of date:",
        range = TRUE,
        autoRanges = TRUE,
        grid = 2,
        calendars = 2
      ),
      verbatimTextOutput("res2"),
      actionButton("update2", "Update range"),

      datepickerInput(
        inputId = "id3",
        label = "Activate/deactivate range mode:"
      ),
      verbatimTextOutput("res3"),
      checkboxInput("update3", "range"),

      datepickerInput(
        inputId = "id4",
        label = "Clear date:",
        value = Sys.Date()
      ),
      verbatimTextOutput("res4"),
      actionButton("update4", "Clear date"),

    ),
    column(
      width = 6,

      datepickerInput(
        inputId = "id5",
        label = "With min and max dates:",
        value = Sys.Date(),
        minDate = Sys.Date() - 5,
        maxDate = Sys.Date() + 5
      ),
      verbatimTextOutput("res5"),

      datepickerInput(
        inputId = "id6",
        label = "Lock weekends or not:",
        value = Sys.Date(),
        filterDays = "function(date, picked) {return [0, 6].includes(date.getDay());}"
      ),
      verbatimTextOutput("res6"),
      checkboxInput("update6", "lock weekends", value = TRUE),

      datepickerInput(
        inputId = "id7",
        label = "Custom start view and custom days disabled:",
        startView = as.Date("1998-07-01"),
        filterDays = sprintf(
          "function(date, picked) {return %s.includes(date.format('YYYY-MM-DD'));}",
          jsonlite::toJSON(as.Date(c(
            "1998-07-03",
            "1998-07-04",
            "1998-07-07",
            "1998-07-08",
            "1998-07-11",
            "1998-07-12"
          )))
        )
      ),
      verbatimTextOutput("res7")
    )
  )
)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$id1)
  observeEvent(input$update1, {
    updateDatepicker("id1", value = Sys.Date() + sample(-10:10, 1))
  })
  output$res2 <- renderPrint(input$id2)
  observeEvent(input$update2, {
    updateDatepicker("id2", value = Sys.Date() + sort(sample(-10:10, 2)))
  })
  output$res3 <- renderPrint(input$id3)
  observeEvent(input$update3, {
    updateDatepicker("id3", range = input$update3)
  })
  output$res4 <- renderPrint(input$id4)
  observeEvent(input$update4, {
    updateDatepicker("id4", value = character(0))
  })
  output$res5 <- renderPrint(input$id5)
  output$res6 <- renderPrint(input$id6)
  observeEvent(input$update6, {
    if (input$update6) {
      updateDatepicker("id6", filterDays = "function(date, picked) {return [0, 6].includes(date.getDay());}")
    } else {
      updateDatepicker("id6", filterDays = "function(date, picked) {return [].includes(date.getDay());}")
    }
  })
  output$res7 <- renderPrint(input$id7)

}

shinyApp(ui, server)
