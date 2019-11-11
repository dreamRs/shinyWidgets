### Limit the number of selections ----

if (interactive()) {

  library(shiny)
  library(shinyWidgets)

  ui <- fluidPage(
    pickerInput(
      inputId = "groups",
      label = "Select one from each group below:",
      choices = list(
        Group1 = c("1", "2", "3", "4"),
        Group2 = c("A", "B", "C", "D")
      ),
      multiple = TRUE,
      options =  list("max-options-group" = 1)
    ),
    verbatimTextOutput(outputId = "res_grp"),
    pickerInput(
      inputId = "groups_2",
      label = "Select two from each group below:",
      choices = list(
        Group1 = c("1", "2", "3", "4"),
        Group2 = c("A", "B", "C", "D")
      ),
      multiple = TRUE,
      options =  list("max-options-group" = 2)
    ),
    verbatimTextOutput(outputId = "res_grp_2"),
    pickerInput(
      inputId = "classic",
      label = "Select max two option below:",
      choices = c("A", "B", "C", "D"),
      multiple = TRUE,
      options =  list(
        "max-options" = 2,
        "max-options-text" = "No more!"
      )
    ),
    verbatimTextOutput(outputId = "res_classic")
  )

  server <- function(input, output) {

    output$res_grp <- renderPrint(input$groups)
    output$res_grp_2 <- renderPrint(input$groups_2)
    output$res_classic <- renderPrint(input$classic)

  }

  shinyApp(ui, server)

}
