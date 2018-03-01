library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h3("format numbers"),
  tags$br(),

  fluidRow(

    column(
      width = 6,

      panel(
        heading = "integer", status = "success",
        noUiSliderInput(
          inputId = "form1", label = "Integer values",
          min = 0, max = 500, value = 200,
          color = "#DFF0D8",
          format = wNumbFormat(decimals = 0)
        ),
        verbatimTextOutput(outputId = "res1")
      ),

      panel(
        heading = "decimal mark", status = "success",
        noUiSliderInput(
          inputId = "form3", label = "Comma for decimal",
          min = 0, max = 500, value = c(200, 300),
          color = "#DFF0D8",
          format = wNumbFormat(mark = ",")
        ),
        verbatimTextOutput(outputId = "res3")
      ),

      panel(
        heading = "thousand separators", status = "success",
        noUiSliderInput(
          inputId = "form5", label = "Display value like a 'year'",
          min = 1988, max = 2018, value = 1988, step = 1,
          color = "#DFF0D8",
          format = wNumbFormat(decimals = 0, thousand = "")
        ),
        verbatimTextOutput(outputId = "res5")
      )

    ),

    column(
      width = 6,

      panel(
        heading = "suffix", status = "success",
        noUiSliderInput(
          inputId = "form2", label = "Percentage",
          min = 0, max = 100, value = 20,
          color = "#DFF0D8",
          format = wNumbFormat(decimals = 1, suffix = "%")
        ),
        verbatimTextOutput(outputId = "res2")
      ),

      panel(
        heading = "prefix", status = "success",
        noUiSliderInput(
          inputId = "form4", label = "Dollar format",
          min = 0, max = 500, value = c(200, 300),
          color = "#DFF0D8",
          format = wNumbFormat(decimals = 2, prefix = "$")
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
      output[[paste0("res", i)]] <- renderPrint(input[[paste0("form", i)]])
    }
  )

}

shinyApp(ui, server)
