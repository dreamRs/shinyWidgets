
.shinyWidgetGalleryFuns$tabswitchInput <- function() {
  tagList(
    tags$h1("switchInput", class = "fw-bold text-primary"),
    tags$h5(
      "via ",
      tags$a(href = "http://www.bootstrap-switch.org/examples.html", "bootstrap-switch.org")
    ),
    br(),

    fluidRow(
      column(
        width = 4,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Default",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = switchInput,
            args = list(inputId = ID(.shinyWidgetGalleryId))
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "TRUE at start",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = switchInput,
            args = list(inputId = ID(.shinyWidgetGalleryId), value = TRUE)
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Change ON/OFF labels",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = switchInput,
            args = list(inputId = ID(.shinyWidgetGalleryId), onLabel = "Yes", offLabel = "No")
          )
        )
      )
      ,
      column(
        width = 4,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Change ON/OFF colors",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = switchInput,
            args = list(inputId = ID(.shinyWidgetGalleryId), onStatus = "success", offStatus = "danger")
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Label in the middle",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = switchInput,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "My label", labelWidth = "80px")
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Size : mini",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = switchInput,
            args = list(inputId = ID(.shinyWidgetGalleryId), size = "mini")
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Size : large",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = switchInput,
            args = list(inputId = ID(.shinyWidgetGalleryId), size = "large")
          )
        )
      )
      ,
      column(
        width = 4,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Icon in the middle",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = switchInput,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "<i class=\"fa fa-thumbs-up\"></i>")
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Update value",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = switchInput,
            args = list(inputId = "switchUp", label = "<i class=\"fa fa-thumbs-up\"></i>")
          ),
          br(),
          tags$p("Click to update :"),
          actionGroupButtons(inputIds = c("on", "off"), labels = c("ON", "OFF"))
        )
      )
    )
  )
}
