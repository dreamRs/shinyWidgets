
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h2("Exemple spinners"),
  actionButton(inputId = "refresh", label = "Refresh", width = "100%"),
  fluidRow(
    column(
      width = 5, offset = 1,
      addSpinner(plotOutput("plot1"), spin = "circle", color = "#E41A1C"),
      addSpinner(plotOutput("plot3"), spin = "bounce", color = "#377EB8"),
      addSpinner(plotOutput("plot5"), spin = "folding-cube", color = "#4DAF4A"),
      addSpinner(plotOutput("plot7"), spin = "rotating-plane", color = "#984EA3"),
      addSpinner(plotOutput("plot9"), spin = "cube-grid", color = "#FF7F00")
    ),
    column(
      width = 5,
      addSpinner(plotOutput("plot2"), spin = "fading-circle", color = "#FFFF33"),
      addSpinner(plotOutput("plot4"), spin = "double-bounce", color = "#A65628"),
      addSpinner(plotOutput("plot6"), spin = "dots", color = "#F781BF"),
      addSpinner(plotOutput("plot8"), spin = "cube", color = "#999999")
    )
  ),
  actionButton(inputId = "refresh2", label = "Refresh", width = "100%")
)

server <- function(input, output, session) {

  dat <- reactive({
    input$refresh
    input$refresh2
    Sys.sleep(3)
    Sys.time()
  })

  lapply(
    X = seq_len(9),
    FUN = function(i) {
      output[[paste0("plot", i)]] <- renderPlot({
        dat()
        plot(sin, -pi, i*pi)
      })
    }
  )

}

shinyApp(ui, server)
