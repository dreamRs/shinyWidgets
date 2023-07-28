
.shinyWidgetGalleryFuns$tabMaterialSwitch <- function() {
  tagList(
    tags$h1("Material switch", class = "fw-bold text-primary"),
    tags$h5(
      "via ",
      tags$a(href = "http://bootsnipp.com/snippets/featured/material-design-switch", "material-design-switch"),
      style="color: #d9534f;"
    ),
    br(),

    fluidRow(

      column(
        width = 4,

        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Default",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = materialSwitch,
            args = list(inputId = ID(.shinyWidgetGalleryId))
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Label on left",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = materialSwitch,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "A label")
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Label on right",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = materialSwitch,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "A label", right = TRUE)
          )
        )

      ),

      column(
        width = 4,

        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Status primary",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = materialSwitch,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Primary", value = TRUE, status = "primary")
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Status danger",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = materialSwitch,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Danger", value = TRUE, status = "danger")
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Status success",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = materialSwitch,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Success", value = TRUE, status = "success")
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Status warning",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = materialSwitch,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Warning", value = TRUE, status = "warning")
          )
        )

      ),

      column(
        width = 4,

        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Update",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = materialSwitch,
            args = list(inputId = "upMaterial", label = "Update value", value = FALSE, status = "info")
          ),
          br(),
          tags$p("Click to update :"),
          actionGroupButtons(inputIds = c("upMaterialY", "upMaterialN"), labels = c("TRUE", "FALSE"))
        )
      )

    )
  )
}
