library(shiny)
library(shinyWidgets)


ui <- fluidPage(

  tags$h2("Stati Card"),

  fluidRow(
    column(
      width = 3,
      statiCard(12, "Subtitle", icon("house")),
      statiCard(
        93, "Animated card", icon("users"),
        background = "deepskyblue",
        color = "white",
        animate = TRUE,
        id = "card1"
      ),
      actionButton("update1", "Update card above server-side"),
      statiCard(
        93, "No animation", icon("users"),
        background = "deepskyblue",
        color = "white",
        id = "card2"
      ),
      actionButton("update2", "Update card above server-side")
    ),
    column(
      width = 3,
      statiCard("$123,456", "Total spend", icon("rocket"), left = TRUE, animate = TRUE),
      tags$br(),
      actionButton("show", "Show card (rendered server-side)"),
      uiOutput(outputId = "card")
    ),
    column(
      width = 3,
      statiCard(12, "No animation", icon("house"), color = "firebrick")
    ),
    column(
      width = 3,
      statiCard(
        "123456 something very very long",
        "Long value text",
        icon = NULL,
        left = TRUE,
        background = "steelblue",
        color = "white"
      ),
      statiCard(
        "123456 something very very long",
        "Long value text with icon",
        icon = icon("gauge"),
        left = TRUE
      ),
      statiCard(
        "123456 something very very long",
        "Long value text with icon right",
        icon = icon("list-check")
      )
    )
  )

)


server <- function(input, output, session) {

  observeEvent(input$update1, {
    updateStatiCard(
      id = "card1",
      value = sample.int(200, 1)
    )
  })

  observeEvent(input$update2, {
    updateStatiCard(
      id = "card2",
      value = sample.int(200, 1)
    )
  })

  output$card <- renderUI({
    req(input$show)
    statiCard(
      format(sample.int(1e6, 1), big.mark = " "),
      "Total spend",
      icon("cart-shopping"),
      left = TRUE,
      animate = TRUE
    )
  })

}

if (interactive())
  shinyApp(ui, server)
