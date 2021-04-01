library(shiny)
library(shinyWidgets)
library(bslib)

styles <- c("simple", "bordered", "minimal", "stretch", "jelly",
            "gradient", "fill", "material-circle", "material-flat",
            "pill", "float", "unite")

bttn <- function(style, color) {
  tagList(
    actionBttn(
      inputId = paste0("ID", sample.int(1e6, 1)),
      label = style,
      style = style, color = color
    ),
    tags$br(),
    tags$br(),
    tags$br()
  )
}

ui <- fluidPage(
  theme = bs_theme(
    primary = "purple",
    info = "#00FF00",
    success = "#08088A",
    warning = "#D7DF01",
    danger = "#FA58D0",
    royal = "#00FFBF",
    grid_columns = 5
  ),
  tags$h2("bttn.css with {bslib}"),
  tags$br(),

  fluidRow(
    column(
      width = 1,
      lapply(styles, bttn, color = "primary")
    ),
    column(
      width = 1,
      lapply(styles, bttn, color = "warning")
    ),
    column(
      width = 1,
      lapply(styles, bttn, color = "danger")
    ),
    column(
      width = 1,
      lapply(styles, bttn, color = "success")
    ),
    column(
      width = 1,
      lapply(styles, bttn, color = "royal")
    )
  )

)

server <- function(input, output, session) {

}


if (interactive())
  shinyApp(ui = ui, server = server)
