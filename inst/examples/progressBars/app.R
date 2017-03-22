

library("shiny")
library("shinydashboard")
library("shinyWidgets")

shinyApp(
  ui = dashboardPage(
    dashboardHeader(),
    dashboardSidebar(),
    dashboardBody(
      tags$h1(tags$b("Progress Bars"), style = "color: steelblue;"),
      br(),
      fluidRow(
        box(
          width = 6,
          tags$b("Default"), br(),
          progressBar(id = "pb1", value = 50),
          sliderInput(inputId = "up1", label = "Update", min = 0, max = 100, value = 50),
          br(),
          tags$b("Status : info & title"),br(),
          progressBar(id = "pb2", value = 50, status = "info", title = "This is a progress bar"),
          sliderInput(inputId = "up2", label = "Update", min = 0, max = 100, value = 50),
          br(),
          tags$b("Status : danger & striped : true"),br(),
          progressBar(id = "pb3", value = 50, status = "danger", striped = TRUE),
          sliderInput(inputId = "up3", label = "Update", min = 0, max = 100, value = 50)
        ),
        box(
          width = 6,
          tags$b("Display : percent"),br(),
          progressBar(id = "pb4", value = 50, display_pct = TRUE),
          sliderInput(inputId = "up4", label = "Update", min = 0, max = 100, value = 50, step = 5, animate = TRUE),
          br(),
          tags$b("Status : warning & value > 100"),br(),
          progressBar(id = "pb5", value = 1500, total = 5000, status = "warning"),
          sliderInput(inputId = "up5", label = "Update", min = 0, max = 5000, value = 50),
          br(),
          tags$b("Status : success & size : xs"),
          progressBar(id = "pb6", value = 50, status = "success", size = "xs"),
          sliderInput(inputId = "up6", label = "Update", min = 0, max = 100, value = 50)
        ),
        box(
          width = 12,
          tags$b("Status change"),br(),
          progressBar(id = "pb7", value = 50, display_pct = TRUE, status = "warning"),
          sliderInput(inputId = "up7", label = "Update", min = 0, max = 100, value = 50, step = 5, animate = TRUE),
          br(),
          progressBar(id = "pb8", value = 1500, total = 5000, status = "info", display_pct = TRUE, striped = TRUE, title = "All options"),
          sliderInput(inputId = "up8", label = "Update", min = 0, max = 5000, value = 50),
          br(),
          tags$b("Update total"),br(),
          progressBar(id = "pb9", value = 1000, total = 1000, display_pct = TRUE),
          sliderInput(inputId = "up9", label = "Update", min = 1000, max = 5000, value = 1000, step = 50)
        )
      )
    ),
    title = "Dashboard example"
  ),
  server = function(input, output, session) {

    observeEvent(input$up1, {
      updateProgressBar(session = session, id = "pb1", value = input$up1)
    })

    observeEvent(input$up2, {
      updateProgressBar(session = session, id = "pb2", value = input$up2)
    })

    observeEvent(input$up3, {
      updateProgressBar(session = session, id = "pb3", value = input$up3)
    })

    observeEvent(input$up4, {
      updateProgressBar(session = session, id = "pb4", value = input$up4)
    })

    observeEvent(input$up5, {
      updateProgressBar(session = session, id = "pb5", value = input$up5, total = 5000)
    })

    observeEvent(input$up6, {
      updateProgressBar(session = session, id = "pb6", value = input$up6)
    })

    observeEvent(input$up7, {
      if (input$up7 < 33) {
        status <- "danger"
      } else if (input$up7 >= 33 & input$up7 < 67) {
        status <- "warning"
      } else {
        status <- "success"
      }
      updateProgressBar(session = session, id = "pb7", value = input$up7, status = status)
    })

    observeEvent(input$up8, {
      updateProgressBar(session = session, id = "pb8", value = input$up8, total = 5000)
    })

    observeEvent(input$up9, {
      updateProgressBar(session = session, id = "pb9", value = 1000, total = input$up9)
    })

  }
)
