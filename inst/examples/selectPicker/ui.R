
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




# Bootstrap switch --------------------------------------------------------


library("shiny")
library("shinyWidgets")

basicPanel <- function(..., width = 4) {
  column(
    width = width,
    tags$div(
      class="panel panel-default", style="border: 1px solid; border-color: steelblue;",
      tags$div(
        class="panel-body",
        ...
      )
    )
  )
}




fluidPage(
  tags$h1("Select Picker Gallery", style="color: steelblue;"),
  tags$h5(
    "via ",
    tags$a(href = "https://silviomoreto.github.io/bootstrap-select/examples/", "select-picker"),
    style="color: steelblue;"
  ),


  fluidRow(

    basicPanel(
      pickerInput(inputId = "id1", label = "Default", choices = c("a", "b", "c", "d")),
      verbatimTextOutput("res1")
    ),

    basicPanel(
      pickerInput(
        inputId = "id2", label = "Options group",
        choices = list(lower = c("a", "b", "c", "d"), upper = c("A", "B", "C", "D"))
      ),
      verbatimTextOutput("res2")
    ),

    basicPanel(
      pickerInput(
        inputId = "id3", label = "Multiple", choices = attr(UScitiesD, "Labels"), multiple = TRUE
      ),
      verbatimTextOutput("res3")
    ),

    basicPanel(
      pickerInput(
        inputId = "id4", label = "Live search", choices = attr(UScitiesD, "Labels"),
        options = list("live-search" = TRUE)
      ),
      verbatimTextOutput("res4")
    ),

    basicPanel(
      pickerInput(
        inputId = "id5", label = "Placeholder", choices = c("a", "b", "c", "d"),
        options = list(title = "This is a placeholder")
      ),
      verbatimTextOutput("res5")
    ),

    basicPanel(
      pickerInput(
        inputId = "id6", label = "Selected text format (select >3 items)", choices = LETTERS,
        options = list(`selected-text-format` = "count > 3"), multiple = TRUE
      ),
      verbatimTextOutput("res6")
    ),

    basicPanel(
      pickerInput(
        inputId = "id7", label = "Style : primary", choices = c("a", "b", "c", "d"),
        options = list(`style` = "btn-primary")
      ),
      verbatimTextOutput("res7")
    ),

    basicPanel(
      pickerInput(
        inputId = "id8", label = "Style : danger", choices = c("a", "b", "c", "d"),
        options = list(`style` = "btn-danger")
      ),
      verbatimTextOutput("res8")
    ),

    basicPanel(
      pickerInput(
        inputId = "id9", label = "Style individual options",
        choices = c("steelblue 150%", "right align + red", "bold", "background color"),
        choicesOpt = list(
          style = c("color: steelblue; font-size: 150%;", "color: firebrick; text-align: right;",
                    "font-weight: bold;",
                    "background: forestgreen; color: white;")
        )
      ),
      verbatimTextOutput("res9")
    ),

    basicPanel(
      pickerInput(
        inputId = "id19", label = "Style individual options",
        choices = paste("Badge", c("info", "success", "danger", "primary", "warning")),
        choicesOpt = list(
          content=sprintf(
            "<span class='label label-%s'>%s</span>", c("info", "success", "danger", "primary", "warning"),
            paste("Badge", c("info", "success", "danger", "primary", "warning"))
          )
        )
      ),
      verbatimTextOutput("res19")
    ),

    basicPanel(
      pickerInput(
        inputId = "id001", label = "width: 'auto'",
        choices = c("a", "b", "c", "ddddddddddddddddddddddddddd"), width = "auto"
      ),
      pickerInput(
        inputId = "id002", label = "width: 'fit'",
        choices = c("a", "b", "c", "ddddddddddddddddddddddddddd"), width = "fit"
      ),
      pickerInput(
        inputId = "id003", label = "width: '100px'",
        choices = c("a", "b", "c", "ddddddddddddddddddddddddddd"), width = "100px"
      ),
      pickerInput(
        inputId = "id004", label = "width: '75%'",
        choices = c("a", "b", "c", "ddddddddddddddddddddddddddd"), width = "75%"
      )
    ),

    basicPanel(
      pickerInput(
        inputId = "id10", label = "Glyphicon",
        choices = c("glyphicon-cog", "glyphicon-play", "glyphicon-ok-sign",
                    "glyphicon-arrow-right", "glyphicon-euro", "glyphicon-music"),
        choicesOpt = list(
          icon = c("glyphicon-cog", "glyphicon-play", "glyphicon-ok-sign",
                   "glyphicon-arrow-right", "glyphicon-euro", "glyphicon-music")
        )
      ),
      verbatimTextOutput("res10")
    ),

    basicPanel(
      pickerInput(
        inputId = "id11", label = "Subtext",
        choices = rownames(mtcars),
        choicesOpt = list(
          subtext = paste("mpg", mtcars$mpg, sep =": ")
        )
      ),
      verbatimTextOutput("res11")
    ),

    basicPanel(
      pickerInput(
        inputId = "id12", label = "Menu size (5 items visible)", choices = LETTERS,
        options = list(`size` = 5)
      ),
      verbatimTextOutput("res12")
    ),

    basicPanel(
      pickerInput(
        inputId = "id13", label = "Select/deselect all options", choices = LETTERS,
        options = list(`actions-box` = TRUE), multiple = TRUE
      ),
      verbatimTextOutput("res13")
    ),

    basicPanel(
      pickerInput(
        inputId = "id14", label = "c selected by default", choices = c("a", "b", "c", "d"),
        selected = "c"
      ),
      verbatimTextOutput("res14")
    ),

    # basicPanel(
    #   pickerInput(inputId = "id15", label = NULL, choices = NULL),
    #   verbatimTextOutput("res15")
    # ),

    basicPanel(
      pickerInput(inputId = "id16", label = "Update selected", choices = c("a", "b", "c", "d")),
      radioButtons(inputId = "update", label = "Update", choices = c("a", "b", "c", "d"), inline = TRUE),
      verbatimTextOutput("res16")
    ),

    basicPanel(
      pickerInput(inputId = "id17", label = "Update choices... BUG!!!", choices = c("a", "b", "c", "d")),
      radioButtons(inputId = "update2", label = "Update", choices = c("lower", "upper"), inline = TRUE),
      verbatimTextOutput("res17"),
      tags$button("test", onclick = "$('#id17').selectpicker('refresh');")
    ),

    basicPanel(
      pickerInput(inputId = "id18", label = "Inline", choices = c("a", "b", "c", "d"), inline = TRUE),
      verbatimTextOutput("res18")
    )
  )
)
