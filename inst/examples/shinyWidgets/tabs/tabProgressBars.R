
.shinyWidgetGalleryFuns$tabProgressBars <- function() {
  tagList(
    tags$h1("Progress Bars", class = "fw-bold text-primary"),

    fluidRow(
      column(
        width = 6,

        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Default",
          shinyWidgets::progressBar(id = "pb1", value = 50),
          sliderInput(inputId = "uppb1", label = "Update", min = 0, max = 100, value = 50),
          .shinyWidgetGalleryFuns$pb_code(
            id = "pb1",
            'progressBar(id = "pb1", value = 50)',
            'updateProgressBar(session = session, id = "pb1", value = input$slider)'
          )
        ),

        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Status : info & title",
          shinyWidgets::progressBar(id = "pb2", value = 50, status = "info", title = "This is a progress bar"),
          sliderInput(inputId = "uppb2", label = "Update", min = 0, max = 100, value = 50),
          .shinyWidgetGalleryFuns$pb_code(
            id = "pb2",
            'progressBar(id = "pb2", value = 50, status = "info", title = "This is a progress bar")',
            'updateProgressBar(session = session, id = "pb2", value = input$slider)'
          )
        ),

        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Status : danger & striped : true",
          shinyWidgets::progressBar(id = "pb3", value = 50, status = "danger", striped = TRUE),
          sliderInput(inputId = "uppb3", label = "Update", min = 0, max = 100, value = 50),
          .shinyWidgetGalleryFuns$pb_code(
            id = "pb3",
            'progressBar(id = "pb3", value = 50, status = "danger", striped = TRUE)',
            'updateProgressBar(session = session, id = "pb3", value = input$slider)'
          )
        )

      ),
      column(
        width = 6,

        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Display : percent",
          shinyWidgets::progressBar(id = "pb4", value = 50, display_pct = TRUE),
          sliderInput(inputId = "uppb4", label = "Update", min = 0, max = 100, value = 50, step = 5),
          .shinyWidgetGalleryFuns$pb_code(
            id = "pb4",
            'progressBar(id = "pb4", value = 50, display_pct = TRUE)',
            'updateProgressBar(session = session, id = "pb4", value = input$slider)'
          )
        ),

        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Status : warning & value > 100 (force value and total to appear)",
          shinyWidgets::progressBar(id = "pb5", value = 1500, total = 5000, status = "warning"),
          sliderInput(inputId = "uppb5", label = "Update", min = 0, max = 5000, value = 50),
          .shinyWidgetGalleryFuns$pb_code(
            id = "pb5",
            'progressBar(id = "pb5", value = 1500, total = 5000, status = "warning")',
            'updateProgressBar(session = session, id = "pb5", value = input$slider, total = 5000)'
          )
        ),

        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Status : success & size : xs",
          shinyWidgets::progressBar(id = "pb6", value = 50, status = "success", size = "xs"),
          sliderInput(inputId = "uppb6", label = "Update", min = 0, max = 100, value = 50),
          .shinyWidgetGalleryFuns$pb_code(
            id = "pb6",
            'progressBar(id = "pb6", value = 50, status = "success", size = "xs")',
            'updateProgressBar(session = session, id = "pb6", value = input$slider)'
          )
        )

      ),

      column(
        width = 12,

        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Status update",
          shinyWidgets::progressBar(id = "pb7", value = 50, display_pct = TRUE, status = "warning"),
          sliderInput(inputId = "uppb7", label = "Update", min = 0, max = 100, value = 50, step = 5),
          .shinyWidgetGalleryFuns$pb_code(
            id = "pb7",
            'progressBar(id = "pb7", value = 50, display_pct = TRUE, status = "warning")',
            paste(
              'if (input$slider < 33) {',
              '  status <- "danger"',
              '} else if (input$slider >= 33 & input$slider < 67) {',
              '  status <- "warning"',
              '} else {',
              '  status <- "success"',
              '}',
              'updateProgressBar(session = session, id = "pb7", value = input$slider, status = status)',
              sep = "\n"
            )
          )
        ),

        .shinyWidgetGalleryFuns$box_wrapper(
          title = "",
          shinyWidgets::progressBar(id = "pb8", value = 1500, total = 5000, status = "info", display_pct = TRUE, striped = TRUE, title = "All options"),
          sliderInput(inputId = "uppb8", label = "Update", min = 0, max = 5000, value = 50),
          .shinyWidgetGalleryFuns$pb_code(
            id = "pb8",
            'progressBar(id = "pb8", value = 1500, total = 5000, status = "info", display_pct = TRUE, striped = TRUE, title = "All options")',
            'updateProgressBar(session = session, id = "pb8", value = input$slider, total = 5000)'
          )
        ),

        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Update total",
          shinyWidgets::progressBar(id = "pb9", value = 1000, total = 1000, display_pct = TRUE),
          sliderInput(inputId = "uppb9", label = "Update", min = 1000, max = 5000, value = 1000, step = 50),
          .shinyWidgetGalleryFuns$pb_code(
            id = "pb9",
            'progressBar(id = "pb9", value = 1000, total = 1000, display_pct = TRUE)',
            'updateProgressBar(session = session, id = "pb9", value = 1000, total = input$slider)'
          )
        )

      )
    )
  )
}
