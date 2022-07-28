library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h1("Update pretty checkbox group"),
  br(),

  fluidRow(
    column(
      width = 6,
      prettyCheckboxGroup(
        inputId = "checkgroup1",
        label = "Update my value!",
        choices = month.name[1:4],
        status = "danger",
        icon = icon("xmark")
      ),
      verbatimTextOutput(outputId = "res1"),
      br(),
      checkboxGroupInput(
        inputId = "update1", label = "Update value :",
        choices = month.name[1:4], inline = TRUE
      )
    ),
    column(
      width = 6,
      prettyCheckboxGroup(
        inputId = "checkgroup2",
        label = "Update my choices!",
        thick = TRUE,
        choices = month.name[1:4],
        animation = "pulse",
        status = "info"
      ),
      verbatimTextOutput(outputId = "res2"),
      br(),
      actionButton(inputId = "update2", label = "Update choices !")
    )
  )

)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$checkgroup1)

  observeEvent(input$update1, {
    if (is.null(input$update1)) {
      selected_ <- character(0) # no choice selected
    } else {
      selected_ <- input$update1
    }
    updatePrettyCheckboxGroup(
      session = session,
      inputId = "checkgroup1",
      selected = selected_
    )
  }, ignoreNULL = FALSE)

  output$res2 <- renderPrint(input$checkgroup2)
  observeEvent(input$update2, {
    updatePrettyCheckboxGroup(
      session = session,
      inputId = "checkgroup2",
      choices = sample(month.name, 4),
      prettyOptions = list(animation = "pulse", status = "info")
    )
  }, ignoreInit = TRUE)

}

if (interactive())
  shinyApp(ui, server)

