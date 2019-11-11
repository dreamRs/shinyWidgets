### Customize the values displayed in the box ----

if (interactive()) {

  library(shiny)
  library(shinyWidgets)

  ui <- fluidPage(
    br(),
    pickerInput(
      inputId = "p1",
      label = "Default",
      multiple = TRUE,
      choices = rownames(mtcars),
      selected = rownames(mtcars)[1:5]
    ),
    br(),
    pickerInput(
      inputId = "p1b",
      label = "Default with | separator",
      multiple = TRUE,
      choices = rownames(mtcars),
      selected = rownames(mtcars)[1:5],
      options = list(`multiple-separator` = " | ")
    ),
    br(),
    pickerInput(
      inputId = "p2",
      label = "Static",
      multiple = TRUE,
      choices = rownames(mtcars),
      selected = rownames(mtcars)[1:5],
      options = list(`selected-text-format`= "static",
                     title = "Won't change")
    ),
    br(),
    pickerInput(
      inputId = "p3",
      label = "Count",
      multiple = TRUE,
      choices = rownames(mtcars),
      selected = rownames(mtcars)[1:5],
      options = list(`selected-text-format`= "count")
    ),
    br(),
    pickerInput(
      inputId = "p3",
      label = "Customize count",
      multiple = TRUE,
      choices = rownames(mtcars),
      selected = rownames(mtcars)[1:5],
      options = list(
        `selected-text-format`= "count",
        `count-selected-text` = "{0} models choosed (on a total of {1})"
      )
    )
  )

  server <- function(input, output, session) {

  }

  shinyApp(ui = ui, server = server)

}

