
# ------------------------------------------------------------------------ #
#
# Descriptif : Select picker
#     Detail : https://silviomoreto.github.io/bootstrap-select/examples/
#
#
# Auteur : Victor PERRIER
#
# Date creation : 08/09/2016
# Date modification : 08/09/2016
#
# Version 1.0
#
# ------------------------------------------------------------------------ #



library("shiny")
library("shinyWidgets")

function(input, output, session) {

  lapply(
    X = seq_len(20),
    FUN = function(i) {
      output[[paste0("res", i)]] <- renderPrint({
        input[[paste0("id", i)]]
      })
    }
  )

  observeEvent(input$update, {
    updatePickerInput(session = session, inputId = "id16", selected = input$update)
  })

  observeEvent(input$update2, {
    if (input$update2 == "lower") {
      updatePickerInput(session = session, inputId = "id17", choices = c("a", "b", "c", "d"))
    } else {
      updatePickerInput(session = session, inputId = "id17", choices = toupper(c("a", "b", "c", "d")))
    }
  })

}
