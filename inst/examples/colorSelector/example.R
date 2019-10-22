

# colorSelector example ---------------------------------------------------


library("shiny")
library("shinyWidgets")
library("scales")



# ColorBrewer palette
choices_brewer <- list(
  "Blues" = brewer_pal(palette = "Blues")(9),
  "Greens" = brewer_pal(palette = "Greens")(9),
  "Reds" = brewer_pal(palette = "Reds")(9),
  "Oranges" = brewer_pal(palette = "Oranges")(9),
  "Purples" = brewer_pal(palette = "Purples")(9),
  "Greys" = brewer_pal(palette = "Greys")(9),
  "Dark2" = brewer_pal(palette = "Dark2")(8),
  "Set1" = brewer_pal(palette = "Set1")(8),
  "Paired" = brewer_pal(palette = "Paired")(10)
)


# Viridis palette (we remove the alpha from hex code because it's not supported in all browsers)
col2Hex <- function(col) {
  mat <- grDevices::col2rgb(col, alpha = TRUE)
  grDevices::rgb(mat[1, ]/255, mat[2, ]/255, mat[3,]/255)
}

choices_viridis <- list(
  "viridis" = col2Hex(viridis_pal(option = "viridis")(10)),
  "magma" = col2Hex(viridis_pal(option = "magma")(10)),
  "inferno" = col2Hex(viridis_pal(option = "inferno")(10)),
  "plasma" = col2Hex(viridis_pal(option = "plasma")(10)),
  "cividis" = col2Hex(viridis_pal(option = "cividis")(10))
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
