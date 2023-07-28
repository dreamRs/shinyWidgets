
.shinyWidgetGalleryFuns$tabcheckButtons <- function() {
  tagList(

    tags$h1("Turn buttons into checkbox", class = "fw-bold text-primary"),
    br(),

    fluidRow(

      column(
        width = 4,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Default",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = checkboxGroupButtons,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("A", "B", "C"))
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "With choices",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = checkboxGroupButtons,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("A", "B", "C", "D"), selected = c("B", "D"))
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Danger status",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = checkboxGroupButtons,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("A", "B", "C", "D"), status = "danger")
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Success status",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = checkboxGroupButtons,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("A", "B", "C", "D"), status = "success")
          )
        )
      ),

      column(
        width = 4,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Justified",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = checkboxGroupButtons,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("A", "B"), justified = TRUE)
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Vertical",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = checkboxGroupButtons,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("A", "B", "C", "D"), direction = "vertical")
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Large",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = checkboxGroupButtons,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("A", "B", "C", "D"), size = "lg")
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Update",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = checkboxGroupButtons,
            args = list(inputId = "upcheckboxGroupButtons", label = "Label", choices = c("A", "B", "C", "D"),
                        checkIcon = list(yes = icon("ok", lib = "glyphicon")))
          ),
          br(),
          tags$p("Click to update :"),
          actionGroupButtons(inputIds = c("upCheckBtnA", "upCheckBtnB", "upCheckBtnC", "upCheckBtnD"), labels = c("A", "B", "C", "D"))
        )
      ),

      column(
        width = 4,

        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Large",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = checkboxGroupButtons,
            args = list(
              inputId = ID(.shinyWidgetGalleryId), label = "Choose a graph :",
              choices = c(
                "<i class='fa fa-bar-chart'></i>" = "bar",
                "<i class='fa fa-line-chart'></i>" = "line",
                "<i class='fa fa-pie-chart'></i>" = "pie"
              ), justified = TRUE
            )
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Icons",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = checkboxGroupButtons,
            args = list(
              inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("A", "B", "C", "D"), justified = TRUE,
              checkIcon = list(yes = icon("ok", lib = "glyphicon"))
            )
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "More icons",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = checkboxGroupButtons,
            args = list(
              inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("A", "B", "C", "D"), status = "primary",
              checkIcon = list(yes = icon("ok", lib = "glyphicon"), no = icon("xmark", lib = "glyphicon"))
            )
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Colored icons",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = checkboxGroupButtons,
            args = list(
              inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("Option 1", "Option 2", "Option 3", "Option 4"),
              checkIcon = list(yes = tags$i(class = "fa fa-check-square", style = "color: steelblue"),
                               no = tags$i(class = "fa fa-square-o", style = "color: steelblue")))
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Separated buttons",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = checkboxGroupButtons,
            args = list(
              inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("Option 1", "Option 2", "Option 3", "Option 4"), individual = TRUE,
              checkIcon = list(yes = tags$i(class = "fa fa-circle", style = "color: steelblue"),
                               no = tags$i(class = "fa fa-circle-o", style = "color: steelblue"))
            )
          )
        )

      )
    )
  )
}
