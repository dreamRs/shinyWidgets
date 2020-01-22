if (interactive()) {
  library(shiny)
  library(shinyWidgets)

  ui <- fluidPage(
    tags$h3("drop example"),

    dropMenu(
      actionButton("go0", "See what"),
      tags$div(
        tags$h3("This is a dropdown"),
        tags$ul(
          tags$li("You can use HTML inside"),
          tags$li("Maybe Shiny inputs"),
          tags$li("And maybe outputs"),
          tags$li("and should work in markdown")
        )
      ),
      theme = "light-border",
      placement = "right",
      arrow = FALSE
    ),

    tags$br(),


    dropMenu(
      actionButton("go", "See what"),
      tags$h3("Some inputs"),
      sliderInput(
        "obs", "Number of observations:",
        min = 0, max = 1000, value = 500
      ),
      selectInput(
        "variable", "Variable:",
        c("Cylinders" = "cyl",
          "Transmission" = "am",
          "Gears" = "gear")
      ),
      pickerInput(
        inputId = "pckr",
        label = "Select all option",
        choices = rownames(mtcars),
        multiple = TRUE,
        options = list(`actions-box` = TRUE)
      ),
      radioButtons(
        "dist", "Distribution type:",
        c("Normal" = "norm",
          "Uniform" = "unif",
          "Log-normal" = "lnorm",
          "Exponential" = "exp")
      )
    ),
    verbatimTextOutput("slider"),
    verbatimTextOutput("select"),
    verbatimTextOutput("picker"),
    verbatimTextOutput("radio")
  )

  server <- function(input, output, session) {

    output$slider <- renderPrint(input$obs)
    output$select <- renderPrint(input$variable)
    output$picker <- renderPrint(input$pckr)
    output$radio <- renderPrint(input$dist)

  }

  shinyApp(ui, server)
}
