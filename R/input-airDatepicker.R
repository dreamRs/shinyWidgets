
#' @title Air Date Picker Input
#'
#' @description An alternative to [shiny::dateInput()] to select single, multiple or date range
#'  based on [Air Datepicker library](https://air-datepicker.com/).
#'  And two alias to select months or years.
#'
#' @param inputId The `input` slot that will be used to access the value.
#' @param label Display label for the control, or `NULL` for no label.
#' @param value Initial value(s), dates as character string are accepted in `yyyy-mm-dd` format,
#' or Date/POSIXct object. Can be a single value or several values.
#' @param multiple Select multiple dates. If `TRUE`, then one can select unlimited dates.
#'  If \code{numeric} is passed, then amount of selected dates will be limited by it.
#' @param range Select a date range.
#' @param timepicker Add a timepicker below calendar to select time.
#' @param separator Separator between dates when several are selected, default to `" - "`.
#' @param placeholder A character string giving the user a hint as to what can be entered into the control.
#' @param dateFormat Format to use to display date(s), default to `yyyy-MM-dd`,
#'  see [online documentation](https://air-datepicker.com/docs?scrollTo=dateFormat) for possible values.
#' @param firstDay Day index from which week will be started. Possible values are from 0 to 6, where
#'  0 - Sunday and 6 - Saturday. By default value is taken from current localization,
#'  but if it passed here then it will have higher priority.
#' @param minDate The minimum allowed date. Either a Date object, or a string in `yyyy-mm-dd` format.
#' @param maxDate The maximum allowed date. Either a Date object, or a string in `yyyy-mm-dd` format.
#' @param disabledDates A vector of dates to disable, e.g. won't be able to select one of dates passed.
#' @param disabledDaysOfWeek Day(s) of week to disable, numbers from 0 (Sunday) to 6 (Saturday).
#' @param highlightedDates A vector of dates to highlight.
#' @param view Starting view, one of `'days'` (default), `'months'` or `'years'`.
#' @param startView Date shown in calendar when date picker is opened.
#' @param minView Minimal view, one of `'days'` (default), `'months'` or `'years'`.
#' @param monthsField Names for the months when view is 'months',
#'  use `'monthsShort'` for abbreviations or `'months'` for full names.
#' @param clearButton If `TRUE`, then button "Clear" will be visible.
#' @param todayButton If `TRUE`, then button "Today" will be visible to set view to current date,
#'  if a \code{Date} is used, it will set view to the given date and select it..
#' @param autoClose If `TRUE`, then after date selection, datepicker will be closed.
#' @param timepickerOpts Options for timepicker, see [timepickerOptions()].
#' @param position Where calendar should appear, a two word string like
#'  `'bottom left'` (default), or `'top right'`, `'left top'`.
#' @param update_on When to send selected value to server: on `'change'`
#'  or when calendar is `'close'`d.
#' @param onlyTimepicker Display only the time picker.
#' @param toggleSelected When `TRUE`, in range mode, it's not possible to select the same date as start and end.
#' @param addon Display a calendar icon to `'right'` or the `'left'`
#'  of the widget, or \code{'none'}. This icon act like an [shiny::actionButton()],
#'  you can retrieve value server-side with `input$<inputId>_button`.
#' @param addonAttributes A `list()` of additional attributes to use for the addon tag, like `class` for example.
# paste(sprintf("`%s`", tools::file_path_sans_ext(list.files("node_modules/air-datepicker/locale/", pattern = "\\.js"))), collapse = ", ")
#' @param language Language to use, can be one of
#'   `ar`, `cs`, `da`, `de`, `en`, `es`, `fi`, `fr`, `hu`, `it`, `ja`, `ko`, `nl`,
#'   `pl`, `pt-BR`, `pt`, `ro`, `ru`, `si`, `sk`, `sv`, `th`, `tr`, `uk`, `zh`.
#' @param tz The timezone.
#' @param inline If `TRUE`, datepicker will always be visible.
#' @param readonly If `TRUE`, datepicker will be readonly and the input field won't be editable.
#' @param onkeydown Attribute passed to the input field.
#' @param width The width of the input, e.g. `'400px'`, or `100%`.
#'
#' @param ... Arguments passed to `airDatepickerInput`.
#'
#' @note Since shinyWidgets 0.5.2 there's no more conflicts with [shiny::dateInput()].
#'
#' @return a `Date` object or a `POSIXct` in UTC timezone.
#'
#' @seealso
#'  * [demoAirDatepicker()] for demo apps
#'  * [updateAirDateInput()] for updating from server
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
                               dateFormat = "yyyy-MM-dd",
                               firstDay = NULL,
                               minDate = NULL,
                               maxDate = NULL,
                               disabledDates = NULL,
                               disabledDaysOfWeek = NULL,
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
                               onlyTimepicker = FALSE,
                               toggleSelected = TRUE,
                               addon = c("right", "left", "none"),
                               addonAttributes = list(class = "btn-outline-secondary"),
                               language = "en",
                               tz = NULL,
                               inline = FALSE,
                               readonly = FALSE,
                               onkeydown = NULL,
                               width = NULL) {
  value <- shiny::restoreInput(inputId, value)
  addon <- match.arg(addon)
  # dput(tools::file_path_sans_ext(list.files("node_modules/air-datepicker/locale/", pattern = "\\.js")))
  language <- match.arg(
    arg = language,
    choices = c(
      "ar", "bg", "cs", "da", "de", "en", "es", "fi", "fr", "hr", "hu", "it",
      "nl", "pl", "pt-BR", "pt", "ro", "ru", "si", "sk", "sv", "th",
      "tr", "uk", "zh", "ja", "ko"
    ),
    several.ok = FALSE
  )

  version <- getOption("air-datepicker", default = 3)

  buttons <- character(0)
  if (clearButton)
    buttons <- c(buttons, "clear")
  if (todayButton)
    buttons <- c(buttons, "today")
  if (length(buttons) < 1)
    buttons <- FALSE

  airParams <- dropNulls(list(
    updateOn = match.arg(update_on),
    disabledDates = list1(disabledDates),
    disabledDaysOfWeek = list1(disabledDaysOfWeek),
    highlightedDates = list1(highlightedDates),
    startView = startView,
    value = list1(value),
    tz = tz,
    todayButtonAsDate = inherits(todayButton, c("Date", "POSIXt")),
    language = toupper(language),
    options = c(dropNulls(list(
      autoClose = isTRUE(autoClose),
      language = if (version < 3) language,
      timepicker = isTRUE(timepicker),
      startDate = startView,
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
      todayButton = isTRUE(todayButton),
      buttons = buttons,
      monthsField = match.arg(monthsField),
      position = position,
      onlyTimepicker = isTRUE(onlyTimepicker),
      toggleSelected = isTRUE(toggleSelected)
    )), timepickerOpts)
  ))

  if (!isTRUE(inline)) {
    tagAir <- tags$input(
      id = inputId,
      class = "sw-air-picker form-control",
      type = "text",
      placeholder = placeholder,
      autocomplete = "off",
      readonly = if (isTRUE(readonly)) "",
      onkeydown = onkeydown
    )
    if (!identical(addon, "none")) {
      tagAir <- tags$div(
        class = "input-group",
        if (identical(addon, "left")) {
          markup_airdatepicker_input_group_button(
            inputId = inputId,
            attributes = addonAttributes,
            theme_func = shiny::getCurrentTheme
          )
        },
        tagAir,
        if (identical(addon, "right")) {
          markup_airdatepicker_input_group_button(
            inputId = inputId,
            attributes = addonAttributes,
            theme_func = shiny::getCurrentTheme
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
    style = css(width = validateCssUnit(width)),
    label_input(inputId, label),
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

  if (version < 3) {
    attachDependencies(
      x = attachShinyWidgetsDep(tagAir, "airdatepicker"),
      value = htmlDependency(
        name = paste0("air-datepicker-i18n-", language),
        version = "2.2.3",
        src = c(href = "shinyWidgets/air-datepicker2"),
        script = sprintf("i18n/datepicker.%s.js", language)
      ), append = TRUE
    )
  } else {
    htmltools::attachDependencies(
      x = tagAir,
      value = html_dependency_airdatepicker()
    )
  }
}



#' @importFrom htmltools tagList tagFunction
#' @importFrom shiny getCurrentTheme
#' @importFrom bslib is_bs_theme theme_version
markup_airdatepicker_input_group_button <- function(inputId, attributes = list(), theme_func = NULL) {
  tagList(tagFunction(function() {
    if (is.function(theme_func))
      theme <- theme_func()
    default <- tags$div(
      class = "btn action-button input-group-addon dp-addon",
      id = paste0(inputId, "_button"),
      icon("calendar-days"),
      !!!attributes
    )
    if (!bslib::is_bs_theme(theme)) {
      return(default)
    }
    if (bslib::theme_version(theme) %in% c("5")) {
      bs5 <- tags$button(
        class = "btn action-button input-group-addon dp-addon",
        id = paste0(inputId, "_button"),
        icon("calendar-days"),
        !!!attributes
      )
      return(bs5)
    }
    return(default)
  }))
}




#' @param dateTimeSeparator Separator between date and time, default to `" "`.
#' @param timeFormat Desirable time format. You can use:
#'    * `h` — hours in 12-hour mode
#'    * `hh` — hours in 12-hour mode with leading zero
#'    * `H` — hours in 24-hour mode
#'    * `HH` — hours in 24-hour mode with leading zero
#'    * `m` — minutes
#'    * `mm` — minutes with leading zero
#'    * `aa` — day period lower case
#'    * `AA` — day period upper case
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
timepickerOptions <- function(dateTimeSeparator = NULL,
                              timeFormat = NULL,
                              minHours = NULL,
                              maxHours = NULL,
                              minMinutes = NULL,
                              maxMinutes = NULL,
                              hoursStep = NULL,
                              minutesStep = NULL) {
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







#' Change the value of [airDatepickerInput()] on the client
#'
#' @param session The `session` object passed to function given to `shinyServer`.
#' @param inputId The id of the input object.
#' @param label The label to set for the input object.
#' @param value The value to set for the input object.
#' @param tz The timezone.
#' @param clear Logical, clear all previous selected dates.
#' @param options Options to update, see available ones in [JavaScript documentation](https://air-datepicker.com/docs)
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
                               tz = NULL,
                               clear = FALSE,
                               options = NULL,
                               show = FALSE,
                               hide = FALSE) {
  stopifnot(is.logical(clear))
  if (!is.null(options$disabledDates)) {
    options$disabledDates <- list1(options$disabledDates)
  }
  if (!is.null(options$highlightedDates)) {
    options$highlightedDates <- list1(options$highlightedDates)
  }
  message <- dropNulls(list(
    id = session$ns(inputId),
    label = label,
    clear = isTRUE(clear),
    show = isTRUE(show),
    hide = isTRUE(hide),
    config = jsonlite::toJSON(
      x = dropNullsOrEmpty(list(
        options = dropNulls(options),
        value = dropNulls(list(value = list1(value), tz = tz))
      )),
      auto_unbox = TRUE,
      json_verbatim = TRUE,
      POSIXt = "epoch"
    )
  ))
  session$sendInputMessage(inputId, message)
}


