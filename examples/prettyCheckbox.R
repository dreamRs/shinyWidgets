library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h1("Pretty checkbox"),
  br(),

  fluidRow(
    column(
      width = 4,
      prettyCheckbox(
        inputId = "checkbox1",
        label = "Click me!"
      ),
      verbatimTextOutput(outputId = "res1"),
      br(),
      prettyCheckbox(
        inputId = "checkbox4",
        label = "Click me!",
        outline = TRUE,
        plain = TRUE,
        icon = icon("thumbs-up")
      ),
      verbatimTextOutput(outputId = "res4")
    ),
    column(
      width = 4,
      prettyCheckbox(
        inputId = "checkbox2",
        label = "Click me!",
        thick = TRUE,
        animation = "pulse",
        status = "info"
      ),
      verbatimTextOutput(outputId = "res2"),
      br(),
      prettyCheckbox(
        inputId = "checkbox5",
        label = "Click me!",
        icon = icon("check"),
        animation = "tada",
        status = "default"
      ),
      verbatimTextOutput(outputId = "res5")
    ),
    column(
      width = 4,
      prettyCheckbox(
        inputId = "checkbox3",
        label = "Click me!",
        shape = "round",
        status = "danger",
        fill = TRUE,
        value = TRUE
      ),
      verbatimTextOutput(outputId = "res3")
    )
  )

)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$checkbox1)
  output$res2 <- renderPrint(input$checkbox2)
  output$res3 <- renderPrint(input$checkbox3)
  output$res4 <- renderPrint(input$checkbox4)
  output$res5 <- renderPrint(input$checkbox5)

}

if (interactive())
  shinyApp(ui, server)




# Inline example ----

ui <- fluidPage(
  tags$h1("Pretty checkbox: inline example"),
  br(),
  prettyCheckbox(
    inputId = "checkbox1",
    label = "Click me!",
    status = "success",
    outline = TRUE,
    inline = TRUE
  ),
  prettyCheckbox(
    inputId = "checkbox2",
    label = "Click me!",
    thick = TRUE,
    shape = "curve",
    animation = "pulse",
    status = "info",
    inline = TRUE
  ),
  prettyCheckbox(
    inputId = "checkbox3",
    label = "Click me!",
    shape = "round",
    status = "danger",
    value = TRUE,
    inline = TRUE
  ),
  prettyCheckbox(
    inputId = "checkbox4",
    label = "Click me!",
    outline = TRUE,
    plain = TRUE,
    animation = "rotate",
    icon = icon("thumbs-up"),
    inline = TRUE
  ),
  prettyCheckbox(
    inputId = "checkbox5",
    label = "Click me!",
    icon = icon("check"),
    animation = "tada",
    status = "primary",
    inline = TRUE
  ),
  verbatimTextOutput(outputId = "res")
)

server <- function(input, output, session) {

  output$res <- renderPrint(
    c(input$checkbox1,
      input$checkbox2,
      input$checkbox3,
      input$checkbox4,
      input$checkbox5)
  )

}

if (interactive())
  shinyApp(ui, server)

