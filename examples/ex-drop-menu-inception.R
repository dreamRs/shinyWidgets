if (interactive()) {
  library(shiny)
  library(shinyWidgets)

  ui <- fluidPage(
    tags$h2("Drop Menu Inception"),

    dropMenu(
      actionButton("open", "See what's inside"),
      options = list(distance = 0),
      arrow = FALSE,
      trigger = c("mouseenter", "focus"),
      dropMenu(
        actionButton("open1", "Menu 1"),
        "Menu 1",
        placement = "right"
      ),
      dropMenu(
        actionButton("open2", "Menu 2"),
        trigger = "mouseenter",
        "Menu 2",
        placement = "right"
      ),
      dropMenu(
        actionButton("open3", "Menu 3"),
        trigger = "mouseenter",
        dropMenu(
          actionButton("open3a", "Menu 3 A"),
          "Menu 3 A",
          placement = "right"
        ),
        dropMenu(
          actionButton("open3b", "Menu 3 B"),
          trigger = "mouseenter",
          "Menu 3 B",
          placement = "right"
        ),
        placement = "right"
      )
    )

  )

  server <- function(input, output, session) {


  }

  shinyApp(ui, server)
}
