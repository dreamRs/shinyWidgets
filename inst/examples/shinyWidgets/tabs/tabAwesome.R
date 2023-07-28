
.shinyWidgetGalleryFuns$tabAwesome <- function() {
  tagList(
    tags$h1("Awesome Checkboxes And Radios", class = "fw-bold text-primary"),
    tags$h5(
      "via ",
      tags$a(href = "http://flatlogic.github.io/awesome-bootstrap-checkbox/demo/", "awesome-bootstrap-checkbox")
    ),
    br(),

    fluidRow(
      column(
        width = 4,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Shiny default",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = checkboxInput,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "A single checkbox", value = TRUE)
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Shiny default",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = checkboxGroupInput,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Checkboxes", choices = c("A", "B", "C"), selected = "A")
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Shiny default",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = radioButtons,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Radio buttons", choices = c("A", "B", "C"))
          )
        )
      ),

      column(
        width = 4,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Single",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = awesomeCheckbox,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "A single checkbox", value = TRUE)
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Checkbox group",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = awesomeCheckboxGroup,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Checkboxes", choices = c("A", "B", "C"), selected = "A")
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Radio buttons",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = awesomeRadio,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Radio buttons", choices = c("A", "B", "C"), selected = "A")
          )
        )
      ),

      column(
        width = 4,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Another color",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = awesomeCheckbox,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "A single checkbox", value = TRUE, status = "info")
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Inline & danger",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = awesomeCheckboxGroup,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Checkboxes", choices = c("A", "B", "C"), selected = "A", inline = TRUE, status = "danger")
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Inline & success",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = awesomeRadio,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Radio buttons", choices = c("A", "B", "C"), selected = "A", inline = TRUE, status = "success")
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Inline & checkbox styled",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = awesomeRadio,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Radio buttons", choices = c("A", "B", "C"), selected = "A", inline = TRUE, checkbox =  TRUE)
          )
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Update selected",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = awesomeRadio,
            args = list(inputId = "upAwesomeRadio", label = "Radio buttons", choices = c("A", "B", "C"), selected = "A", inline = TRUE)
          ),
          br(),
          tags$p("Click to update :"),
          actionGroupButtons(inputIds = c("upAwesomeRadioA", "upAwesomeRadioB", "upAwesomeRadioC"), labels = c("A", "B", "C"))
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Update choices",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = awesomeCheckboxGroup,
            args = list(inputId = "upAwesomeCheckbox", label = "Checkbox group", choices = c("A", "B", "C"), selected = "A", inline = TRUE, status = "warning")
          ),
          br(),
          tags$p("Click to update :"),
          actionGroupButtons(inputIds = c("upAwesomeCheckbox1", "upAwesomeCheckbox2"), labels = c("tolower & success", "TOUPPER & warning"))
        )
      )
    )
  )
}
