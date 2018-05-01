library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h3("Behaviour noUiSlider"),
  tags$br(),

  fluidRow(

    column(
      width = 6,

      panel(
        heading = "tap", status = "info",
        noUiSliderInput(
          inputId = "beh1", label = "Click the slider to move the handle",
          min = 0, max = 500, value = 200,
          color = "#D9EDF7", behaviour = "tap"
        ),
        verbatimTextOutput(outputId = "res1")
      ),

      panel(
        heading = "drag-tap", status = "info",
        noUiSliderInput(
          inputId = "beh3", label = "Drag range and move closest handle to click position",
          min = 0, max = 500, value = c(200, 300),
          color = "#D9EDF7", behaviour = c("tap", "drag")
        ),
        verbatimTextOutput(outputId = "res3")
      ),

      panel(
        heading = "snap", status = "info",
        noUiSliderInput(
          inputId = "beh5", label = "Move handle to clicked position and can be moved without a 'mouseup'",
          min = 0, max = 500, value = 200,
          color = "#D9EDF7", behaviour = "snap"
        ),
        verbatimTextOutput(outputId = "res5")
      )

    ),

    column(
      width = 6,

      panel(
        heading = "drag", status = "info",
        noUiSliderInput(
          inputId = "beh2", label = "Range is draggable",
          min = 0, max = 500, value = c(200, 300),
          color = "#D9EDF7", behaviour = "drag"
        ),
        verbatimTextOutput(outputId = "res2")
      ),

      panel(
        heading = "drag-fixed", status = "info",
        noUiSliderInput(
          inputId = "beh4", label = "Range is draggable, handles are linked",
          min = 0, max = 500, value = c(200, 300),
          color = "#D9EDF7", behaviour = c("drag", "fixed")
        ),
        verbatimTextOutput(outputId = "res4")
      )

    )

  )
)

server <- function(input, output, session) {

  lapply(
    X = seq_len(10),
    FUN = function(i) {
      output[[paste0("res", i)]] <- renderPrint(input[[paste0("beh", i)]])
    }
  )

}

shinyApp(ui, server)
