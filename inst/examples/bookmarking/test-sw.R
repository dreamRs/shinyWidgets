
library("shiny")
library("shinyWidgets")


ui <- function(request) {
  fluidPage(
    tags$h1("shinyWidgets - bookmarking"),
    textInput(inputId = "txt", label = "Text"),
    checkboxInput(inputId = "chk", label = "Checkbox"),
    checkboxGroupButtons(inputId = "chkbtn", choices = c("A", "B", "C")),
    radioGroupButtons(inputId = "rdobtn", choices = c("A", "B", "C")),
    pickerInput(
      inputId = "pkr",
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
    bookmarkButton(),
    verbatimTextOutput("res_chkbtn"),
    verbatimTextOutput("res_rdobtn"),
    verbatimTextOutput("res_pkr")
  )
}

server <- function(input, output, session) {

  output$res_chkbtn <- renderPrint({
    input$chkbtn
  })
  output$res_rdobtn <- renderPrint({
    input$rdobtn
  })
  output$res_pkr <- renderPrint({
    input$pkr
  })

}

enableBookmarking("url")

shinyApp(ui, server)
