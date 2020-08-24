#### Default ----

if (interactive()) {
  library(shiny)
  library(shinyWidgets)

  ui <- fluidPage(
    tags$h2("Currency Input"),

    currencyInput("id1", "Euro:", value = 1234, format = "euro", width = 200, align = "right"),
    verbatimTextOutput("res1"),

    currencyInput("id2", "Dollar:", value = 1234, format = "dollar", width = 200, align = "right"),
    verbatimTextOutput("res2"),

    currencyInput("id3", "Yen:", value = 1234, format = "Japanese", width = 200, align = "right"),
    verbatimTextOutput("res3"),

    br(),
    tags$h2("Formatted Numeric Input"),

    formatNumericInput("id4", "Numeric:", value = 1234, width = 200),
    verbatimTextOutput("res4"),

    formatNumericInput("id5", "Percent:", value = 1234, width = 200, format = "percentageEU2dec"),
    verbatimTextOutput("res5")
  )

  server <- function(input, output, session) {
    output$res1 <- renderPrint(input$id1)
    output$res2 <- renderPrint(input$id2)
    output$res3 <- renderPrint(input$id3)
    output$res4 <- renderPrint(input$id4)
    output$res5 <- renderPrint(input$id5)
  }

  shinyApp(ui, server)
}

#### With Update Button

if (interactive()) {
  library(shiny)
  library(shinyWidgets)

  ui <- fluidPage(
    tags$h2("Currency Input"),

    currencyInput("id1", "Euro:", value = 1234, format = "euro", width = 200, align = "right"),
    verbatimTextOutput("res1"),
    actionButton("bttn0", "Change Input to Euros"),
    actionButton("bttn1", "Change Input to Dollars"),
    actionButton("bttn2", "Change Input to Yen")
  )

  server <- function(input, output, session) {

    output$res1 <- renderPrint(input$id1)

    observeEvent(input$bttn0, {
      updateCurrencyInput(
        session = session,
        inputId = "id1",
        label = "Euro:",
        format = "euro"
      )
    })
    observeEvent(input$bttn1, {
      updateCurrencyInput(
        session = session,
        inputId = "id1",
        label = "Dollar:",
        format = "dollar"
      )
    })
    observeEvent(input$bttn2, {
      updateCurrencyInput(
        session = session,
        inputId = "id1",
        label = "Yen:",
        format = "Japanese"
      )
    })


  }

  shinyApp(ui, server)
}
