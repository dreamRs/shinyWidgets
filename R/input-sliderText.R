#' @title Slider Text Input Widget
#'
#' @description Constructs a slider widget with characters instead of numeric values.
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label Display label for the control, or \code{NULL} for no label.
#' @param choices Character vector to select a value from.
#' @param selected The initially selected value, if length > 1, create a range slider.
#' @param animate TRUE to show simple animation controls with default settings, for more details see \code{\link[shiny]{sliderInput}}.
#' @param grid Logical, show or hide ticks marks.
#' @param hide_min_max Hides min and max labels.
#' @param from_fixed Fix position of left (or single) handle.
#' @param to_fixed Fix position of right handle.
#' @param from_min Set minimum limit for left handle.
#' @param from_max Set the maximum limit for left handle.
#' @param to_min Set minimum limit for right handle.
#' @param to_max Set the maximum limit for right handle.
#' @param force_edges Slider will be always inside it's container.
#' @param width The width of the input, e.g. \code{400px}, or \code{100\%}.
#' @param pre A prefix string to put in front of the value.
#' @param post A suffix string to put after the value.
#' @param dragRange See the same argument in \code{\link[shiny]{sliderInput}}.
#'
#' @seealso \link{updateSliderTextInput} to update value server-side.
#'
#' @return The value retrieved server-side is a character vector.
#' @export
#'
#' @importFrom htmltools validateCssUnit tagAppendChild findDependencies tags
#' @importFrom shiny icon sliderInput animationOptions restoreInput
#' @importFrom jsonlite toJSON
#'
#' @examples
#' if (interactive()) {
#'
#' library("shiny")
#' library("shinyWidgets")
#'
#' ui <- fluidPage(
#'   br(),
#'   sliderTextInput(
#'     inputId = "mySliderText",
#'     label = "Month range slider:",
#'     choices = month.name,
#'     selected = month.name[c(4, 7)]
#'   ),
#'   verbatimTextOutput(outputId = "result")
#' )
#'
#' server <- function(input, output, session) {
#'   output$result <- renderPrint(str(input$mySliderText))
#' }
#'
#' shinyApp(ui = ui, server = server)
#'
#' }
sliderTextInput <- function (inputId, label, choices, selected = NULL,
                             animate = FALSE, grid = FALSE,
                             hide_min_max = FALSE,
                             from_fixed = FALSE, to_fixed = FALSE,
                             from_min = NULL, from_max = NULL,
                             to_min = NULL, to_max = NULL, force_edges = FALSE,
                             width = NULL, pre = NULL, post = NULL, dragRange = TRUE)
{
  selected <- shiny::restoreInput(id = inputId, default = selected)
  if (!is.character(choices)) {
    choices <- as.character(choices)
  }

  if (is.null(selected)) {
    selected <- choices[1]
  } else {
    selected <- as.character(selected)
  }

  from <- match(x = selected[1], table = choices) - 1
  if (is.na(from))
    stop("Invalid 'selected' arguments, probably not an element of 'choices'.")

  if (length(selected) > 1) {
    to <- match(x = selected[2], table = choices) - 1
    if (is.na(to))
      stop("Invalid 'selected' arguments, probably not an element of 'choices'.")
  } else {
    to <- NULL
  }

  if (!is.null(from_min))
    from_min <- match(x = from_min, table = choices) - 1
  if (!is.null(from_max))
    from_max <- match(x = from_max, table = choices) - 1
  if (!is.null(to_min))
    to_min <- match(x = to_min, table = choices) - 1
  if (!is.null(to_max))
    to_max <- match(x = to_max, table = choices) - 1

  sliderProps <- dropNulls(list(
    class = "js-range-slider", class = "sw-slider-text",
    id = inputId, `data-type` = if (length(selected) > 1) "double",
    `data-from` = from,
    `data-to` = if (length(selected) > 1) to,
    `data-grid` = grid, `data-prettify-enabled` = FALSE,
    `data-force-edges` = force_edges,
    `data-hide-min-max` = hide_min_max,
    `data-prefix` = pre, `data-postfix` = post,
    `data-from-fixed` = from_fixed, `data-to-fixed` = to_fixed,
    `data-from-min` = from_min, `data-from-max` = from_max,
    `data-to-min` = to_min, `data-to-max` = to_max,
    `data-from-shadow` = !is.null(from_min) | !is.null(from_max),
    `data-to-shadow` = !is.null(to_min) | !is.null(to_max),
    `data-swvalues` = enc2native(jsonlite::toJSON(x = choices)),
    `data-keyboard` = TRUE,
    `data-drag-interval` = if (length(selected) > 1) dragRange,
    `data-data-type` = "text"
  ))
  sliderProps <- lapply(sliderProps, function(x) {
    if (identical(x, TRUE))
      "true"
    else if (identical(x, FALSE))
      "false"
    else x
  })
  sliderTag <- htmltools::tags$div(class = "form-group shiny-input-container",
                   style = if (!is.null(width))
                     paste0("width: ", htmltools::validateCssUnit(width), ";"),
                   if (!is.null(label))
                     htmltools::tags$label(class = "control-label", `for` = inputId,
                                label), do.call(htmltools::tags$input, sliderProps))
  if (identical(animate, TRUE))
    animate <- animationOptions()
  if (!is.null(animate) && !identical(animate, FALSE)) {
    if (is.null(animate$playButton))
      animate$playButton <- shiny::icon("play", lib = "glyphicon")
    if (is.null(animate$pauseButton))
      animate$pauseButton <- shiny::icon("pause", lib = "glyphicon")
    sliderTag <- htmltools::tagAppendChild(
      sliderTag,
      htmltools::tags$div(
        class = "slider-animate-container",
        htmltools::tags$a(
          href = "#", class = "slider-animate-button",
          `data-target-id` = inputId, `data-interval` = animate$interval,
          `data-loop` = animate$loop, htmltools::tags$span(class = "play",
                                                           animate$playButton), htmltools::tags$span(class = "pause",
                                                                                                     animate$pauseButton)
        )
      ))
  }

  dep <- htmltools::findDependencies(shiny::sliderInput(inputId = "id", label = "label", min = 1, max = 10, value = 5))
  attachShinyWidgetsDep(
    htmltools::attachDependencies(sliderTag, dep)
  )
}




#' @title Change the value of a slider text input on the client
#'
#' @description
#' Change the value of a slider text input on the client
#'
#' @param session The session object passed to function given to shinyServer.
#' @param inputId The id of the input object.
#' @param label The label to set.
#' @param selected The values selected.
#' @param choices The new choices for the input.
#' @param from_fixed Fix the left handle (or single handle).
#' @param to_fixed Fix the right handle.
#'
#' @export
#'
#' @seealso \code{\link{sliderTextInput}}
#'
#' @examples
#' if (interactive()) {
#' library("shiny")
#' library("shinyWidgets")
#'
#' ui <- fluidPage(
#'   br(),
#'   sliderTextInput(
#'     inputId = "mySlider",
#'     label = "Pick a month :",
#'     choices = month.abb,
#'     selected = "Jan"
#'   ),
#'   verbatimTextOutput(outputId = "res"),
#'   radioButtons(
#'     inputId = "up",
#'     label = "Update choices:",
#'     choices = c("Abbreviations", "Full names")
#'   )
#' )
#'
#' server <- function(input, output, session) {
#'   output$res <- renderPrint(str(input$mySlider))
#'
#'   observeEvent(input$up, {
#'     choices <- switch(
#'       input$up,
#'       "Abbreviations" = month.abb,
#'       "Full names" = month.name
#'     )
#'     updateSliderTextInput(
#'       session = session,
#'       inputId = "mySlider",
#'       choices = choices
#'     )
#'   }, ignoreInit = TRUE)
#' }
#'
#' shinyApp(ui = ui, server = server)
#' }
updateSliderTextInput <- function (session, inputId, label = NULL, selected = NULL, choices = NULL, from_fixed = NULL, to_fixed = NULL) {
  message <- dropNulls(list(
    label = label, selected = selected, choices = choices,
    from_fixed = from_fixed, to_fixed = to_fixed
  ))
  session$sendInputMessage(inputId, message)
}
