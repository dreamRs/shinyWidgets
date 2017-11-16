
library("shiny")
library("shinyWidgets")


ui <- function(request) {
  fluidPage(
    tags$h1("shinyWidgets - bookmarking"),
    textInput(inputId = "txt", label = "Text"),
    switchInput(inputId = "swh", label = "Switch"),
    checkboxInput(inputId = "chk", label = "Checkbox"),
    bookmarkButton()
  )
}

server <- function(input, output, session) {

}

enableBookmarking("url")

shinyApp(ui, server)
