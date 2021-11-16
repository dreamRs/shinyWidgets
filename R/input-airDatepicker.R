
#' @title Air Date Picker Input
#'
#' @description An alternative to \code{dateInput} to select single, multiple or date range.
#'  And two alias to select months or years.
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label Display label for the control, or \code{NULL} for no label.
#' @param value Initial value(s), dates as character string are accepted in \code{yyyy-mm-dd} format,
#' or Date/POSIXct object. Can be a single value or several values.
#' @param multiple Select multiple dates. If \code{TRUE}, then one can select unlimited dates.
#'  If \code{numeric} is passed, then amount of selected dates will be limited by it.
#' @param range Select a date range.
#' @param timepicker Add a timepicker below calendar to select time.
#' @param separator Separator between dates when several are selected, default to \code{" - "}.
#' @param placeholder A character string giving the user a hint as to what can be entered into the control.
#' @param dateFormat Format to use to display date(s), default to \code{"yyyy-mm-dd"}.
#' @param firstDay Day index from which week will be started. Possible values are from 0 to 6, where
#'  0 - Sunday and 6 - Saturday. By default value is taken from current localization,
#'  but if it passed here then it will have higher priority.
#' @param minDate The minimum allowed date. Either a Date object, or a string in \code{yyyy-mm-dd} format.
#' @param maxDate The maximum allowed date. Either a Date object, or a string in \code{yyyy-mm-dd} format.
#' @param disabledDates A vector of dates to disable, e.g. won't be able to select one of dates passed.
#' @param highlightedDates A vector of dates to highlight.
#' @param view Starting view, one of \code{'days'} (default), \code{'months'} or \code{'years'}.
#' @param startView Date shown in calendar when date picker is opened.
#' @param minView Minimal view, one of \code{'days'} (default), \code{'months'} or \code{'years'}.
#' @param monthsField Names for the months when view is 'months',
#'  use \code{'monthsShort'} for abbreviations or \code{'months'} for full names.
#' @param clearButton If \code{TRUE}, then button "Clear" will be visible.
#' @param todayButton If \code{TRUE}, then button "Today" will be visible to set view to current date,
#'  if a \code{Date} is used, it will set view to the given date and select it..
#' @param autoClose If \code{TRUE}, then after date selection, datepicker will be closed.
#' @param timepickerOpts Options for timepicker, see \link{timepickerOptions}.
#' @param position Where calendar should appear, a two word string like
#'  \code{'bottom left'} (default), or \code{'top right'}, \code{'left top'}.
#' @param update_on When to send selected value to server: on \code{'change'}
#'  or when calendar is \code{'close'}d.
#' @param addon Display a calendar icon to \code{'right'} or the \code{'left'}
#'  of the widget, or \code{'none'}. This icon act likes an \code{actionButton},
#'  you can retrieve value server-side with \code{input$<inputId>_button}.
#' @param language Language to use, can be one of \code{'cs'}, \code{'da'},
#'  \code{'de'}, \code{'en'}, \code{'es'}, \code{'fi'}, \code{'fr'},
#'  \code{'hu'}, \code{'it'}, \code{'nl'}, \code{'pl'}, \code{'pt-BR'}, \code{'pt'},
#'  \code{'ro'}, \code{'ru'}, \code{'sk'}, \code{'zh'}, \code{'ja'}.
#' @param inline If \code{TRUE}, datepicker will always be visible.
#' @param onlyTimepicker Display only the time picker.
#' @param width The width of the input, e.g. \code{'400px'}, or \code{'100\%'}.
#' @param toggleSelected When \code{TRUE}, in range mode, it's not possible to select the same date as start and end.
#' @param ... Arguments passed to \code{airDatepickerInput}.
#'
#' @note Since shinyWidgets 0.5.2 there's no more conflicts with \code{dateInput}.
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
#' @importFrom htmltools singleton tags tagList validateCssUnit attachDependencies htmlDependency
#' @importFrom shiny restoreInput
#' @importFrom jsonlite toJSON
#'
#' @examples
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
airDatepickerInput <- function(inputId,
                               label = NULL,
                               value = NULL,
                               multiple = FALSE,
                               range = FALSE,
                               timepicker = FALSE,
                               separator = " - ",
                               placeholder = NULL,
                               dateFormat = "yyyy-mm-dd",
                               firstDay = NULL,
                               minDate = NULL,
                               maxDate = NULL,
                               disabledDates = NULL,
                               highlightedDates = NULL,
                               view = c("days", "months", "years"),
                               startView = NULL,
                               minView = c("days", "months", "years"),
                               monthsField = c("monthsShort", "months"),
                               clearButton = FALSE,
                               todayButton = FALSE,
                               autoClose = FALSE,
                               timepickerOpts = timepickerOptions(),
                               position = NULL,
                               update_on = c("change", "close"),
                               addon = c("right", "left", "none"),
                               language = "en",
                               inline = FALSE,
                               onlyTimepicker = FALSE,
                               width = NULL,
                               toggleSelected = TRUE) {
  value <- shiny::restoreInput(inputId, value)
  addon <- match.arg(addon)
  language <- match.arg(
    arg = language,
    choices = c("cs", "da", "de", "en", "es", "fi", "fr", "it", "hu", "nl",
                "pl", "pt-BR", "pt", "ro", "ru", "sk", "tr", "zh", "ja"),
    several.ok = FALSE
  )

  list1 <- function(x) {
    if (is.null(x))
      return(x)
    if (length(x) == 1 & !is.list(x)) {
      list(x)
    } else {
      x
    }
  }

  airParams <- dropNulls(list(
    updateOn = match.arg(update_on),
    disabledDates = list1(disabledDates),
    highlightedDates = list1(highlightedDates),
    startView = startView,
    value = list1(value),
    todayButtonAsDate = inherits(todayButton, c("Date", "POSIXt")),
    options = c(dropNulls(list(
      autoClose = isTRUE(autoClose),
      language = language,
      timepicker = isTRUE(timepicker),
      # startDate = startDate,
      range = isTRUE(range),
      dateFormat = dateFormat,
      firstDay = firstDay,
      minDate = minDate,
      maxDate = maxDate,
      multipleDates = multiple,
      multipleDatesSeparator = separator,
      view = match.arg(view),
      minView = match.arg(minView),
      clearButton = isTRUE(clearButton),
      todayButton = todayButton,
      monthsField = match.arg(monthsField),
      position = position,
      onlyTimepicker = isTRUE(onlyTimepicker),
      toggleSelected = isTRUE(toggleSelected)
    )), timepickerOpts)
  ))

  if (!isTRUE(inline)) {
    tagAir <- tags$input(
      id = inputId,
      class = "sw-air-picker",
      type = "text",
      class = " form-control",
      placeholder = placeholder,
      autocomplete = "off",
      `data-timepicker` = tolower(timepicker)
    )
    if (!identical(addon, "none")) {
      tagAir <- tags$div(
        class = "input-group",
        if (identical(addon, "left")) {
          tags$div(
            class = "btn action-button input-group-addon",
            id = paste0(inputId, "_button"),
            icon("calendar")
          )
        },
        tagAir,
        if (identical(addon, "right")) {
          tags$div(
            class = "btn action-button input-group-addon",
            id = paste0(inputId, "_button"),
            icon("calendar")
          )
        }
      )
    }
  } else {
    tagAir <- tags$div(
      id = inputId,
      class = "sw-air-picker",
      autocomplete = "off",
      `data-timepicker` = tolower(timepicker)
    )
  }

  tagAir <- tags$div(
    class = "form-group shiny-input-container",
    style = if (!is.null(width))
      paste0("width: ", validateCssUnit(width), ";"),
    if (!is.null(label)) tags$label(label, class = "control-label", `for` = inputId),
    tagAir,
    tags$script(
      type = "application/json",
      `data-for` = inputId,
      jsonlite::toJSON(
        x = airParams,
        auto_unbox = TRUE,
        json_verbatim = TRUE,
        POSIXt = "epoch"
      )
    )
  )

  attachDependencies(
    x = attachShinyWidgetsDep(tagAir, "airdatepicker"),
    value = htmlDependency(
      name = paste0("air-datepicker-i18n-", language),
      version = "2.2.3",
      src = c(href = "shinyWidgets/air-datepicker2"),
      script = sprintf("i18n/datepicker.%s.js", language)
    ), append = TRUE
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
    dateTimeSeparator = dateTimeSeparator,
    timeFormat = timeFormat,
    minHours = minHours,
    maxHours = maxHours,
    minMinutes = minMinutes,
    maxMinutes = maxMinutes,
    hoursStep = hoursStep,
    minutesStep = minutesStep
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







#' Change the value of \code{\link{airDatepickerInput}} on the client
#'
#' @param session The \code{session} object passed to function given to \code{shinyServer}.
#' @param inputId The id of the input object.
#' @param label The label to set for the input object.
#' @param value The value to set for the input object.
#' @param clear Logical, clear all previous selected dates.
#' @param options Options to update, see available ones here: \url{http://t1m0n.name/air-datepicker/docs/}.
#' @param show,hide Show / hide datepicker.
#'
#' @export
#'
#' @importFrom jsonlite toJSON
#'
#' @examples
#' if (interactive()) {
#'
#'   demoAirDatepicker("update")
#'
#' }
updateAirDateInput <- function(session = getDefaultReactiveDomain(),
                               inputId,
                               label = NULL,
                               value = NULL,
                               clear = FALSE,
                               options = NULL,
                               show = FALSE,
                               hide = FALSE) {
  stopifnot(is.logical(clear))
  to_ms <- function(x) {
    if (is.null(x))
      return(NULL)
    1000 * as.numeric(as.POSIXct(as.character(x), tz = Sys.timezone()))
  }
  if (!is.null(value)) {
    value <- as.character(toJSON(x = to_ms(value), auto_unbox = FALSE))
  }
  if (!is.null(options)) {
    options$minDate <- to_ms(options$minDate)
    options$maxDate <- to_ms(options$maxDate)
  }
  if (!is.null(options$disabledDates)) {
    options$disabledDates <- list1(options$disabledDates)
  }
  if (!is.null(options$highlightedDates)) {
    options$highlightedDates <- list1(options$highlightedDates)
  }
  message <- dropNulls(list(
    id = session$ns(inputId),
    label = label,
    value = value,
    clear = isTRUE(clear),
    options = dropNulls(options),
    show = isTRUE(show),
    hide = isTRUE(hide)
  ))
  session$sendInputMessage(inputId, message)
}


