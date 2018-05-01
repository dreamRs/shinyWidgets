

# airYearpicker examples --------------------------------------------------

library(shiny)
library(shinyWidgets)



# ui ----

ui <- fluidPage(
  tags$h2("Air yearpicker examples"),
  tags$br(),

  fluidRow(

    column(
      width = 6,

      airYearpickerInput(
        inputId = "default",
        label = "First example:"
      ),
      verbatimTextOutput(outputId = "res_default"),

      airYearpickerInput(
        inputId = "multiple",
        label = "Select multiple years:",
        placeholder = "You can pick 3 years",
        multiple = 3, clearButton = TRUE
      ),
      verbatimTextOutput(outputId = "res_multiple"),

      airYearpickerInput(
        inputId = "range",
        label = "Select range of years:",
        range = TRUE, value = c(Sys.Date()-365*3, Sys.Date())
      ),
      verbatimTextOutput(outputId = "res_range")

    ),

    column(
      width = 6,

      airYearpickerInput(
        inputId = "defaultValue",
        label = "With a default year:",
        value = Sys.Date()
      ),
      verbatimTextOutput(outputId = "res_defaultValue"),

      airYearpickerInput(
        inputId = "minmax",
        label = "Min & max year:",
        minDate = "2011-01-01", maxDate = "2018-01-01"
      ),
      verbatimTextOutput(outputId = "res_minmax"),

      airYearpickerInput(
        inputId = "inline",
        label = "Inline:",
        inline = TRUE
      ),
      verbatimTextOutput(outputId = "res_inline")

    )

  )
)

# server ----

server <- function(input, output, session) {

  output$res_default <- renderPrint( str(input$default) )
  output$res_defaultValue <- renderPrint( str(input$defaultValue) )
  output$res_multiple <- renderPrint( str(input$multiple) )
  output$res_range <- renderPrint( str(input$range) )
  output$res_minmax <- renderPrint({ str(input$minmax) })
  output$res_inline <- renderPrint({ str(input$inline) })

}

# app ----

shinyApp(ui = ui, server = server)
