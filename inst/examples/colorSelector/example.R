

# colorSelector example ---------------------------------------------------


library("shiny")
library("shinyWidgets")
library("RColorBrewer")
library("viridisLite")


# ColorBrewer palette
choices_brewer <- list(
  "Blues" = brewer.pal(n = 9, name = "Blues"),
  "Greens" = brewer.pal(n = 9, name = "Greens"),
  "Reds" = brewer.pal(n = 9, name = "Reds"),
  "Oranges" = brewer.pal(n = 9, name = "Oranges"),
  "Purples" = brewer.pal(n = 9, name = "Purples"),
  "Greys" = brewer.pal(n = 9, name = "Greys"),
  "Dark2" = brewer.pal(n = 8, name = "Dark2"),
  "Set1" = brewer.pal(n = 8, name = "Set1"),
  "Paired" = brewer.pal(n = 10, name = "Paired")
)


# Viridis palette (we remove the alpha from hex code because it's not supported in all browsers)
col2Hex <- function(col) {
  mat <- grDevices::col2rgb(col, alpha = TRUE)
  grDevices::rgb(mat[1, ]/255, mat[2, ]/255, mat[3,]/255)
}

choices_viridis <- list(
  " " = col2Hex(viridis(10)),
  " " = col2Hex(magma(10)),
  " " = col2Hex(inferno(10))
)


# Classic R colors (we remove the nuance becaure there aren't valid css colors)
choices_colors <- colors(distinct = TRUE)
choices_colors <- choices_colors[!grepl(pattern = "\\d$", x = choices_colors)]


ui <- fluidPage(
  fluidRow(
    column(
      width = 4,
      colorSelectorInput(
        inputId = "mycolor1",
        label = "Pick a color :",
        choices = c("steelblue", "cornflowerblue", "firebrick", "palegoldenrod", "forestgreen")
      ),
      verbatimTextOutput("result1")
    ),
    column(
      width = 4,
      colorSelectorInput(
        inputId = "mycolor2",
        label = "Pick a color :",
        choices = choices_brewer,
        display_label = TRUE
      ),
      verbatimTextOutput("result2")
    ),
    column(
      width = 4,
      colorSelectorInput(
        inputId = "mycolor3",
        label = "Pick a color :",
        choices = choices_viridis
      ),
      verbatimTextOutput("result3")
    )
  ),
  fluidRow(
    column(
      width = 4,
      colorSelectorInput(
        inputId = "mycolor4",
        label = "Pick a color :",
        choices = choices_colors
      ),
      verbatimTextOutput("result4")
    )
  )
)

server <- function(input, output, session) {
  output$result1 <- renderPrint({
    input$mycolor1
  })
  output$result2 <- renderPrint({
    input$mycolor2
  })
  output$result3 <- renderPrint({
    input$mycolor3
  })
  output$result4 <- renderPrint({
    input$mycolor4
  })
}

shinyApp(ui = ui, server = server)
