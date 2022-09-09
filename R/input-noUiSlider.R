
#' @title Numeric range slider
#'
#' @description A minimal numeric range slider with a lot of features.
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label Display label for the control, or NULL for no label.
#' @param min Minimal value that can be selected.
#' @param max Maximal value that can be selected.
#' @param value The initial value of the slider. as many cursors will be created as values provided.
#' @param step numeric, by default, the slider slides fluently.
#'  In order to make the handles jump between intervals, you can use
#'  the step option.
#' @param tooltips logical, display slider's value in a tooltip above slider.
#' @param connect logical, vector of length \code{value} + 1, color slider between handle(s).
#' @param padding numeric, padding limits how close to the slider edges handles can be.
#' @param margin numeric, when using two handles, the minimum distance between
#'  the handles can be set using the margin option.
#' @param limit numeric, the limit option is the opposite of the \code{margin} option,
#'  limiting the maximum distance between two handles.
#' @param orientation The orientation setting can be used to set the
#'  slider to \code{"vertical"} or \code{"horizontal"}.
#' @param direction \code{"ltr"} or \code{"rtl"}, By default the sliders are top-to-bottom and left-to-right,
#'  but you can change this using the direction option,
#'  which decides where the upper side of the slider is.
#' @param behaviour Option to handle user interaction, a value or several between
#' \code{"drag"}, \code{"tap"}, \code{"fixed"}, \code{"snap"} or \code{"none"}.
#'  See \url{https://refreshless.com/nouislider/behaviour-option/} for more examples.
#' @param range list, can be used to define non-linear sliders.
#' @param pips list, used to generate points along the slider.
#' @param format numbers format, see \code{\link{wNumbFormat}}.
#' @param update_on When to send value to server: \code{"end"} (when slider is released) or \code{"update"} (each time value changes).
#' @param color color in Hex format for the slider.
#' @param inline If \code{TRUE}, it's possible to position sliders side-by-side.
#' @param width The width of the input, e.g. `400px`, or `100%`.
#' @param height The height of the input, e.g. `400px`, or `100%`.
#'
#' @note See [updateNoUiSliderInput()] for updating slider value server-side.
#'  And [demoNoUiSlider()] for examples.
#'
#' @return a ui definition
#' @export
#'
#' @importFrom htmltools tags validateCssUnit
#' @importFrom jsonlite toJSON
#'
#' @example examples/noUiSlider.R
noUiSliderInput <- function(inputId, label = NULL, min, max, value,
                            step = NULL, tooltips = TRUE,
                            connect = TRUE, padding = 0,
                            margin = NULL, limit = NULL,
                            orientation = c("horizontal", "vertical"),
                            direction = c("ltr", "rtl"),
                            behaviour = "tap", range = NULL, pips = NULL,
                            format = wNumbFormat(),
                            update_on = c("end", "change"),
                            color = NULL, inline = FALSE,
                            width = NULL, height = NULL) {
  orientation <- match.arg(orientation)
  update_on <- match.arg(update_on)
  behaviour <- match.arg(
    arg = behaviour,
    choices = c("drag", "tap", "fixed", "snap", "none"),
    several.ok = TRUE
  )
  behaviour <- paste(behaviour, collapse = "-")
  if (is.null(range))
    range <- list(min = min, max = max)
  noUiProps <- dropNulls(list(
    start = value,
    step = step,
    range = range,
    tooltips = tooltips,
    connect = if (length(connect) == length(value)) c(connect, FALSE) else connect,
    padding = padding,
    pips = pips,
    margin = margin,
    limit = limit,
    orientation = orientation,
    direction = match.arg(direction),
    behaviour = behaviour,
    format = format
  ))
  tags$div(
    class = "form-group shiny-input-container",
    class = if (inline) "shiny-input-container-inline",
    style = if (!is.null(width)) paste0("width: ", validateCssUnit(width), ";"),
    style = if (inline) "display: inline-block;",
    tags$label(
      `for` = inputId,
      class = "control-label",
      class = if (is.null(label)) "shiny-label-null",
      id = paste0(inputId, "-label"),
      label
    ),
    tags$div(
      style = if (!is.null(pips)) "margin-bottom: 40px;",
      style = if (tooltips) "padding-left: 10px;",
      style = if (orientation == "vertical" & tooltips) "margin-left: 15px;",
      style = if (orientation != "vertical" & tooltips) "margin-top: 40px; ",
      if (!is.null(color)) tags$style(sprintf("#%s .noUi-connect {background: %s;}", inputId, color)),
      tags$div(
        style = if (!is.null(height))  paste0("height: ", validateCssUnit(height), ";"),
        id = inputId, class = "sw-no-ui-slider", `data-update` = update_on
      ),
      tags$script(
        type = "application/json",
        `data-for` = inputId,
        jsonlite::toJSON(noUiProps, auto_unbox = TRUE, json_verbatim = TRUE)
      )
    ),
    html_dependency_nouislider()
  )
}


#' Format numbers in noUiSliderInput
#'
#' @param decimals The number of decimals to include in
#'  the result. Limited to 7.
#' @param mark The decimal separator. Defaults to \code{'.'}
#'  if thousand isn't already set to \code{'.'}.
#' @param thousand Separator for large numbers. For example: \code{' '}
#'  would result in a formatted number of 1 000 000.
#' @param prefix A string to prepend to the number. Use cases
#'  include prefixing with money symbols such as \code{'$'} or the euro sign.
#' @param suffix A number to append to a number. For example: \code{',-'}.
#' @param negative The prefix for negative values. Defaults to \code{'-'}.
#'
#' @note Performed via wNumb JavaScript library : \url{https://refreshless.com/wnumb/}.
#'
#' @return a named list.
#' @export
#'
#' @encoding UTF-8
#'
#' @examples
#' if (interactive()) {
#'
#' library( shiny )
#' library( shinyWidgets )
#'
#' ui <- fluidPage(
#'   tags$h3("Format numbers"),
#'   tags$br(),
#'
#'   noUiSliderInput(
#'     inputId = "form1",
#'     min = 0, max = 10000,
#'     value = 800,
#'     format = wNumbFormat(decimals = 3,
#'                          thousand = ".",
#'                          suffix = " (US $)")
#'   ),
#'   verbatimTextOutput(outputId = "res1"),
#'
#'   tags$br(),
#'
#'   noUiSliderInput(
#'     inputId = "form2",
#'     min = 1988, max = 2018,
#'     value = 1988,
#'     format = wNumbFormat(decimals = 0,
#'                          thousand = "",
#'                          prefix = "Year: ")
#'   ),
#'   verbatimTextOutput(outputId = "res2"),
#'
#'   tags$br()
#'
#' )
#'
#' server <- function(input, output, session) {
#'
#'   output$res1 <- renderPrint(input$form1)
#'   output$res2 <- renderPrint(input$form2)
#'
#' }
#'
#' shinyApp(ui, server)
#'
#' }
wNumbFormat <- function(decimals = NULL,
                        mark = NULL,
                        thousand = NULL,
                        prefix = NULL,
                        suffix = NULL,
                        negative = NULL) {
  params <- dropNulls(list(
    decimals = decimals, mark = mark,
    thousand = thousand, prefix = prefix,
    suffix = suffix, negative = negative
  ))
  if (length(params) == 0) {
    NULL
  } else {
    if (is.null(params$decimals)) {
      params$decimals <- 2
    }
    params
  }
}


#' Change the value of a no ui slider input on the client
#'
#' @param session The `session` object passed to function given to `shinyServer`.
#' @param inputId The id of the input object.
#' @param label The new label.
#' @param value The new value.
#' @param range The new range, must be of length 2 with `c(min, max)`.
#' @param disable logical, disable or not the slider,
#'  if disabled the user can no longer modify the slider value.
#'
#' @seealso [noUiSliderInput()]
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'
#'  demoNoUiSlider("update")
#'
#' }
updateNoUiSliderInput <- function(session = getDefaultReactiveDomain(),
                                  inputId,
                                  label = NULL,
                                  value = NULL,
                                  range = NULL,
                                  disable = FALSE) {
  if (!is.null(range) && length(range) != 2) {
    range <- NULL
    warning("'range' must be of length 2, value will be ignored.")
  }
  message <- dropNulls(list(
    label = label,
    value = value,
    range = range,
    disable = disable
  ))
  session$sendInputMessage(inputId, message)
}







