

# airDatepicker examples --------------------------------------------------

library(shiny)
library(shinyWidgets)




# ui ----

ui <- fluidPage(
  tags$h2("Air datepicker examples"),
  tags$br(),

  fluidRow(

    column(
      width = 6,

      airDatepickerInput(
        inputId = "default",
        label = "First example:"
      ),
      verbatimTextOutput(outputId = "res_default"),

      airDatepickerInput(
        inputId = "multiple",
        label = "Select multiple dates:",
        placeholder = "You can pick 3 dates",
        multiple = 3, clearButton = TRUE
      ),
      verbatimTextOutput(outputId = "res_multiple"),

      airDatepickerInput(
        inputId = "range",
        label = "Select range of dates:",
        range = TRUE, value = c(Sys.Date()-7, Sys.Date())
      ),
      verbatimTextOutput(outputId = "res_range"),

      airDatepickerInput(
        inputId = "close",
        label = "Update when closing:",
        value = Sys.Date(), position = "right top",
        update_on = "close", addon = "left"
      ),
      verbatimTextOutput(outputId = "res_close"),

      airDatepickerInput(
        inputId = "french",
        label = "En fran\u00e7ais:",
        value = Sys.Date(),
        dateFormat = "dd MM yyyy",
        language = "fr"
      ),
      verbatimTextOutput(outputId = "res_french"),

      airDatepickerInput(
        inputId = "disable",
        label = "Disable some dates:",
        value = Sys.Date(), position = "top left",
        disabledDates = Sys.Date() + c(-9, -5, 2, 5, 8)
      ),
      verbatimTextOutput(outputId = "res_disable")

    ),

    column(
      width = 6,

      airDatepickerInput(
        inputId = "defaultValue",
        label = "With a default date:",
        value = Sys.Date()-7
      ),
      verbatimTextOutput(outputId = "res_defaultValue"),

      airDatepickerInput(
        inputId = "month",
        label = "Select months:",
        view = "months", minView = "months",
        dateFormat = "MM yyyy", monthsField = "months"
      ),
      verbatimTextOutput(outputId = "res_month"),

      airDatepickerInput(
        inputId = "minmax",
        label = "Min & max dates:",
        minDate = "2018-01-10", maxDate = "2018-01-21"
      ),
      verbatimTextOutput(outputId = "res_minmax"),

      airDatepickerInput(
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
  output$res_month <- renderPrint( str(input$month) )
  output$res_range <- renderPrint( str(input$range) )
  output$res_minmax <- renderPrint({ str(input$minmax) })
  output$res_close <- renderPrint({ str(input$close) })
  output$res_inline <- renderPrint({ str(input$inline) })
  output$res_french <- renderPrint({ str(input$french) })
  output$res_disable <- renderPrint({ str(input$disable) })

}

# app ----

shinyApp(ui = ui, server = server)

