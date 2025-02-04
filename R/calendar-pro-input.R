
#' @importFrom htmltools htmlDependency
html_dependency_calendar_pro <- function() {
  htmlDependency(
    name = "calendar-pro",
    version = "2.9.10",
    src = c(file = system.file("packer", package = "shinyWidgets")),
    script = "calendar-pro.js",
    all_files = FALSE
  )
}


#' @title Calendar Pro Input
#'
#' @description A versatile JavaScript date and time picker component,
#'  based on [vanilla-calendar-pro](https://github.com/uvarov-frontend/vanilla-calendar-pro) JavaScript library.
#'
#' @inheritParams shiny::selectInput
#' @param value Initial value.
#' @param type Determines the type of calendar displayed and the selection process: 'default' | 'multiple' | 'range' | 'month' | 'year'.
#' @param min This parameter sets the minimum date that the user can choose. Dates earlier than the specified date will be disabled and not available for selection.
#' @param max This parameter sets the maximum date that the user can choose. Dates later than the specified date will be disabled and not available for selection.
#' @param disablePast This parameter disables all past days.
#' @param disableAllDays This parameter disables all days and can be useful when using `enable` is set.
#' @param disableWeekday This parameter allows you to disable specified weekdays. Specify an array with numbers, where each number represents a day of the week. For example, `0` is Sunday.
#' @param disableGaps This parameter disables the selection of days within a range with disabled dates. It only works when `type = "range"`.
#' @param disabled This parameter allows you to disable specific dates regardless of the specified range.
#' @param enabled This parameter allows you to enable specific dates regardless of the range and disabled dates.
#' @param months The months parameter specifies the number of displayed months when the calendar type is set to 'multiple'.
#' @param jumpMonths The jumpMonths parameter controls the number of months to jump.
#' @param jumpToSelectedDate When the option is enabled and 1 or more selected date(s) are provided but without providing
#'  selected.month and selected.year, it will make the calendar jump to the first selected date. If set to false,
#'  the calendar will always open to the current month and year.
#' @param toggleSelected If toggleSelected parameter is true then clicking on the active cell will remove the selection from it.
#' @param weekNumbers With this parameter, you can decide whether to display week numbers in the calendar.
#' @param weekNumbersSelect If `TRUE` select the week when week number is clicked.
#' @param weekend This parameter allows you to highlight weekends in the calendar.
#' @param time This parameter enables time selection. You can also specify the time format using a boolean value or a number: 24-hour or 12-hour format.
#' @param timeValue Initial time value.
#' @param ... Other settings passed to Slim Select JAvaScript method.
#' @param format Format to use when displaying date in input field, if an initial value is provided it must be a date so that the format apply.
#' @param positionToInput This parameter specifies the position of the calendar relative to input,
#'  if the calendar is initialized with the input parameter. Possible values: 'auto' | 'center' | 'left' | 'right' | c('bottom' | 'top', 'center' | 'left' | 'right')
#' @param theme This parameter determines the theme of the calendar : 'light' or 'dark'.
#' @param placeholder A character string giving the user a hint as to what can be entered into the control.
#' @param input If `TRUE` (default), use an input and render calendar in a dropdown, otherwise calendar is rendered in the page.
#' @param inline Display calendar container inline.
#' @param parseValue Convert input value to date/datetime in server or not.
#'
#' @return
#'  * UI: A `shiny.tag` object that can be used in a UI definition.
#'  * server: a **character** vector of dates selected
#' @export
#'
#' @importFrom utils modifyList
#' @importFrom htmltools tags
#'
#' @example examples/calendar-pro.R
calendarProInput <- function(inputId,
                             label,
                             value = NULL,
                             type = c("default", "multiple", "range", "month", "year"),
                             min = NULL,
                             max = NULL,
                             disablePast = FALSE,
                             disableAllDays = FALSE,
                             disableWeekday = NULL,
                             disableGaps = FALSE,
                             disabled = NULL,
                             enabled = NULL,
                             months = 2,
                             jumpMonths = 1,
                             jumpToSelectedDate = FALSE,
                             toggleSelected = TRUE,
                             weekNumbers = FALSE,
                             weekNumbersSelect = FALSE,
                             weekend = TRUE,
                             time = NULL,
                             timeValue = NULL,
                             ...,
                             format = "%Y-%m-%d",
                             positionToInput = "auto",
                             theme = "light",
                             placeholder = NULL,
                             input = TRUE,
                             inline = FALSE,
                             parseValue = TRUE,
                             width = NULL) {
  # selected <- restoreInput(id = inputId, default = selected)
  type <- match.arg(type)
  parseValue <- if (isTRUE(parseValue)) {
    if (type %in% c("month", "year")) {
      "calendarPro.monthyear"
    } else {
      "calendarPro.date"
    }
  } else {
    "calendarPro.raw"
  }
  config <- list(
    type = if (type == "range") "multiple" else type,
    months = months,
    jumpMonths = jumpMonths,
    jumpToSelectedDate = jumpToSelectedDate,
    toggleSelected = toggleSelected,
    weekNumbersSelect = weekNumbersSelect,
    parseValue = parseValue,
    format = to_dayjs_fmt(format)
  )
  config$input <- input
  config$settings$selection$time <- time
  if (!is.null(time)) {
    if (is.null(timeValue)) {
      timeValue <- format(value, format = "%H:%M")
    } else {
      value <- as.POSIXct(paste(format(value, format = "%Y-%m-%d"), timeValue))
    }
  }
  config$settings$selected$time <- timeValue
  if (!is.null(value))
    config$settings$selected$dates <- list1(format(value, format = "%Y-%m-%d"))
  if (type == "multiple")
    config$settings$selection$day <- "multiple"
  if (type == "range")
    config$settings$selection$day <- "multiple-ranged"
  config$settings$range$min <- min
  config$settings$range$max <- max
  config$settings$range$disablePast <- disablePast
  config$settings$range$disableAllDays <- disableAllDays
  config$settings$range$disableWeekday <- list1(disableWeekday)
  config$settings$range$disableGaps <- disableGaps
  config$settings$range$disabled <- list1(disabled)
  config$settings$range$enabled <- list1(enabled)
  config$settings$visibility$theme <- theme
  config$settings$visibility$weekNumbers <- weekNumbers
  config$settings$visibility$weekend <- weekend
  config$settings$visibility$positionToInput <- positionToInput
  config <- modifyList(config, list(...))
  tag_el <- if (isTRUE(input)) {
    tags$input(
      type = "text",
      class = "form-control calendar-pro-element",
      readonly = NA,
      placeholder = placeholder,
      value = if (!is.null(value)) {
        if (type == "multiple") {
          paste(format(value, format = format), collapse = " \u2014 ")
        } else if (type == "range") {
          paste(format(value[1], format = format), format(value[length(value)], format = format), sep = " \u2014 ")
        } else {
          format(value, format = format)
        }
      }
    )
  } else {
    tags$div(
      class = "calendar-pro-element"
    )
  }
  tags$div(
    id = inputId,
    class = "form-group vanilla-calendar-pro shiny-input-container",
    class = if (isTRUE(inline)) "shiny-input-container-inline",
    style = css(width = validateCssUnit(width)),
    label_input(inputId, label),
    tag_el,
    tags$script(
      type = "application/json",
      `data-for` = inputId,
      toJSON(dropNulls(config), auto_unbox = TRUE, json_verbatim = TRUE)
    ),
    html_dependency_calendar_pro()
  )
}

