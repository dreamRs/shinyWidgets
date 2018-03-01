library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h3("Some examples noUiSlider"),
  tags$br(),

  fluidRow(

    column(
      width = 6,

      panel(
        heading = "single handle", status = "info",
        noUiSliderInput(
          inputId = "sli1", label = "Default slider:",
          min = 0, max = 500, value = 200
        ),
        verbatimTextOutput(outputId = "res1")
      ),

      panel(
        heading = "double handles", status = "info",
        noUiSliderInput(
          inputId = "sli3", label = "Range slider",
          min = 0, max = 500, value = c(200, 300),
          step = 1
        ),
        verbatimTextOutput(outputId = "res3")
      ),

      panel(
        heading = "multiple handles", status = "info",
        noUiSliderInput(
          inputId = "sli5", label = "Multiple return values",
          min = 0, max = 500, value = c(100, 220, 380, 450),
          tooltips = FALSE, step = 1
        ),
        verbatimTextOutput(outputId = "res5")
      ),

      panel(
        heading = "direction", status = "info",
        noUiSliderInput(
          inputId = "sli7", label = "Inverted direction",
          min = 0, max = 500, value = 200,
          tooltips = FALSE, step = 1,
          direction = "rtl"
        ),
        verbatimTextOutput(outputId = "res7")
      ),

      panel(
        heading = "direction", status = "info",
        noUiSliderInput(
          inputId = "sli9", label = "Vertical slider & inverted direction",
          min = 0, max = 500, value = 200,
          tooltips = FALSE, step = 1,
          direction = "rtl", orientation = "vertical", width = "100px", height = "300px"
        ),
        verbatimTextOutput(outputId = "res9")
      )

    ),

    column(
      width = 6,

      panel(
        heading = "connect", status = "info",
        noUiSliderInput(
          inputId = "sli2", label = "Color both sides of slider",
          min = 0, max = 500, value = 200,
          connect = c(TRUE, TRUE)
        ),
        verbatimTextOutput(outputId = "res2")
      ),

      panel(
        heading = "connect range", status = "info",
        noUiSliderInput(
          inputId = "sli4", label = "Inverse colors",
          min = 0, max = 500, value = c(200, 300),
          connect = c(TRUE, FALSE, TRUE)
        ),
        verbatimTextOutput(outputId = "res4")
      ),

      panel(
        heading = "margin option", status = "info",
        noUiSliderInput(
          inputId = "sli6", label = "Minimum distance between handles = 100",
          min = 0, max = 500, value = c(200, 250),
          margin = 100, tooltips = FALSE
        ),
        verbatimTextOutput(outputId = "res6")
      ),

      panel(
        heading = "limit option", status = "info",
        noUiSliderInput(
          inputId = "sli8", label = "Maximum distance between handles = 200",
          min = 0, max = 500, value = c(200, 250),
          limit = 200, tooltips = FALSE, behaviour = "drag"
        ),
        verbatimTextOutput(outputId = "res8")
      ),

      panel(
        heading = "color", status = "info",
        noUiSliderInput(
          inputId = "sli10", label = "Red slider",
          min = 0, max = 500, value = 200,
          color = "#FF0000", tooltips = FALSE
        ),
        verbatimTextOutput(outputId = "res10")
      ),

      panel(
        heading = "colors", status = "info",
        noUiSliderInput(
          inputId = "sli12", label = "Green slider",
          min = 0, max = 500, value = c(100, 400),
          color = "#04B431", tooltips = FALSE
        ),
        verbatimTextOutput(outputId = "res12")
      )

    )

  )
)

server <- function(input, output, session) {

  lapply(
    X = seq_len(12),
    FUN = function(i) {
      output[[paste0("res", i)]] <- renderPrint(input[[paste0("sli", i)]])
    }
  )

}

shinyApp(ui, server)
