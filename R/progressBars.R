#' @title Progress Bars
#'
#' @description Create a progress bar to provide feedback on calculation.
#'
#' @param id An id used to update the progress bar.
#' @param value Value of the progress bar between 0 and 100, if >100 you must provide total.
#' @param total Used to calculate percentage if value > 100, force an indicator to appear on top right of the progress bar.
#' @param display_pct logical, display percentage on the progress bar.
#' @param size Size, `NULL` by default or a value in 'xxs', 'xs', 'sm', only work with package `shinydashboard`.
#' @param status Color, must be a valid Bootstrap status : primary, info, success, warning, danger.
#' @param striped logical, add a striped effect.
#' @param title character, optional title.
#'
#' @return A progress bar that can be added to a UI definition.
#'
#' @importFrom htmltools tags tagList singleton HTML
#' @export
#'
#' @examples
#' \dontrun{
#' if (interactive()) {
#'  library("shiny")
#'  library("shinyWidgets")
#'
#'  ui <- fluidPage(
#'    tags$b("Default"), br(),
#'    progressBar(id = "pb1", value = 50),
#'    sliderInput(inputId = "up1", label = "Update", min = 0, max = 100, value = 50)
#'  )
#'
#'  server <- function(input, output, session) {
#'    observeEvent(input$up1, {
#'      updateProgressBar(session = session, id = "pb1", value = input$up1)
#'    })
#'  }
#'
#'  shinyApp(ui = ui, server = server)
#'  }
#' }

progressBar <- function(id, value, total = NULL, display_pct = FALSE, size = NULL, status = NULL, striped = FALSE, title = NULL) {
  if (value > 100) {
    stopifnot(!is.null(total))
    percent <- round(value / total * 100)
  } else {
    percent <- round(value)
  }
  tagPB <- htmltools::tags$div(
    class = "progress-group",
    if (!is.null(title) | !is.null(total)) htmltools::tags$span(class = "progress-text", title, htmltools::HTML("&nbsp;")),
    if (!is.null(total)) htmltools::tags$span(class = "progress-number", htmltools::tags$b(value, id = paste0(id, "-value")), "/", htmltools::tags$span(id = paste0(id, "-total"), total)),
    htmltools::tags$div(
      class = if (!is.null(size)) paste("progress", size) else "progress",
      htmltools::tags$div(
        id = id,
        style=if(percent>0) paste0("width:", percent, "%;"),
        style=if(display_pct) "min-width: 2em;",
        class="progress-bar",
        class=if(!is.null(status)) paste0("progress-bar-", status),
        class=if(striped) "progress-bar-striped",
        role="progressbar",
        if (display_pct) paste0(percent, "%")
      )
    )
  )
  attachShinyWidgetsDep(tagPB)
}




#' @title Update a progress bar
#'
#' @description Change the value of a progress bar on the client
#'
#' @param session The `session` object passed to function given to shinyServer.
#' @param id The id of the progress bar to update
#' @param value Value of the progress bar between 0 and 100, if >100 you must provide total
#' @param total Used to calculate percentage if value > 100
#' @param status Color
#'
#' @export
#'

updateProgressBar <- function(session, id, value, total = NULL, status = NULL) {
  message <- "update-progressBar-shinyWidgets"
  session$sendCustomMessage(type = message, list(id = id, value = value, total = total, status = status))
}
