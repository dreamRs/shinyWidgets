library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h2("Virtual Select (update)"),

  virtualSelectInput(
    inputId = "sel1",
    label = "Update label:",
    choices = month.name
  ),
  verbatimTextOutput("res1"),
  textInput("label_text", label = "With text:"),
  textInput("label_html", label = "With HTML:"),

  virtualSelectInput(
    inputId = "sel2",
    label = "Update selected value:",
    choices = month.name
  ),
  verbatimTextOutput("res2"),
  radioButtons("selected", "Selected value:", month.name, inline = TRUE),

  virtualSelectInput(
    inputId = "sel3",
    label = "Update choices:",
    choices = tolower(month.name)
  ),
  verbatimTextOutput("res3"),
  radioButtons("choices", "Choices:", c("lowercase", "UPPERCASE"), inline = TRUE),

  virtualSelectInput(
    inputId = "sel4",
    label = "Update choices + selected:",
    choices = tolower(month.name)
  ),
  verbatimTextOutput("res4"),
  radioButtons("choices_select", "Choices:", c("lowercase", "UPPERCASE"), inline = TRUE),

  virtualSelectInput(
    inputId = "sel5",
    label = "Disable / enable:",
    choices = tolower(month.name)
  ),
  verbatimTextOutput("res5"),
  checkboxInput("disable", "Disable", value = FALSE),
  checkboxInput("disableChoices", "Disable march and june", value = FALSE)

)

server <- function(input, output, session) {
  output$res1 <- renderPrint(input$sel1)
  observe({
    req(input$label_text)
    updateVirtualSelect(inputId = "sel1", label = input$label_text)
  })
  observe({
    req(input$label_html)
    updateVirtualSelect(
      inputId = "sel1",
      label = tags$span(input$label_html, style = "color: red;")
    )
  })

  output$res2 <- renderPrint(input$sel2)
  observe({
    updateVirtualSelect(inputId = "sel2", selected = input$selected)
  })

  output$res3 <- renderPrint(input$sel3)
  observe({
    if (identical(input$choices, "lowercase")) {
      updateVirtualSelect(inputId = "sel3", choices = tolower(month.name))
    } else {
      updateVirtualSelect(inputId = "sel3", choices = toupper(month.name))
    }
  })

  output$res4 <- renderPrint(input$sel4)
  observe({
    if (identical(input$choices_select, "lowercase")) {
      choices <- tolower(month.name)
    } else {
      choices <- toupper(month.name)
    }
    selected <- sample(choices, 1)
    updateVirtualSelect(inputId = "sel4", choices = choices, selected = selected)
  })

  output$res5 <- renderPrint(input$sel5)
  observe({
    if (isTRUE(input$disable)) {
      updateVirtualSelect(inputId = "sel5", disable = TRUE)
    } else {
      updateVirtualSelect(inputId = "sel5", disable = FALSE)
    }
  })
  observe({
    if (isTRUE(input$disableChoices)) {
      updateVirtualSelect(inputId = "sel5", disabledChoices = c("march", "june"))
    } else {
      updateVirtualSelect(inputId = "sel5", disabledChoices = character(0))
    }
  })
}

if (interactive())
  shinyApp(ui, server)
