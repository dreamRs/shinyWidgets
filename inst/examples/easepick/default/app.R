
library(shiny)
library(shinyWidgets)


ui <- fluidPage(

  # theme = bslib::bs_theme(version = 5L),

  tags$h2("datepickerInput example"),

  fluidRow(
    column(
      width = 6,

      datepickerInput(
        inputId = "id1",
        label = "Pick a (single) date:",
        value = Sys.Date()
      ),
      verbatimTextOutput("res1"),

      datepickerInput(
        "id2",
        "Pick a range of date:",
        range = TRUE,
        autoRanges = TRUE,
        grid = 2,
        calendars = 2
      ),
      verbatimTextOutput("res2"),

      datepickerInput(
        inputId = "id3",
        label = "With extra options (buttons, year and month select menus, weeknumbers):",
        autoApply = FALSE,
        locale = list(
          nextMonth = "\u276f",
          previousMonth = "\u276e",
          cancel = "Nope, abort",
          apply = "Yes, go for it"
        ),
        years = TRUE,
        months = TRUE,
        weekNumbers = TRUE
      ),
      verbatimTextOutput("res3"),

      datepickerInput(
        inputId = "id4",
        label = "Inline mode:",
        value = c(Sys.Date() - 7, Sys.Date()),
        range = TRUE,
        autoRanges = TRUE,
        inline = TRUE,
        zIndex = 1,
        grid = 2,
        calendars = 2,
        format = "DD MMM YYYY",
        lang = "fr-FR",
        tooltipText = c("jour", "jours"),
        rangesLabels = c(
          "Aujourd'hui", "Hier", "7 derniers jours",
          "30 derniers jours", "Mois en cours", "Dernier mois"
        )
      ),
      verbatimTextOutput("res4")

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
        label = "Lock days with custom JS function (weekends here):",
        value = Sys.Date(),
        filterDays = "function(date, picked) {return [0, 6].includes(date.getDay());}"
      ),
      verbatimTextOutput("res6"),

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
      verbatimTextOutput("res7"),

      datepickerInput(
        inputId = "id8",
        label = NULL,
        value = Sys.Date(),
        element = tags$button(
          class = "btn btn-primary",
          icon("calendar"), "bind calendar to a button"
        )
      ),
      verbatimTextOutput("res8")
    )
  )
)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$id1)
  output$res2 <- renderPrint(input$id2)
  output$res3 <- renderPrint(input$id3)
  output$res4 <- renderPrint(input$id4)
  output$res5 <- renderPrint(input$id5)
  output$res6 <- renderPrint(input$id6)
  output$res7 <- renderPrint(input$id7)
  output$res8 <- renderPrint(input$id8)

}

shinyApp(ui, server)
