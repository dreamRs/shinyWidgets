library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  theme = bslib::bs_theme(version = 5),
  fluidRow(
    column(
      width = 10, offset = 1,
      tags$h2("Update vertical tab panel example:"),
      verbatimTextOutput("res"),
      radioButtons(
        inputId = "update", label = "Update selected:",
        choices = c("Title 1", "Title 2", "Title 3"),
        inline = TRUE
      ),
      verticalTabsetPanel(
        id = "TABS",
        verticalTabPanel(
          title = "Title 1", icon = icon("house", "fa-2x"),
          "Content panel 1",
          textOutput("text1")
        ),
        verticalTabPanel(
          title = "Title 2", icon = icon("map", "fa-2x"),
          "Content panel 2",
          textOutput("text2")
        ),
        verticalTabPanel(
          title = "Title 3", icon = icon("rocket", "fa-2x"),
          "Content panel 3",
          textOutput("text3")
        )
      )
    )
  )
)

server <- function(input, output, session) {

  output$res <- renderPrint(input$TABS)
  observeEvent(input$update, {
    shinyWidgets:::updateVerticalTabsetPanel(
      session = session,
      inputId = "TABS",
      selected = input$update
    )
  }, ignoreInit = TRUE)

  output$text1 <- renderText("one")
  output$text2 <- renderText("two")
  output$text3 <- renderText("three")

}


if (interactive())
  shinyApp(ui, server)
