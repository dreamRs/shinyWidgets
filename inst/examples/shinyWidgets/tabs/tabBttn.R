
.shinyWidgetGalleryFuns$tabBttn <- function() {
  tagList(
    tags$h1("bttn", class = "fw-bold text-primary"),

    fluidRow(

      column(
        width = 4,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = NULL,
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = actionBttn,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = NULL, style = "material-circle", color = "danger", icon = icon("bars"))
          ),
          footer = NULL
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = NULL,
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = actionBttn,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "material-flat", style = "material-flat", color = "danger")
          ),
          footer = NULL
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = NULL,
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = actionBttn,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "pill", style = "pill", color = "danger")
          ),
          footer = NULL
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = NULL,
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = actionBttn,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "float", style = "float", color = "danger")
          ),
          footer = NULL
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = NULL,
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = actionBttn,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "unite", style = "unite", color = "danger")
          ),
          footer = NULL
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = NULL,
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = actionBttn,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "fill", style = "fill", color = "danger")
          ),
          footer = NULL
        )
      ),



      column(
        width = 4,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = NULL,
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = actionBttn,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = NULL, style = "simple", color = "primary", icon = icon("bars"))
          ),
          footer = NULL
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = NULL,
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = actionBttn,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "bordered", style = "bordered", color = "success", icon = icon("sliders"))
          ),
          footer = NULL
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = NULL,
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = actionBttn,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "minimal", style = "minimal", color = "danger")
          ),
          footer = NULL
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = NULL,
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = actionBttn,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "stretch", style = "stretch", color = "warning")
          ),
          footer = NULL
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = NULL,
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = actionBttn,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "jelly", style = "jelly", color = "danger")
          ),
          footer = NULL
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = NULL,
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = actionBttn,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "gradient", style = "gradient", color = "danger", icon = icon("thumbs-up"))
          ),
          footer = NULL
        )
      )
    )
  )
}
