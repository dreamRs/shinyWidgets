
.shinyWidgetGalleryFuns$tabAirDate <- function() {
  tagList(
    tags$h1("Air Datepicker", class = "fw-bold text-primary"),
    tags$h5(
      "via ",
      tags$a(href = "https://github.com/t1m0n/air-datepicker", "air-datepicker")
    ),
    br(),

    fluidRow(
      column(
        width = 4,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Default",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = airDatepickerInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Default :",
              value = Sys.Date(),
              width = "100%"
            )
          )
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Multiple",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = airDatepickerInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Multiple :",
              value = Sys.Date() + c(-4, 2, 5),
              multiple = TRUE,
              clearButton = TRUE,
              width = "100%"
            )
          )
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Range",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = airDatepickerInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Range :",
              value = c(Sys.Date(), Sys.Date() + 7),
              range = TRUE,
              width = "100%"
            )
          )
        )
      ),

      column(
        width = 4,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "With timepicker",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = airDatepickerInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "With timepicker :",
              value = NULL,
              timepicker = TRUE,
              timepickerOpts = timepickerOptions(
                hoursStep = 1,
                minutesStep = 30
              ),
              width = "100%"
            )
          )
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Disabled dates",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = airDatepickerInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Disabled dates :",
              value = NULL,
              disabledDates = Sys.Date() + c(-1, 1),
              width = "100%"
            )
          )
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Min & max dates",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = airDatepickerInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Min & max dates :",
              value = NULL,
              minDate = Sys.Date() - 7,
              maxDate = Sys.Date() + 7,
              width = "100%"
            )
          )
        )
      ),

      column(
        width = 4,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Month picker",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = airMonthpickerInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Month picker :",
              value = Sys.Date(),
              dateFormat = "MMMM yyyy",
              width = "100%"
            )
          )
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Year picker",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = airYearpickerInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Year picker :",
              value = Sys.Date(),
              width = "100%"
            )
          )
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Language & format",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = airDatepickerInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Language & format :",
              value = Sys.Date(),
              dateFormat = "dd/MM/yyyy",
              language = "ko",
              width = "100%"
            )
          )
        )
      )
    )
  )
}
