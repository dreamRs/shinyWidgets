
# Alerts ---------------------------------

library(shiny)
library(shinyWidgets)

ui <- fluidPage(

  # Try with different Bootstrap version
  # theme = bslib::bs_theme(version = 5),

  tags$h2("Alerts"),
  fluidRow(
    column(
      width = 6,
      alert(
        status = "success",
        tags$b("Well done!"), "You successfully read this important alert message."
      ),
      alert(
        status = "info",
        tags$b("Heads up!"), "This alert needs your attention, but it's not super important."
      ),
      alert(
        status = "info",
        dismissible = TRUE,
        tags$b("Dismissable"), "You can close this one."
      )
    ),
    column(
      width = 6,
      alert(
        status = "warning",
        tags$b("Warning!"), "Better check yourself, you're not looking too good."
      ),
      alert(
        status = "danger",
        tags$b("Oh snap!"), "Change a few things up and try submitting again."
      )
    )
  )
)

server <- function(input, output, session) {

}

if (interactive())
  shinyApp(ui, server)


