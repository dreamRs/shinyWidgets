
library("shiny")
library("shinyWidgets")

choices_colors <- colors(distinct = TRUE)
choices_colors <- choices_colors[!grepl(pattern = "\\d$", x = choices_colors)]


ui <- fluidPage(

  colorSelectorDrop(
    inputId = "mycolor1",
    label = NULL, circle = FALSE, size = "default",
    choices = choices_colors
  ),
  verbatimTextOutput("result1"),

  colorSelectorDrop(
    inputId = "mycolor2",
    label = NULL, circle = FALSE, size = "sm",
    choices = choices_colors
  ),
  verbatimTextOutput("result2"),

  colorSelectorDrop(
    inputId = "mycolor3",
    label = NULL, circle = FALSE, size = "xs",
    choices = choices_colors
  ),
  verbatimTextOutput("result3"),

  colorSelectorDrop(
    inputId = "mycolor4",
    label = NULL,
    choices = choices_colors
  ),
  verbatimTextOutput("result4"),

  colorSelectorDrop(
    inputId = "mycolor5",
    label = NULL, circle = FALSE, size = "lg",
    choices = choices_colors
  ),
  verbatimTextOutput("result5")

)

server <- function(input, output, session) {
  output$result1 <- renderPrint({
    input$mycolor1
  })
  output$result2 <- renderPrint({
    input$mycolor2
  })
  output$result3 <- renderPrint({
    input$mycolor3
  })
  output$result4 <- renderPrint({
    input$mycolor4
  })
}

shinyApp(ui = ui, server = server)
