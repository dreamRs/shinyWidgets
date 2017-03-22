
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




# Bootstrap switch --------------------------------------------------------


library("shiny")
library("shinyWidgets")


fluidPage(
  tags$h1("Bootstrap switch", style="color: steelblue;"),
  tags$h5("via ",
          tags$a(href = "http://www.bootstrap-switch.org/examples.html", "bootstrap-switch.org"),
          style="color: steelblue;"),


  fluidRow(
    column(
      width = 3,
      tags$p("Default"),
      switchInput(inputId = "switch1"),
      verbatimTextOutput("res1")
    ),
    column(
      width = 3,
      tags$p("TRUE at start"),
      switchInput(inputId = "switch2", value = TRUE),
      verbatimTextOutput("res2")
    ),
    column(
      width = 3,
      tags$p("Change ON/OFF labels"),
      switchInput(inputId = "switch3", onLabel = "Oui", offLabel = "Non"),
      verbatimTextOutput("res3")
    ),
    column(
      width = 3,
      tags$p("Change ON/OFF colors"),
      switchInput(inputId = "switch4", onStatus = "success", offStatus = "danger"),
      verbatimTextOutput("res4")
    )
  ),
  br(),
  fluidRow(
    column(
      width = 3,
      tags$p("Label in the middle"),
      switchInput(inputId = "switch5", label = "Un label"),
      verbatimTextOutput("res5")
    ),
    column(
      width = 3,
      tags$p("Size : mini"),
      switchInput(inputId = "switch6", size = "mini"),
      verbatimTextOutput("res6")
    ),
    column(
      width = 3,
      tags$p("Size : large"),
      switchInput(inputId = "switch7", size = "large"),
      verbatimTextOutput("res7")
    ),
    column(
      width = 3,
      tags$p("No conflict"),
      checkboxInput(inputId = "box1", label = "checkbox classique"),
      verbatimTextOutput("resbox1")
    )
  ),

  fluidRow(
    column(
      width = 3,
      tags$p("Update exemple :"),
      switchInput(inputId = "switchUp"),
      splitLayout(
        actionButton(inputId = "vrai", label = "Set to TRUE"),
        actionButton(inputId = "faux", label = "Set to FALSE")
      ),
      verbatimTextOutput("resup1")
    ),
    column(
      width = 3,
      tags$p("Disabled"),
      switchInput(inputId = "switch8", disabled = TRUE),
      verbatimTextOutput("res8")
    )
  )

)
