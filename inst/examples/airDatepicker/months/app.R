

# airMonthpicker examples --------------------------------------------------

library(shiny)
library(shinyWidgets)



# ui ----

ui <- fluidPage(
  tags$h2("Air monthpicker examples"),
  tags$br(),

  fluidRow(

    column(
      width = 6,

      airMonthpickerInput(
        inputId = "default",
        label = "First example:"
      ),
      verbatimTextOutput(outputId = "res_default"),

      airMonthpickerInput(
        inputId = "multiple",
        label = "Select multiple months:",
        placeholder = "You can pick 3 months",
        multiple = 3, clearButton = TRUE
      ),
      verbatimTextOutput(outputId = "res_multiple"),

      airMonthpickerInput(
        inputId = "range",
        label = "Select range of months:",
        range = TRUE, value = c(Sys.Date()-60, Sys.Date())
      ),
      verbatimTextOutput(outputId = "res_range")

    ),

    column(
      width = 6,

      airMonthpickerInput(
        inputId = "defaultValue",
        label = "With a default month:",
        value = Sys.Date()
      ),
      verbatimTextOutput(outputId = "res_defaultValue"),

      airMonthpickerInput(
        inputId = "minmax",
        label = "Min & max month (only 2018):",
        minDate = "2018-01-01", maxDate = "2018-12-01"
      ),
      verbatimTextOutput(outputId = "res_minmax"),

      airMonthpickerInput(
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

