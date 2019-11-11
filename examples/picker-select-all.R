### Add actions box for selecting ----
### deselecting all options

if (interactive()) {

  library(shiny)
  library(shinyWidgets)

  ui <- fluidPage(
    tags$h2("Select / Deselect all"),
    pickerInput(
      inputId = "p1",
      label = "Select all option",
      choices = rownames(mtcars),
      multiple = TRUE,
      options = list(`actions-box` = TRUE)
    ),
    verbatimTextOutput("r1"),
    br(),
    pickerInput(
      inputId = "p2",
      label = "Select all option / custom text",
      choices = rownames(mtcars),
      multiple = TRUE,
      options = list(
        `actions-box` = TRUE,
        `deselect-all-text` = "None...",
        `select-all-text` = "Yeah, all !",
        `none-selected-text` = "zero"
      )
    ),
    verbatimTextOutput("r2")
  )

  server <- function(input, output, session) {

    output$r1 <- renderPrint(input$p1)
    output$r2 <- renderPrint(input$p2)

  }

  shinyApp(ui = ui, server = server)

}

