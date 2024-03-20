
#' @title Time input
#'
#' @description
#' This widget allow to select hour and minute using the default browser time input.
#' See [developer.mozilla.org](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/time) for more.
#'
#'
#' @param inputId The input slot that will be used to access the value.
#' @param label Display label for the control, or NULL for no label.
#' @param value Initial value, foramtted as `"HH:MM"` or `"HH:MM:SS"`.
#' @param min,max Minimal and maximal value, use same format as in `value`.
#' @param step It takes an integer value that equates to the number of seconds you want to increment by;
#'  the default value is 60 seconds, or one minute. If you specify a value of less than 60 seconds (1 minute),
#'  the time input will show a seconds input area alongside the hours and minutes.
#'  This property has some strange effects across browsers, so is not completely reliable.
#' @param width The width of the input, e.g. `400px`, or `100%`.
#'
#' @return A time input control that can be added to a UI definition.
#' @export
#'
#' @name time-input
#'
#' @example examples/time-input.R
timeInput <- function(inputId,
                      label,
                      value = NULL,
                      min = NULL,
                      max = NULL,
                      step = NULL,
                      width = NULL) {
  tags$div(
    class = "form-group shiny-input-container",
    label_input(inputId, label),
    style = css(width = validateCssUnit(width)),
    tags$input(
      id = inputId,
      type = "time",
      class = "form-control sw-time-input",
      value = value,
      min = min,
      max = max,
      step = step
    ),
    html_dependency_input_time()
  )
}

#' @param session Default Shiny session.
#' @export
#'
#' @rdname time-input
updateTimeInput <- function(session = getDefaultReactiveDomain(),
                            inputId,
                            label = NULL,
                            value = NULL,
                            min = NULL,
                            max = NULL,
                            step = NULL) {
  message <- dropNulls(list(
    label = label,
    value = value,
    min = min,
    max = max,
    step = step
  ))
  session$sendInputMessage(inputId, message)
}

