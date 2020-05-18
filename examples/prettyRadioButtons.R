library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h1("Pretty radio buttons"),
  br(),

  fluidRow(
    column(
      width = 4,
      prettyRadioButtons(
        inputId = "radio1",
        label = "Click me!",
        choices = c("Click me !", "Me !", "Or me !")
      ),
      verbatimTextOutput(outputId = "res1"),
      br(),
      prettyRadioButtons(
        inputId = "radio4",
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
      prettyRadioButtons(
        inputId = "radio2",
        label = "Click me!",
        thick = TRUE,
        choices = c("Click me !", "Me !", "Or me !"),
        animation = "pulse",
        status = "info"
      ),
      verbatimTextOutput(outputId = "res2"),
      br(),
      prettyRadioButtons(
        inputId = "radio5",
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
      prettyRadioButtons(
        inputId = "radio3",
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

  output$res1 <- renderPrint(input$radio1)
  output$res2 <- renderPrint(input$radio2)
  output$res3 <- renderPrint(input$radio3)
  output$res4 <- renderPrint(input$radio4)
  output$res5 <- renderPrint(input$radio5)

}

if (interactive())
  shinyApp(ui, server)
