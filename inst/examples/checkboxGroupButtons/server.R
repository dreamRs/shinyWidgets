
# ------------------------------------------------------------------------ #
#
# Descriptif : Checkbox Group Buttons : fonctions R
#     Detail : http://getbootstrap.com/javascript/#buttons-checkbox-radio
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


# checkboxGroupButtons ----------------------------------------------------

library("shiny")
library("shinyWidgets")

function(input, output, session) {


  lapply(
    X = seq_len(12),
    FUN = function(x) {
      output[[paste0("res", x)]] <- renderPrint({
        input[[paste0("test", x)]]
      })
    }
  )

  observeEvent(input$maj, {
    if (input$maj != "Aucun") {
      updateCheckboxGroupButtons(session = session, inputId = "test10", selected = input$maj)
    }
  })

  output$resverif <- renderPrint({
    input$verif
  })

  output$verifDT <- renderDataTable({
    head(iris)
  })

}
