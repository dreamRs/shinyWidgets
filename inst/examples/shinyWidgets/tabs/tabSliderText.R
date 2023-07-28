
.shinyWidgetGalleryFuns$tabSliderText <- function() {
  tagList(
    tags$h1("Slider Text", class = "fw-bold text-primary"),

    fluidRow(

      column(
        width = 4,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "With characters:",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = sliderTextInput,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Choose a letter:", choices = c("a", "b", "c", "d", "e"))
          )
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Range slider:",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = sliderTextInput,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Choose a range:", choices = month.abb, selected = month.abb[c(4, 8)])
          )
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Custom range for numeric:",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = sliderTextInput,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Choose a value:", choices = c(1, 10, 100, 500, 1000), grid = TRUE)
          )
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Decreasing order:",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = sliderTextInput,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Choose a value:", choices = seq(from = 10, to = 1, by = -1), grid = TRUE)
          )
        )
      ),

      column(
        width = 4,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "With month",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = sliderTextInput,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Pick a month:", choices = month.name)
          )
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Restricted choices",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = sliderTextInput,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Restricted choices:", choices = LETTERS,
                        selected = "A",
                        from_min = "E", from_max = "T")
          )
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Restricted choices",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = sliderTextInput,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Restricted choices for range:", choices = LETTERS,
                        selected = c("A", "T"),
                        from_min = "A", from_max = "E",
                        to_min = "R", to_max = "Z")
          )
        )
      ),

      column(
        width = 4,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Likert scale",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = sliderTextInput,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Your choice:", grid = TRUE, force_edges = TRUE,
                        choices = c("Strongly disagree", "Disagree", "Neither agree nor disagree", "Agree", "Strongly agree"))
          )
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Update selected",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = sliderTextInput,
            args = list(inputId = "selectedSliderText", label = "Your choice:", grid = TRUE, force_edges = TRUE,
                        choices = letters[1:5])
          ),
          br(),
          radioButtons(inputId = "upSelectedSliderText", label = "Update selected:", choices = letters[1:5], inline = TRUE)
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Update choices",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = sliderTextInput,
            args = list(inputId = "choicesSliderText", label = "Your choice:", grid = TRUE, force_edges = TRUE,
                        choices = month.abb)
          ),
          br(),
          radioButtons(inputId = "upChoicesSliderText", label = "Update selected:", choices = c("Abbreviations", "Full names"), inline = TRUE)
        )
      )

    )
  )
}
