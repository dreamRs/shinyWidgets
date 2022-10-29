#### Regular Examples ----

if (interactive()) {
  library(shiny)
  library(shinyWidgets)

  ui <- fluidPage(
    h1("Autonumeric Inputs"),
    br(),
    autonumericInput(
      inputId = "id1",
      label = "Default Input",
      value = 1234.56
    ),
    verbatimTextOutput("res1"),
    autonumericInput(
      inputId = "id2",
      label = "Custom Thousands of Dollars Input",
      value = 1234.56,
      align = "right",
      currencySymbol = "$",
      currencySymbolPlacement = "p",
      decimalCharacter = ".",
      digitGroupSeparator = ",",
      divisorWhenUnfocused = 1000,
      symbolWhenUnfocused = "K"
    ),
    verbatimTextOutput("res2"),
    autonumericInput(
      inputId = "id3",
      label = "Custom Millions of Euros Input with Positive Sign",
      value = 12345678910,
      align = "right",
      currencySymbol = " €",
      currencySymbolPlacement = "s",
      decimalCharacter = ",",
      digitGroupSeparator = ".",
      divisorWhenUnfocused = 1000000,
      symbolWhenUnfocused = " (millions)",
      showPositiveSign = TRUE
    ),
    verbatimTextOutput("res3")
  )

  server <- function(input, output, session) {
    output$res1 <- renderPrint(input$id1)
    output$res2 <- renderPrint(input$id2)
    output$res3 <- renderPrint(input$id3)
  }

  shinyApp(ui, server)
}

#### Examples with Update Buttons ----

if (interactive()) {
  library(shiny)
  library(shinyWidgets)

  ui <- fluidPage(
    h1("AutonumericInput Update Example"),
    br(),
    autonumericInput(
      inputId = "id1",
      label = "Autonumeric Input",
      value = 1234.56,
      align = "center",
      currencySymbol = "$ ",
      currencySymbolPlacement = "p",
      decimalCharacter = ".",
      digitGroupSeparator = ","
    ),
    verbatimTextOutput("res1"),
    actionButton("bttn1", "Change Input to Euros"),
    actionButton("bttn2", "Change Input to Dollars"),
    br(),
    br(),
    sliderInput("decimals", "Select Number of Decimal Places", value = 2, step = 1, min = 0, max = 6),
    actionButton("bttn3", "Update Number of Decimal Places")
  )

  server <- function(input, output, session) {
    output$res1 <- renderPrint(input$id1)

    observeEvent(input$bttn1, {
      updateAutonumericInput(
        session = session,
        inputId = "id1",
        label = "Euros:",
        value = 6543.21,
        options = list(
          currencySymbol = "€",
          currencySymbolPlacement = "s",
          decimalCharacter = ",",
          digitGroupSeparator = "."
        )
      )
    })
    observeEvent(input$bttn2, {
      updateAutonumericInput(
        session = session,
        inputId = "id1",
        label = "Dollars:",
        value = 6543.21,
        options = list(
          currencySymbol = "$",
          currencySymbolPlacement = "p",
          decimalCharacter = ".",
          digitGroupSeparator = ","
        )
      )
    })
    observeEvent(input$bttn3, {
      updateAutonumericInput(
        session = session,
        inputId = "id1",
        options = list(
          decimalPlaces = input$decimals
        )
      )
    })
  }

  shinyApp(ui, server)
}
