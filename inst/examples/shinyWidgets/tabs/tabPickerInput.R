

.shinyWidgetGalleryFuns$tabPickerInput <- function() {
  tagList(
    tags$h1("Select Picker", class = "fw-bold text-primary"),
    tags$h5(
      "via ",
      tags$a(href = "https://github.com/snapappointments/bootstrap-select", "bootstrap-select")
    ),
    br(),

    fluidRow(
      column(
        width = 4,

        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Default",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = pickerInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Default",
              choices = c("a", "b", "c", "d"),
              options = pickerOptions(container = "body"),
              width = "100%"
            )
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Options group",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = pickerInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Options group",
              choices = list(
                lower = c("a", "b", "c", "d"),
                upper = c("A", "B", "C", "D")
              ),
              options = pickerOptions(container = "body"),
              width = "100%"
            )
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Multiple",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = pickerInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Multiple",
              choices = attr(UScitiesD, "Labels"),
              multiple = TRUE,
              options = pickerOptions(container = "body"),
              width = "100%"
            )
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Live search",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = pickerInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Live search",
              choices = attr(UScitiesD, "Labels"),
              options = pickerOptions(container = "body", liveSearch = TRUE),
              width = "100%"
            )
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Menu size",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = pickerInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Menu size (5 items visible)",
              choices = LETTERS,
              options = pickerOptions(container = "body", size = 5),
              width = "100%"
            )
          )
        )

      ),

      column(
        width = 4,

        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Placeholder",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = pickerInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Placeholder",
              choices = c("a", "b", "c", "d"),
              options = pickerOptions(container = "body", title = "This a placeholder"),
              width = "100%"
            )
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Selected text format",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = pickerInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Selected text format (select >3 items)",
              choices = LETTERS,
              multiple = TRUE,
              options = pickerOptions(container = "body", selectedTextFormat = "count > 3"),
              width = "100%"
            )
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Style : primary",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = pickerInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Style : primary",
              choices = c("a", "b", "c", "d"),
              options = pickerOptions(container = "body", style = "btn-outline-primary"),
              width = "100%"
            )
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Style : danger",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = pickerInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Style : danger",
              choices = c("a", "b", "c", "d"),
              options = pickerOptions(container = "body", style = "btn-danger"),
              width = "100%"
            )
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Style individual options",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = pickerInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Style individual options with HTML",
              choices = c("steelblue 150%", "right align + red", "bold", "background color"),
              choicesOpt = list(
                style = c(
                  "color: steelblue; font-size: 150%;",
                  "color: firebrick; text-align: right;",
                  "font-weight: bold;",
                  "background: forestgreen; color: white;"
                )
              ),
              options = pickerOptions(container = "body"),
              width = "100%"
            )
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Style individual options (preserved)",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = pickerInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Style individual options with HTML",
              choices = c("steelblue 150%", "right align + red", "bold", "background color"),
              choicesOpt = list(
                content = c(
                  "<div style='color: steelblue; font-size: 150%;'>steelblue 150%</div>",
                  "<div style='color: firebrick; text-align: right;'>right align + red</div>",
                  "<div style='font-weight: bold;'>bold</div>",
                  "<div style='background: forestgreen; color: white; padding-left: 5px;'>background color</div>"
                )
              ),
              options = pickerOptions(container = "body"),
              width = "100%"
            )
          )
        )

      ),

      column(
        width = 4,

        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Icons",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = pickerInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "FontAwesome icons",
              choices = c(
                "fa-gear",
                "fa-play",
                "fa-check",
                "fa-arrow-right",
                "fa-euro-sign",
                "fa-music"
              ),
              choicesOpt = list(
                icon = c(
                  "fa-gear",
                  "fa-play",
                  "fa-check",
                  "fa-arrow-right",
                  "fa-euro-sign",
                  "fa-music"
                )
              ),
              options = pickerOptions(container = "body", iconBase = "fas"),
              width = "100%"
            )
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Subtext",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = pickerInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Subtext",
              choices = rownames(mtcars),
              choicesOpt = list(
                subtext = paste("mpg", mtcars$mpg, sep = ": ")
              ),
              options = pickerOptions(container = "body"),
              width = "100%"
            )
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Select/deselect all",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = pickerInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Select/deselect all options",
              choices = LETTERS,
              multiple = TRUE,
              options = pickerOptions(container = "body", actionsBox = TRUE),
              width = "100%"
            )
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Update choices",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = pickerInput,
            args = list(
              inputId = "uppickerIcons",
              label = "Glyphicon <> FontAwesome",
              choices = c(
                "glyphicon-arrow-right / fa-arrow-right",
                "glyphicon-cog / fa-gear",
                "glyphicon-play / fa-play",
                "glyphicon-ok-sign / fa-check",
                "glyphicon-euro / fa-eur",
                "glyphicon-music / fa-music"
              ),
              choicesOpt = list(
                icon = c(
                  "glyphicon glyphicon-arrow-right",
                  "glyphicon glyphicon-cog",
                  "glyphicon glyphicon-play",
                  "glyphicon glyphicon-ok-sign",
                  "glyphicon glyphicon-euro",
                  "glyphicon glyphicon-music"
                )
              ),
              options = pickerOptions(iconBase = "", container = "body"),
              width = "100%"
            )
          ),
          br(),
          radioButtons(
            inputId = "uppickerIconsRadio",
            label = "Update with Icons",
            choices = c("Glyphicon", "FontAwesome"),
            inline = TRUE
          )
        )

      )

    )
  )
}
