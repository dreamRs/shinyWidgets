
#' @title Air Date Picker Input
#'
#' @description An alternative to \code{dateInput} to select single, multiple or date range.
#'  And two alias to select months or years.
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label Display label for the control, or \code{NULL} for no label.
#' @param value Initial value(s), dates as character string are accepted in \code{yyyy-mm-dd} format,
#' or Date/POSIXct object. Can be a single value or severals.
#' @param multiple Select multiple dates.
#' @param range Select a date range.
#' @param timepicker Add a timepicker below calendar to select time.
#' @param separator Separator between dates when several are selected, default to \code{" - "}.
#' @param placeholder A character string giving the user a hint as to what can be entered into the control.
#' @param dateFormat Format to use to display date(s), default to \code{"yyyy-mm-dd"}
#' @param minDate The minimum allowed date. Either a Date object, or a string in \code{yyyy-mm-dd} format.
#' @param maxDate The maximum allowed date. Either a Date object, or a string in \code{yyyy-mm-dd} format.
#' @param disabledDates A vector of dates to disable, e.g. won't be able to select one of dates passed.
#' @param view Starting view, one of \code{'days'} (default), \code{'months'} or \code{'years'}.
#' @param minView Minimal view, one of \code{'days'} (default), \code{'months'} or \code{'years'}.
#' @param monthsField Names for the months when view is 'months',
#'  use \code{'monthsShort'} for abbreviations or \code{'months'} for full names.
#' @param clearButton If \code{TRUE}, then button "Clear" will be visible.
#' @param todayButton If \code{TRUE}, then button "Today" will be visible.
#' @param autoClose If \code{TRUE}, then after date selection, datepicker will be closed.
#' @param timepickerOpts Options for timepicker, see \link{timepickerOptions}.
#' @param position Where calendar should appear, a two word string like
#'  \code{'bottom left'} (default), or \code{'top right'}, \code{'left top'}.
#' @param update_on When to send selected value to server: on \code{'change'}
#'  or when calendar is \code{'close'}d.
#' @param addon Display a calendar icon to \code{'right'} or the \code{'left'}
#'  of the widget, or \code{'none'}.
#' @param language Language to use, can be one of \code{'cs'}, \code{'da'},
#'  \code{'de'}, \code{'en'}, \code{'es'}, \code{'fi'}, \code{'fr'},
#'  \code{'hu'}, \code{'nl'}, \code{'pl'}, \code{'pt-BR'}, \\code{'pt'},
#'  \code{'ro'}, \code{'sk'}, \code{'zh'}.
#' @param inline If \code{TRUE}, datepicker will always be visible.
#' @param width The width of the input, e.g. \code{'400px'}, or \code{'100\%'}.
#' @param ... Arguments passed to \code{airDatepickerInput}.
#'
#' @note This widget prevents `dateInput` from working, don't use both !
#'
#' @return a \code{Date} object or a \code{POSIXct} in UTC timezone.
#'
#' @seealso See \code{\link{updateAirDateInput}} for updating slider value server-side.
#'  And \code{\link{demoAirDatepicker}} for examples.
#'
#' @name airDatepicker
#'
#' @export
#'
#' @importFrom htmltools tags tagList validateCssUnit
#' @importFrom shiny singleton
#' @importFrom jsonlite toJSON
#'
#' @examples
#' \dontrun{
#'
#' if (interactive()) {
#'
#' # examples of different options to select dates:
#' demoAirDatepicker("datepicker")
#'
#' # select month(s)
#' demoAirDatepicker("months")
#'
#' # select year(s)
#' demoAirDatepicker("years")
#'
#' # select date and time
#' demoAirDatepicker("timepicker")
#'
#' # You can select multiple dates :
#' library(shiny)
#' library(shinyWidgets)
#'
#' ui <- fluidPage(
#'   airDatepickerInput(
#'     inputId = "multiple",
#'     label = "Select multiple dates:",
#'     placeholder = "You can pick 5 dates",
#'     multiple = 5, clearButton = TRUE
#'   ),
#'   verbatimTextOutput("res")
#' )
#'
#' server <- function(input, output, session) {
#'   output$res <- renderPrint(input$multiple)
#' }
#'
#' shinyApp(ui, server)
#'
#' }
#'
#' }
#'
airDatepickerInput <- function(inputId, label = NULL, value = NULL, multiple = FALSE,
                               range = FALSE, timepicker = FALSE,
                               separator = " - ", placeholder = NULL,
                               dateFormat = "yyyy-mm-dd",
                               minDate = NULL, maxDate = NULL,
                               disabledDates = NULL,
                               view = c("days", "months", "years"),
                               minView = c("days", "months", "years"),
                               monthsField = c("monthsShort", "months"),
                               clearButton = FALSE, todayButton = FALSE, autoClose = FALSE,
                               timepickerOpts = timepickerOptions(),
                               position = NULL, update_on = c("change", "close"),
                               addon = c("right", "left", "none"),
                               language = "en", inline = FALSE, width = NULL) {
  addon <- match.arg(addon)
  language <- match.arg(
    arg = language,
    choices = c("cs", "da", "de", "en", "es", "fi", "fr", "hu", "nl", "pl",
                "pt-BR", "pt", "ro", "sk", "zh"),
    several.ok = TRUE
  )
  if (!is.null(disabledDates)) {
    disabledDates <- toJSON(x = disabledDates, auto_unbox = FALSE)
  }
  paramsAir <- dropNulls(list(
    id = inputId,
    class = "sw-air-picker",
    `data-language` = language,
    `data-timepicker` = tolower(timepicker),
    `data-start-date` = if (!is.null(value)) toJSON(x = value, auto_unbox = FALSE),
    `data-range` = tolower(range),
    `data-date-format` = dateFormat,
    `data-min-date` = minDate, `data-max-date` = maxDate,
    `data-multiple-dates` = tolower(multiple),
    `data-multiple-dates-separator` = separator,
    `data-view` = match.arg(view),
    `data-min-view` = match.arg(minView),
    `data-clear-button` = tolower(clearButton),
    `data-auto-close` = tolower(autoClose),
    `data-today-button` = tolower(todayButton),
    `data-months-field` = match.arg(monthsField),
    `data-update-on` = match.arg(update_on),
    `data-position` = position,
    `data-disabled-dates` = disabledDates
  ))
  paramsAir <- c(paramsAir, timepickerOpts)

  if (!inline) {
    addArgs <- dropNulls(list(
      type = "text",
      class = " form-control",
      placeholder = placeholder
    ))
    tagAir <- do.call(tags$input, c(paramsAir, addArgs))
    tagAir <- tags$div(
      class = "input-group",
      if (addon == "left") tags$div(class = "input-group-addon", icon("calendar")),
      tagAir,
      if (addon == "right") tags$div(class = "input-group-addon", icon("calendar"))
    )
  } else {
    tagAir <- do.call(tags$div, paramsAir)
  }

  tagList(
    singleton(
      tags$head(
        tags$link(href = "shinyWidgets/air-datepicker/datepicker.min.css", rel = "stylesheet", type = "text/css"),
        tags$script(src = "shinyWidgets/air-datepicker/datepicker.min.js"),
        tags$script(src = "shinyWidgets/air-datepicker/datepicker-bindings.js")
      )
    ),
    singleton(
      tags$head(
        lapply(
          X = language,
          FUN = function(x) {
            tags$script(src = sprintf("shinyWidgets/air-datepicker/i18n/datepicker.%s.js", x))
          }
        )
      )
    ),
    tags$div(
      class = "form-group shiny-input-container",
      style = if (!is.null(width))
        paste0("width: ", validateCssUnit(width), ";"),
      if (!is.null(label)) tags$label(label, `for` = inputId),
      tagAir
    )
  )
}


#' @param dateTimeSeparator Separator between date and time, default to \code{" "}.
#' @param timeFormat Desirable time format. You can use \code{h} (hours), \code{hh}
#'  (hours with leading zero), \code{i} (minutes), \code{ii} (minutes with leading zero),
#'  \code{aa} (day period - 'am' or 'pm'), \code{AA} (day period capitalized)
#' @param minHours Minimal hours value, must be between 0 and 23. You will not be able to choose value lower than this.
#' @param maxHours Maximum hours value, must be between 0 and 23. You will not be able to choose value higher than this.
#' @param minMinutes Minimal minutes value, must be between 0 and 59. You will not be able to choose value lower than this.
#' @param maxMinutes Maximum minutes value, must be between 0 and 59. You will not be able to choose value higher than this.
#' @param hoursStep Hours step in slider.
#' @param minutesStep Minutes step in slider.
#'
#' @rdname airDatepicker
#' @export
#'
timepickerOptions <- function(dateTimeSeparator = NULL, timeFormat = NULL,
                              minHours = NULL, maxHours = NULL,
                              minMinutes = NULL, maxMinutes = NULL,
                              hoursStep = NULL, minutesStep = NULL) {
  dropNulls(list(
    `data-date-time-separator` = dateTimeSeparator,
    `data-time-format` = timeFormat,
    `data-min-hours` = minHours,
    `data-max-hours` = maxHours,
    `data-min-minutes` = minMinutes,
    `data-max-minutes` = maxMinutes,
    `data-hours-step` = hoursStep,
    `data-minutes-step` = minutesStep
  ))
}


#' @rdname airDatepicker
#' @export
#' @importFrom utils modifyList
airMonthpickerInput <- function(inputId, label = NULL, value = NULL, ...) {
  if (!is.null(value)) {
    if (inherits(value, "Date")) {
      value <- format(value, format = "%Y-%m-01")
    }
  }
  args <- list(...)
  args <- modifyList(
    val = args,
    x = list(
      inputId = inputId,
      label = label,
      value = value,
      view = "months",
      minView = "months",
      dateFormat = "MM yyyy",
      monthsField = "months"
    )
  )
  do.call(airDatepickerInput, args)
}


#' @rdname airDatepicker
#' @export
#' @importFrom utils modifyList
airYearpickerInput <- function(inputId, label = NULL, value = NULL, ...) {
  if (!is.null(value)) {
    if (inherits(value, "Date")) {
      value <- format(value, format = "%Y-01-01")
    }
  }
  args <- list(...)
  args <- modifyList(
    val = args,
    x = list(
      inputId = inputId,
      label = label,
      value = value,
      dateFormat = "yyyy",
      view = "years",
      minView = "years"
    )
  )
  do.call(airDatepickerInput, args)
}







#' Change the value of a airDate input on the client
#'
#' @param session The \code{session} object passed to function given to \code{shinyServer}.
#' @param inputId The id of the input object.
#' @param label The label to set for the input object.
#' @param value The value to set for the input object.
#' @param clear Logical, clear all previous selected dates.
#' @param options Options to update, see availables ones here: \url{http://t1m0n.name/air-datepicker/docs/}.
#'
#' @export
#'
#' @importFrom jsonlite toJSON
#'
#' @examples
#' \dontrun{
#'
#' demoAirDatepicker("update")
#'
#' }
updateAirDateInput <- function(session, inputId, label = NULL, value = NULL, clear = FALSE, options = NULL) {
  stopifnot(is.logical(clear))
  formatDate <- function(x) {
    if (is.null(x))
      return(NULL)
    format(as.Date(x), "%Y-%m-%d")
  }
  value <- formatDate(value)
  if (!is.null(value)) {
    value <- as.character(toJSON(x = value, auto_unbox = FALSE))
  }
  message <- dropNulls(list(
    id = session$ns(inputId),
    label = label,
    value = value,
    clear = clear,
    options = options
  ))
  session$sendInputMessage(inputId, message)
}


