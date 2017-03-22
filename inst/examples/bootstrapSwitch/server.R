
# ------------------------------------------------------------------------ #
#
# Descriptif : Bootstrap Switch
#     Detail : http://www.bootstrap-switch.org/examples.html
#
#
# Auteur : Victor PERRIER
#
# Date creation : 01/07/2016
# Date modification : 01/07/2016
#
# Version 1.0
#
# ------------------------------------------------------------------------ #



library("shiny")
library("shinyWidgets")

function(input, output, session) {

  lapply(
    X = seq_len(8),
    FUN = function(i) {
      output[[paste0("res", i)]] <- renderPrint({
        input[[paste0("switch", i)]]
      })
    }
  )

  output$resbox1 <- renderPrint({
    input$box1
  })


  observeEvent(input$vrai, {
    updateSwitchInput(session = session, inputId = "switchUp", value = TRUE)
  })
  observeEvent(input$faux, {
    updateSwitchInput(session = session, inputId = "switchUp", value = FALSE)
  })
  output$resup1 <- renderPrint({
    input$switchUp
  })
}
