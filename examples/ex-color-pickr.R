
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h2("Color pickr"),
  fluidRow(
    column(
      width = 4,
      tags$h4("Appearance"),
      colorPickr(
        inputId = "id1",
        label = "Pick a color (classic theme):",
        width = "100%"
      ),
      verbatimTextOutput("res1"),
      colorPickr(
        inputId = "id2",
        label = "Pick a color (monolith theme):",
        theme = "monolith",
        width = "100%"
      ),
      verbatimTextOutput("res2"),
      colorPickr(
        inputId = "id3",
        label = "Pick a color (nano theme):",
        theme = "nano",
        width = "100%"
      ),
      verbatimTextOutput("res3"),
      colorPickr(
        inputId = "id4",
        label = "Pick a color (swatches + opacity):",
        swatches = scales::viridis_pal()(10),
        opacity = TRUE
      ),
      verbatimTextOutput("res4"),
      colorPickr(
        inputId = "id5",
        label = "Pick a color (only swatches):",
        selected = "#440154",
        swatches = c(
          scales::viridis_pal()(9),
          scales::brewer_pal(palette = "Blues")(9),
          scales::brewer_pal(palette = "Reds")(9)
        ),
        update = "change",
        opacity = FALSE,
        preview = FALSE,
        hue = FALSE,
        interaction = list(
          hex= FALSE,
          rgba = FALSE,
          input = FALSE,
          save = FALSE,
          clear = FALSE
        ),
        pickr_width = "245px"
      ),
      verbatimTextOutput("res5"),
      colorPickr(
        inputId = "id6",
        label = "Pick a color (button):",
        swatches = scales::viridis_pal()(10),
        theme = "monolith",
        useAsButton = TRUE
      ),
      verbatimTextOutput("res6"),
      colorPickr(
        inputId = "id7",
        label = "Pick a color (inline):",
        swatches = scales::viridis_pal()(10),
        theme = "monolith",
        inline = TRUE,
        width = "100%"
      ),
      verbatimTextOutput("res7")
    ),
    column(
      width = 4,
      tags$h4("Trigger server update"),
      colorPickr(
        inputId = "id11",
        label = "Pick a color (update on save):",
        position = "right-start"
      ),
      verbatimTextOutput("res11"),
      colorPickr(
        inputId = "id12",
        label = "Pick a color (update on change):",
        update = "change",
        interaction = list(
          clear = FALSE,
          save = FALSE
        ),
        position = "right-start"
      ),
      verbatimTextOutput("res12"),
      colorPickr(
        inputId = "id13",
        label = "Pick a color (update on change stop):",
        update = "changestop",
        interaction = list(
          clear = FALSE,
          save = FALSE
        ),
        position = "right-start"
      ),
      verbatimTextOutput("res13")
    ),
    column(
      width = 4,
      tags$h4("Update server-side"),
      colorPickr(
        inputId = "id21",
        label = "Pick a color (update value):",
        width = "100%"
      ),
      verbatimTextOutput("res21"),
      actionButton("red", "Update red"),
      actionButton("green", "Update green"),
      actionButton("blue", "Update blue"),
      colorPickr(
        inputId = "id22",
        label = "Pick a color (enable/disable):",
        width = "100%"
      ),
      verbatimTextOutput("res22"),
      actionButton("enable", "Enable"),
      actionButton("disable", "Disable")
    )
  )
)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$id1)
  output$res2 <- renderPrint(input$id2)
  output$res3 <- renderPrint(input$id3)
  output$res4 <- renderPrint(input$id4)
  output$res5 <- renderPrint(input$id5)
  output$res6 <- renderPrint(input$id6)
  output$res7 <- renderPrint(input$id7)

  output$res11 <- renderPrint(input$id11)
  output$res12 <- renderPrint(input$id12)
  output$res13 <- renderPrint(input$id13)

  output$res21 <- renderPrint(input$id21)
  observeEvent(input$red, {
    updateColorPickr(session, "id21", "firebrick")
  })
  observeEvent(input$green, {
    updateColorPickr(session, "id21", "forestgreen")
  })
  observeEvent(input$blue, {
    updateColorPickr(session, "id21", "steelblue")
  })

  output$res22 <- renderPrint(input$id22)
  observeEvent(input$enable, {
    updateColorPickr(session, "id22", action = "enable")
  })
  observeEvent(input$disable, {
    updateColorPickr(session, "id22", action = "disable")
  })

}

if (interactive())
  shinyApp(ui, server)
