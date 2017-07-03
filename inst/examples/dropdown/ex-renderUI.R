
library("shiny")
library("shinyWidgets")


# Countries
countries <- c(
  "United Kingdom", "Germany", "United States of America", "Belgium", "China", "Spain", "Netherlands", "Mexico",
  "Italy", "Canada", "Brazil", "Denmark", "Norway", "Switzerland", "Luxembourg", "Israel", "Russian Federation",
  "Turkey", "Saudi Arabia", "United Arab Emirates"
)
# Fruits
fruits <- c("Banana", "Blueberry", "Cherry", "Coconut", "Grapefruit", "Kiwi", "Lemon", "Lime", "Mango", "Orange", "Papaya")


ui <- fluidPage(
  radioButtons(inputId = "choices", label = "For pickerInput", choices = c("countries", "fruits")),
  dropdown(
    tags$p("Select adverts to drill down"),
    circle = TRUE, status = "default", icon = icon("sliders"), width = "300px",
    # animate = animateOptions(),
    uiOutput("choose_adverts")
  ),
  verbatimTextOutput(outputId = "res")
)

server <- function(input, output, session) {
  output$choose_adverts <- renderUI({
    if (input$choices == "countries") {
      adverts <- countries
    } else {
      adverts <- fruits
    }
    pickerInput(inputId = "Adverts",
                label = "Adverts",
                choices = adverts, # a list of strings
                options = list(`actions-box` = TRUE, `live-search` = TRUE),
                multiple = TRUE)
  })
  # outputOptions(output, "choose_adverts", suspendWhenHidden = FALSE)
  output$res <- renderPrint({
    input$Adverts
  })
}

shinyApp(ui = ui, server = server)
