

# knob --------------------------------------------------------------------

# Packages

library("shiny")
library("shinyWidgets")



# ui ----

ui <- fluidPage(
  tags$h1("knob input examples"),
  br(),

  fluidRow(

    column(
      width = 4,
      knobInput(inputId = "knob1", label = "Default:", value = 10),
      verbatimTextOutput(outputId = "res1"),

      knobInput(inputId = "knob2", label = "Color:", value = 1, fgColor = "#D9534F", displayInput = FALSE),
      verbatimTextOutput(outputId = "res2"),

      knobInput(inputId = "knob3", label = "Read only:", value = 65, readOnly = TRUE),
      verbatimTextOutput(outputId = "res3")
    ),

    column(
      width = 4,
      knobInput(inputId = "knob6", label = "Cursor mode:", value = 50, thickness = 0.3, cursor = TRUE, width = 150, height = 150), # must specify width
      verbatimTextOutput(outputId = "res6"),

      knobInput(inputId = "knob7", label = "Display previous:", value = 50, min = -100, displayPrevious = TRUE, fgColor = "#428BCA", inputColor = "#428BCA"),
      verbatimTextOutput(outputId = "res7"),

      tags$div(
        style = "background-color: #000;",
        knobInput(inputId = "knob8", label = tags$span("Tron skin:", style = "color: #FFF;"), value = 50, width = 75, fgColor = "#ffec03", inputColor = "#ffec03", skin = "tron")
      ),
      verbatimTextOutput(outputId = "res8")
    ),

    column(
      width = 4,
      knobInput(inputId = "knob11", label = "Angle offset:", value = 75, angleOffset = 90, lineCap = "round"),
      verbatimTextOutput(outputId = "res11"),

      knobInput(inputId = "knob12", label = "Angle offset and arc:", value = 50, angleOffset = -125, angleArc = 250),
      verbatimTextOutput(outputId = "res12"),

      knobInput(inputId = "knob13", label = "4-digit, step 0.1:", value = 0, min = -1000, max = 1000, step = 0.1, displayPrevious = TRUE),
      verbatimTextOutput(outputId = "res13")
    )

  )
)


# server ----

server <- function(input, output, session) {

  lapply(1:13, function(x) {
    output[[paste0("res", x)]] <- renderPrint(input[[paste0("knob", x)]])
  })

}


# app ----

shinyApp(ui = ui, server = server)

