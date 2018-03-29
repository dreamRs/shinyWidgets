library(shiny)

ui <- fluidPage(
  br(), br(), br(),
  fluidRow(
    column(
      width = 10, offset = 1,
      tags$h2("Pretty checkboxes demo"),
      splitLayout(
        prettyCheckbox(
          inputId = "pretty_1", label = "Check me!", icon = icon("check")
        ),
        prettyCheckbox(
          inputId = "pretty_2", label = "Check me!", icon = icon("thumbs-up"),
          status = "default", shape = "curve", animation = "pulse"
        ),
        prettyCheckbox(
          inputId = "pretty_3", label = "Check me!", icon = icon("users"),
          animation = "pulse", plain = TRUE, outline = TRUE
        ),
        prettyCheckbox(
          inputId = "pretty_4", label = "Check me!",
          status = "success", outline = TRUE
        ),
        prettyCheckbox(
          inputId = "pretty_5", label = "Check me!",
          shape = "round", outline = TRUE, status = "info"
        )
      ),
      verbatimTextOutput(outputId = "res1"),
      br(),
      splitLayout(
        prettyCheckbox(
          inputId = "pretty_6", label = "Check me!",
          thick = TRUE, outline = TRUE
        ),
        prettyCheckbox(
          inputId = "pretty_7", label = "Check me!",
          icon = icon("check"), status = "primary", plain = TRUE
        ),
        prettyCheckbox(
          inputId = "pretty_8", label = "Check me!",
          status = "success", fill = TRUE
        ),
        prettyCheckbox(
          inputId = "pretty_9", label = "Check me!",
          shape = "round", fill = TRUE, status = "danger"
        ),
        prettySwitch(
          inputId = "pretty_10", label = "Check me!",
          slim = TRUE, status = "primary"
        )
      ),
      verbatimTextOutput(outputId = "res2")
    )
  )
)

server <- function(input, output, session) {
  output$res1 <- renderPrint({
    unlist(reactiveValuesToList(input)[1:5])
  })
  output$res2 <- renderPrint({
    unlist(reactiveValuesToList(input)[6:10])
  })
}

shinyApp(ui, server)
