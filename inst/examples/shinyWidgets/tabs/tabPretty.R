
.shinyWidgetGalleryFuns$tabPretty <- function() {
  tagList(
    tags$h1("Pretty Checkboxes And Radios", class = "fw-bold text-primary"),
    tags$h5(
      "via ",
      tags$a(href = "https://lokesh-coder.github.io/pretty-checkbox/", "pretty checkbox")
    ),
    br(),

    fluidRow(

      column(
        width = 4,

        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Default single checkbox",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = prettyCheckbox,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Click me!", value = TRUE)
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "With status",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = prettyCheckbox,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Click me!", value = TRUE,
                        status = "warning")
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "With curve shape",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = prettyCheckbox,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Click me!", value = TRUE,
                        status = "danger", shape = "curve")
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "With outline color",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = prettyCheckbox,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Click me!", value = TRUE,
                        status = "danger", shape = "curve", outline = TRUE)
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "With fill color",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = prettyCheckbox,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Click me!", value = TRUE,
                        status = "success", fill = TRUE)
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "With Font Awesome icon",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = prettyCheckbox,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Click me!", value = TRUE,
                        status = "info", icon = icon("thumbs-up"), plain = TRUE, outline = TRUE)
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "With animation",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = prettyCheckbox,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Click me!", value = TRUE,
                        icon = icon("check"), status = "success", animation = "rotate")
          )
        )

      ),

      column(
        width = 4,

        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Default switch",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = prettySwitch,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Click me!")
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Switch fill & status",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = prettySwitch,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Click me!", status = "success", fill = TRUE)
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Switch slim & status",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = prettySwitch,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Click me!", status = "primary", slim = TRUE)
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Default toggle",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = prettyToggle,
            args = list(inputId = ID(.shinyWidgetGalleryId), label_on = "Checked!",
                        label_off = "Unchecked...")
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Toggle with icons & status",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = prettyToggle,
            args = list(inputId = ID(.shinyWidgetGalleryId),
                        label_on = "Yes!", icon_on = icon("check"),
                        status_on = "info", status_off = "warning",
                        label_off = "No..", icon_off = icon("xmark"))
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Toggle with icons",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = prettyToggle,
            args = list(inputId = ID(.shinyWidgetGalleryId), label_on = "Yes!",
                        label_off = "No..", outline = TRUE,
                        plain = TRUE,
                        icon_on = icon("thumbs-up"),
                        icon_off = icon("thumbs-down"))
          )
        )

      ),

      column(
        width = 4,

        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Default checkbox group",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = prettyCheckboxGroup,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Choose:", choices = c("Click me !", "Me !", "Or me !"))
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Inline checkbox group & fill status",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = prettyCheckboxGroup,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Choose:", choices = c("Click me !", "Me !", "Or me !"),
                        inline = TRUE, status = "danger", fill = TRUE)
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Checkbox group with icons",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = prettyCheckboxGroup,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Choose:", choices = c("Click me !", "Me !", "Or me !"),
                        icon = icon("user"), animation = "tada")
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Checkbox group with icons, status & outline",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = prettyCheckboxGroup,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Choose:", choices = c("Click me !", "Me !", "Or me !"),
                        icon = icon("square-check"), status = "primary", outline = TRUE, animation = "jelly")
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Default radio buttons",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = prettyRadioButtons,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Choose:", choices = c("Click me !", "Me !", "Or me !"))
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Inline radio buttons & fill status",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = prettyRadioButtons,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Choose:", choices = c("Click me !", "Me !", "Or me !"),
                        inline = TRUE, status = "danger", fill = TRUE)
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Radio buttons with icons",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = prettyRadioButtons,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Choose:", choices = c("Click me !", "Me !", "Or me !"),
                        icon = icon("user"), animation = "tada")
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Radio buttons with icons, status",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = prettyRadioButtons,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Choose:", choices = c("Click me !", "Me !", "Or me !"),
                        icon = icon("check"), bigger = TRUE,
                        status = "info", animation = "jelly")
          )
        )

      )

    )
  )
}
