
#' @importFrom htmltools htmlDependency
html_dependency_calendar_pro <- function() {
  htmlDependency(
    name = "calendar-pro",
    version = "3.0.3",
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
#' @param mode This parameter determines whether selecting one or multiple days is allowed, or if date selection is completely disabled.
#'  Possible values are: 'single' | 'multiple' | 'multiple-ranged' | false.
#' @param type Determines the type of calendar displayed and the selection process: 'default' | 'multiple' | 'month' | 'year'.
#' @param displayDateMin This parameter sets the minimum date that the user can choose. Dates earlier than the specified date will be disabled and not available for selection.
#' @param displayDateMax This parameter sets the maximum date that the user can choose. Dates later than the specified date will be disabled and not available for selection.
#' @param firstWeekday This parameter sets the first day of the week. Specify a number from 0 to 6, where the number represents the day of the week identifier.
#'  According to JS standards, the days of the week start with 0, and 0 is Sunday.
#' @param disableDatesPast This parameter disables all past days.
#' @param disableAllDates This parameter disables all days and can be useful when using `enableDates` is set.
#' @param disableWeekdays This parameter allows you to disable specified weekdays. Specify an array with numbers, where each number represents a day of the week. For example, `0` is Sunday.
#' @param disableDatesGaps This parameter disables the selection of days within a range with disabled dates. It only works when `mode = "multiple-ranged"`.
#' @param disableDates This parameter allows you to disable specific dates regardless of the specified range.
#' @param enableDates This parameter allows you to enable specific dates regardless of the range and disabled dates.
#' @param displayMonthsCount The months parameter specifies the number of displayed months when the calendar type is set to 'multiple'.
#' @param enableJumpToSelectedDate When the option is enabled and 1 or more selected date(s) are provided but without providing
#'  selected.month and selected.year, it will make the calendar jump to the first selected date. If set to false,
#'  the calendar will always open to the current month and year.
#' @param enableDateToggle If true then clicking on a selected date again will deselect it.
#' @param enableWeekNumbers With this parameter, you can decide whether to display week numbers in the calendar.
#' @param selectWeekNumbers If `TRUE` select the week when week number is clicked.
#' @param selectionTimeMode This parameter enables time selection. You can also specify the time format using a boolean value or a number: 24-hour or 12-hour format.
#' @param selectedTime Initial time value.
#' @param ... Other settings passed to Calendar Pro JavaScript method, see [online documentation](https://vanilla-calendar.pro/docs/reference/settings) for reference.
#' @param locale This parameter sets the language localization of the calendar. You can specify a language label according to BCP 47 or provide arrays of month and weekday names.
#'  See [online documentation](https://vanilla-calendar.pro/docs/reference/settings#locale).
#' @param format Format to use when displaying date in input field, if an initial value is provided it must be a date so that the format apply.
#' @param positionToInput This parameter specifies the position of the calendar relative to input,
#'  if the calendar is initialized with the input parameter. Possible values: 'auto' | 'center' | 'left' | 'right' | c('bottom' | 'top', 'center' | 'left' | 'right')
#' @param selectedTheme This parameter determines the theme of the calendar : 'light' or 'dark'.
#' @param placeholder A character string giving the user a hint as to what can be entered into the control.
#' @param inputMode If `TRUE` (default), use an input and render calendar in a dropdown, otherwise calendar is rendered in the page.
#' @param inline Display calendar container inline.
#' @param parseValue Convert input value to date/datetime in server or not.
#'
#' @return
#'  * UI: A `shiny.tag` object that can be used in a UI definition.
#'  * server: if `parseValue=FALSE` a **character** vector of dates selected, otherwise a Date/POSIXct objet.
#'
#' @seealso [updateCalendarPro()] to update the widget from the server.
#'
#' @export
#'
#' @importFrom utils modifyList
#' @importFrom htmltools tags
#'
#' @example examples/calendar-pro.R
calendarProInput <- function(inputId,
                             label,
                             value = NULL,
                             mode = c("single", "multiple", "multiple-ranged", "false"),
                             type = c("default", "multiple", "month", "year"),
                             displayDateMin = NULL,
                             displayDateMax = NULL,
                             firstWeekday = NULL,
                             disableDatesPast = FALSE,
                             disableAllDates = FALSE,
                             disableWeekdays = NULL,
                             disableDatesGaps = FALSE,
                             disableDates = NULL,
                             enableDates = NULL,
                             displayMonthsCount = 1,
                             enableJumpToSelectedDate = FALSE,
                             enableDateToggle = TRUE,
                             enableWeekNumbers = FALSE,
                             selectWeekNumbers = FALSE,
                             selectionTimeMode = NULL,
                             selectedTime = NULL,
                             ...,
                             locale = NULL,
                             format = "%Y-%m-%d",
                             positionToInput = "auto",
                             selectedTheme = "light",
                             placeholder = NULL,
                             inputMode = TRUE,
                             inline = FALSE,
                             parseValue = TRUE,
                             width = NULL) {
  # selected <- restoreInput(id = inputId, default = selected)
  mode <- match.arg(mode)
  type <- match.arg(type)
  if (type == "multiple") {
    stopifnot(
      "calendarProInput: when type='multiple', displayMonthsCount shoulb be between 2 and 12." = displayMonthsCount >= 2 | displayMonthsCount <= 12
    )
  }
  parseValue <- if (isTRUE(parseValue)) {
    if (type == "month") {
      "calendarPro.month"
    } else if (type == "year") {
      "calendarPro.year"
    } else {
      "calendarPro.date"
    }
  } else {
    "calendarPro.raw"
  }
  if (!is.null(selectionTimeMode)) {
    if (is.null(selectedTime)) {
      selectedTime <- format(value, format = "%H:%M")
    } else {
      value <- as.POSIXct(paste(format(value, format = "%Y-%m-%d"), selectedTime))
    }
  }
  options <- dropNulls(list(
    selectedDates = list1(format(value, format = "%Y-%m-%d")),
    inputMode = inputMode,
    selectionDatesMode = mode,
    type = type,
    displayMonthsCount = displayMonthsCount,
    enableJumpToSelectedDate = enableJumpToSelectedDate,
    enableDateToggle = enableDateToggle,
    positionToInput = positionToInput,
    enableWeekNumbers = enableWeekNumbers,
    selectedTheme = selectedTheme,
    displayDateMin = displayDateMin,
    displayDateMax = displayDateMax,
    disableDatesPast = disableDatesPast,
    disableDatesGaps = disableDatesGaps,
    disableWeekdays = list1(disableWeekdays),
    disableAllDates = disableAllDates,
    enableDates = list1(enableDates),
    disableDates = list1(disableDates),
    selectionTimeMode = selectionTimeMode,
    selectedTime = selectedTime,
    firstWeekday = firstWeekday,
    locale = locale
  ))
  options <- modifyList(options, list(...))
  config <- list(
    options = options,
    selectWeekNumbers = selectWeekNumbers,
    parseValue = parseValue,
    format = to_dayjs_fmt(format)
  )

  tag_el <- if (isTRUE(inputMode)) {
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






#' @title Update calendar pro from server
#'
#' @description
#' Update a [calendarProInput()] from the server.
#'
#' @inheritParams calendarProInput
#' @inheritParams shiny::updateSelectInput
#'
#' @return No value.
#'
#' @seealso [calendarProInput()] for creating a widget in the UI.
#'
#' @export
#'
#' @example examples/calendar-pro-update.R
updateCalendarPro <- function(inputId,
                              label = NULL,
                              value = NULL,
                              mode = NULL,
                              ...,
                              session = shiny::getDefaultReactiveDomain()) {
  if (!is.null(label))
    label <- doRenderTags(label)
  options <- list(
    selectedDates = list1(format(value, format = "%Y-%m-%d")),
    selectionDatesMode = mode,
    ...
  )
  if (inherits(value, "POSIXt") & is.null(options$selectedTime))
    options$selectedTime <- format(value, format = "%H:%M")
  if (!is.null(options$disableWeekdays))
    options$disableWeekdays <- list1(options$disableWeekdays)
  if (!is.null(options$enableDates))
    options$enableDates <- list1(options$enableDates)
  if (!is.null(options$disableDates))
    options$disableDates <- list1(options$disableDates)
  message <- dropNulls(list(
    label = label,
    options = dropNulls(options)
  ))
  session$sendInputMessage(inputId, message)
}


