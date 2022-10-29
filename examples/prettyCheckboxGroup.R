library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h1("Pretty checkbox group"),
  br(),
  fluidRow(
    column(
      width = 4,
      prettyCheckboxGroup(
        inputId = "checkgroup1",
        label = "Click me!",
        choices = c("Click me !", "Me !", "Or me !")
      ),
      verbatimTextOutput(outputId = "res1"),
      br(),
      prettyCheckboxGroup(
        inputId = "checkgroup4",
        label = "Click me!",
        choices = c("Click me !", "Me !", "Or me !"),
        outline = TRUE,
        plain = TRUE,
        icon = icon("thumbs-up")
      ),
      verbatimTextOutput(outputId = "res4")
    ),
    column(
      width = 4,
      prettyCheckboxGroup(
        inputId = "checkgroup2",
        label = "Click me!",
        thick = TRUE,
        choices = c("Click me !", "Me !", "Or me !"),
        animation = "pulse",
        status = "info"
      ),
      verbatimTextOutput(outputId = "res2"),
      br(),
      prettyCheckboxGroup(
        inputId = "checkgroup5",
        label = "Click me!",
        icon = icon("check"),
        choices = c("Click me !", "Me !", "Or me !"),
        animation = "tada",
        status = "default"
      ),
      verbatimTextOutput(outputId = "res5")
    ),
    column(
      width = 4,
      prettyCheckboxGroup(
        inputId = "checkgroup3",
        label = "Click me!",
        choices = c("Click me !", "Me !", "Or me !"),
        shape = "round",
        status = "danger",
        fill = TRUE,
        inline = TRUE
      ),
      verbatimTextOutput(outputId = "res3")
    )
  )
)

server <- function(input, output, session) {
  output$res1 <- renderPrint(input$checkgroup1)
  output$res2 <- renderPrint(input$checkgroup2)
  output$res3 <- renderPrint(input$checkgroup3)
  output$res4 <- renderPrint(input$checkgroup4)
  output$res5 <- renderPrint(input$checkgroup5)
}

if (interactive()) {
  shinyApp(ui, server)
}
