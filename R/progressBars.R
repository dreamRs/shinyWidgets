#' @title Progress Bars
#'
#' @description Create a progress bar to provide feedback on calculation.
#'
#' @param id An id used to update the progress bar.
#'  If in a Shiny module, it use same logic than inputs : use namespace in UI, not in server.
#' @param value Value of the progress bar between 0 and 100, if >100 you must provide total.
#' @param total Used to calculate percentage if value > 100, force an indicator to appear on top right of the progress bar.
#' @param display_pct logical, display percentage on the progress bar.
#' @param size Size, `NULL` by default or a value in 'xxs', 'xs', 'sm', only work with package `shinydashboard`.
#' @param status Color, must be a valid Bootstrap status : primary, info, success, warning, danger.
#' @param striped logical, add a striped effect.
#' @param title character, optional title.
#' @param range_value Default is to display percentage (\code{[0, 100]}), but you can specify a custom range, e.g. \code{-50, 50}.
#' @param commas logical, add commas on total and value.
#' @param unit_mark Unit for value displayed on the progress bar, default to \code{"\%"}.
#'
#' @return A progress bar that can be added to a UI definition.
#'
#' @name progress-bar
#'
#' @seealso \link{progressSweetAlert} for progress bar in a sweet alert
#'
#' @importFrom htmltools tags tagList singleton HTML
#' @export
#'
#' @examples
#' if (interactive()) {
#'
#' library("shiny")
#' library("shinyWidgets")
#'
#' ui <- fluidPage(
#'   column(
#'     width = 7,
#'     tags$b("Default"), br(),
#'     progressBar(id = "pb1", value = 50),
#'     sliderInput(
#'       inputId = "up1",
#'       label = "Update",
#'       min = 0,
#'       max = 100,
#'       value = 50
#'     ),
#'     br(),
#'     tags$b("Other options"), br(),
#'     progressBar(
#'       id = "pb2",
#'       value = 0,
#'       total = 100,
#'       title = "",
#'       display_pct = TRUE
#'     ),
#'     actionButton(
#'       inputId = "go",
#'       label = "Launch calculation"
#'     )
#'   )
#' )
#'
#' server <- function(input, output, session) {
#'   observeEvent(input$up1, {
#'     updateProgressBar(
#'       session = session,
#'       id = "pb1",
#'       value = input$up1
#'     )
#'   })
#'   observeEvent(input$go, {
#'     for (i in 1:100) {
#'       updateProgressBar(
#'         session = session,
#'         id = "pb2",
#'         value = i, total = 100,
#'         title = paste("Process", trunc(i/10))
#'       )
#'       Sys.sleep(0.1)
#'     }
#'   })
#' }
#'
#' shinyApp(ui = ui, server = server)
#'
#' }
progressBar <- function(id,
                        value,
                        total = NULL,
                        display_pct = FALSE,
                        size = NULL,
                        status = NULL,
                        striped = FALSE,
                        title = NULL,
                        range_value = NULL,
                        commas = TRUE,
                        unit_mark = "%") {
  if (!is.null(total)) {
    percent <- round(value / total * 100)
  } else {
    value <- round(value)
    if (!is.null(range_value)) {
      percent <- rescale(x = value, from = range_value, to = c(0, 100))
    } else {
      percent <- value
    }
  }

  if (!is.null(title) | !is.null(total)) {
    title <- tags$span(
      class = "progress-text",
      id = paste0(id, "-title"),
      title, HTML("&nbsp;")
    )
  }

  if(commas) {
    value_for_display <- prettyNum(value, big.mark = ",", scientific = FALSE)
    total_for_display <- prettyNum(total, big.mark = ",", scientific = FALSE)
  } else {
    value_for_display <- value
    total_for_display <- total
  }

  if (!is.null(total)) {
    total <- tags$span(
      class = "progress-number",
      tags$b(value_for_display, id = paste0(id, "-value")),
      "/",
      tags$span(id = paste0(id, "-total"), total_for_display)
    )
  }

  tagPB <- tags$div(
    class = "progress-group",
    title, total,
    tags$div(
      class = "progress",
      class = if (!is.null(size)) paste0("progress-", size),
      tags$div(
        id = id,
        style = if (percent > 0) paste0("width:", percent, "%;"),
        style = if (display_pct) "min-width: 2em;",
        class = "progress-bar",
        class = if (!is.null(status)) paste0("progress-bar-", status),
        class = if (!is.null(status)) paste0("bg-", status),
        class = if (striped) "progress-bar-striped",
        role = "progressbar",
        if (display_pct) paste0(percent, unit_mark)
      )
    )
  )
  tagPB <- tagList(
    singleton(
      tags$head(tags$style(".progress-number {position: absolute; right: 20px;}"))
    ), tagPB
  )
  attachShinyWidgetsDep(tagPB)
}




#' @param session The 'session' object passed to function given to shinyServer.
#'
#' @export
#'
#' @rdname progress-bar
updateProgressBar <- function(session = getDefaultReactiveDomain(),
                              id,
                              value,
                              total = NULL,
                              title = NULL,
                              status = NULL,
                              range_value = NULL,
                              commas = TRUE,
                              unit_mark = "%") {
  message <- "update-progressBar-shinyWidgets"
  if (!is.null(range_value)) {
    percent <- rescale(x = value, from = range_value, to = c(0, 100))
  } else {
    percent <- -1
  }
  # If we are inside a module, turn the (relative) id (e.g. 'input') into an absolute id (e.g. 'module-input')
  if (inherits(session, "session_proxy")) {
    # Keep old code working which externally uses session$ns() to create an absolute id.
    if (!starts_with(id, session$ns("")))
      id <- session$ns(id)
  }
  session$sendCustomMessage(
    type = message,
    message = list(
      id = id, value = value,
      percent = percent,
      total = if (is.null(total)) -1 else total,
      title = title,
      status = status,
      commas = commas,
      unit_mark = unit_mark
    )
  )
}
