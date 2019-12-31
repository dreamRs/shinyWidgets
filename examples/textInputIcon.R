if (interactive()) {
  library(shiny)
  library(shinyWidgets)

  ui <- fluidPage(
    tags$h2("textInputIcon examples"),
    fluidRow(
      column(
        width = 6,
        textInputIcon(
          inputId = "ex1",
          label = "With an icon",
          icon = icon("user-circle-o")
        ),
        textInputIcon(
          inputId = "ex2",
          label = "With an icon (right)",
          icon = list(NULL, icon("user-circle-o"))
        ),
        textInputIcon(
          inputId = "ex3",
          label = "With text",
          icon = list("https://")
        ),
        textInputIcon(
          inputId = "ex4",
          label = "Both side",
          icon = list(icon("envelope"), "@mail.com")
        ),
        textInputIcon(
          inputId = "ex5",
          label = "Sizing",
          icon = list(icon("envelope"), "@mail.com"),
          size = "lg"
        )
      )
    )
  )

  server <- function(input, output, session) {

  }

  shinyApp(ui, server)
}
