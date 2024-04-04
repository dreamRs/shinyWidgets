library(shiny)
library(shinyWidgets)
library(htmltools)
library(phosphoricons)


ui <- fluidPage(
  html_dependency_winbox(),
  actionButton(inputId = "show", label = "Show one or more WinBox"),
  radioButtons(
    inputId = "background",
    label = "Background color:",
    choices = c("forestgreen", "firebrick", "steelblue", "goldenrod")
  ),
  checkboxInput(
    inputId = "modal",
    label = "Shows the window as modal",
    value = FALSE
  ),
  checkboxInput(
    inputId = "autosize",
    label = "Automatically size the window to fit the window contents.",
    value = FALSE
  ),
  checkboxInput(
    inputId = "max",
    label = "Automatically toggles the window into maximized state when created.",
    value = FALSE
  ),
  checkboxInput(
    inputId = "min",
    label = "Automatically toggles the window into minimized state when created.",
    value = FALSE
  )
)

server <- function(input, output, session) {

  observeEvent(input$show, {
    WinBox(
      title = "This is a WinBox",
      ui = tagList(
        tags$h3("Hello from WinBox!")
      ),
      options = wbOptions(
        background = input$background,
        modal = input$modal,
        autosize = input$autosize,
        max = input$max,
        min = input$min
      )
    )
  })

}

if (interactive())
  shinyApp(ui, server)
