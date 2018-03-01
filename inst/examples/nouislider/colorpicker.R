

#  ------------------------------------------------------------------------
#
# Title : colorPicker with noUiSlider
#    By : VP
#  Date : 2018-02-22
#
#  ------------------------------------------------------------------------




# app ---------------------------------------------------------------------


ui <- fluidPage(
  tags$h3("color picker !"),
  tags$br(),

  fluidRow(
    column(
      width = 6,
      noUiSliderInput(
        inputId = "red", min = 0, max = 255,
        value = 127, tooltips = FALSE,
        step = 1, orientation = "vertical",
        color = "#c0392b", inline = TRUE,
        height = "200px", width = "30px"
      ),
      noUiSliderInput(
        inputId = "green", min = 0, max = 255,
        value = 127, tooltips = FALSE,
        step = 1, orientation = "vertical",
        color = "#27ae60", inline = TRUE,
        height = "200px", width = "30px"
      ),
      noUiSliderInput(
        inputId = "blue", min = 0, max = 255,
        value = 127, tooltips = FALSE,
        step = 1, orientation = "vertical",
        color = "#2980b9", inline = TRUE,
        height = "200px", width = "30px"
      ),
      uiOutput(
        outputId = "color",
        style = "display: inline-block; margin: 60px 26px;"
      )
    ),
    column(
      width = 6,
      noUiSliderInput(
        inputId = "redb", min = 0, max = 255,
        value = 127, tooltips = FALSE,
        step = 1, orientation = "vertical",
        direction = "rtl",
        color = "#c0392b", inline = TRUE,
        height = "200px", width = "30px"
      ),
      noUiSliderInput(
        inputId = "greenb", min = 0, max = 255,
        value = 127, tooltips = FALSE,
        step = 1, orientation = "vertical",
        direction = "rtl",
        color = "#27ae60", inline = TRUE,
        height = "200px", width = "30px"
      ),
      noUiSliderInput(
        inputId = "blueb", min = 0, max = 255,
        value = 127, tooltips = FALSE,
        step = 1, orientation = "vertical",
        direction = "rtl",
        color = "#2980b9", inline = TRUE,
        height = "200px", width = "30px"
      ),
      uiOutput(
        outputId = "colorb",
        style = "display: inline-block; margin: 60px 26px;"
      )
    )
  )

)

server <- function(input, output, session) {

  output$color <- renderUI({
    tags$div(
      style = "height: 100px; width: 100px;",
      style = "border: 1px solid #fff; box-shadow: 0 0 10px;",
      style = paste0("background: ", rgb(input$red/255, input$green/255, input$blue/255), ";")
    )
  })

  output$colorb <- renderUI({
    tags$div(
      style = "height: 100px; width: 100px;",
      style = "border: 1px solid #fff; box-shadow: 0 0 10px;",
      style = paste0("background: ", rgb(input$redb/255, input$greenb/255, input$blueb/255), ";")
    )
  })

}

shinyApp(ui, server)

