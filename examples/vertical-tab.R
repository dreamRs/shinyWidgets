library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  theme = bslib::bs_theme(version = 5L),
  fluidRow(
    column(
      width = 10, offset = 1,
      tags$h2("Vertical tab panel example"),
      tags$p(
        "Active tab is:", uiOutput("active", container = tags$b)
      ),
      verticalTabsetPanel(
        id = "my_vertical_tab_panel",
        verticalTabPanel(
          title = "Title 1",
          icon = icon("house", "fa-2x"),
          "Content panel 1"
        ),
        verticalTabPanel(
          title = "Title 2",
          icon = icon("map", "fa-2x"),
          "Content panel 2"
        ),
        verticalTabPanel(
          title = "Title 3",
          icon = icon("rocket", "fa-2x"),
          "Content panel 3"
        )
      )
    )
  )
)

server <- function(input, output, session) {
  output$active <- renderUI(input$my_vertical_tab_panel)
}

if (interactive()) {
  shinyApp(ui, server)
}
