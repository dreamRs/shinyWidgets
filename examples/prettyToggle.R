library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h1("Pretty toggles"),
  br(),

  fluidRow(
    column(
      width = 4,
      prettyToggle(
        inputId = "toggle1",
        label_on = "Checked!",
        label_off = "Unchecked..."
      ),
      verbatimTextOutput(outputId = "res1"),
      br(),
      prettyToggle(
        inputId = "toggle4",  label_on = "Yes!",
        label_off = "No..", outline = TRUE,
        plain = TRUE,
        icon_on = icon("thumbs-up"),
        icon_off = icon("thumbs-down")
      ),
      verbatimTextOutput(outputId = "res4")
    ),
    column(
      width = 4,
      prettyToggle(
        inputId = "toggle2",
        label_on = "Yes!", icon_on = icon("check"),
        status_on = "info", status_off = "warning",
        label_off = "No..", icon_off = icon("xmark")
      ),
      verbatimTextOutput(outputId = "res2")
    ),
    column(
      width = 4,
      prettyToggle(
        inputId = "toggle3",  label_on = "Yes!",
        label_off = "No..", shape = "round",
        fill = TRUE, value = TRUE
      ),
      verbatimTextOutput(outputId = "res3")
    )
  )

)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$toggle1)
  output$res2 <- renderPrint(input$toggle2)
  output$res3 <- renderPrint(input$toggle3)
  output$res4 <- renderPrint(input$toggle4)

}

if (interactive())
  shinyApp(ui, server)




# Inline example ----

ui <- fluidPage(
  tags$h1("Pretty toggles: inline example"),
  br(),

  prettyToggle(
    inputId = "toggle1",
    label_on = "Checked!",
    label_off = "Unchecked...",
    inline = TRUE
  ),
  prettyToggle(
    inputId = "toggle2",
    label_on = "Yep",
    status_on = "default",
    icon_on = icon("ok-circle", lib = "glyphicon"),
    label_off = "Nope",
    status_off = "default",
    icon_off = icon("remove-circle", lib = "glyphicon"),
    plain = TRUE,
    inline = TRUE
  ),
  prettyToggle(
    inputId = "toggle3",
    label_on = "",
    label_off = "",
    icon_on = icon("volume-high", lib = "glyphicon"),
    icon_off = icon("volume-off", lib = "glyphicon"),
    status_on = "primary",
    status_off = "default",
    plain = TRUE,
    outline = TRUE,
    bigger = TRUE,
    inline = TRUE
  ),
  prettyToggle(
    inputId = "toggle4",
    label_on = "Yes!",
    label_off = "No..",
    outline = TRUE,
    plain = TRUE,
    icon_on = icon("thumbs-up"),
    icon_off = icon("thumbs-down"),
    inline = TRUE
  ),

  verbatimTextOutput(outputId = "res")

)

server <- function(input, output, session) {

  output$res <- renderPrint(
    c(input$toggle1,
      input$toggle2,
      input$toggle3,
      input$toggle4)
  )

}

if (interactive())
  shinyApp(ui, server)
