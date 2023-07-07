
#' @importFrom htmltools htmlDependency
html_dependency_easepick <- function() {
  htmlDependency(
    name = "easepick",
    version = "1.2.1",
    src = c(file = system.file("packer", package = "shinyWidgets")),
    script = "easepick.js"
  )
}

#' @title Date picker
#'
#' @description Single or range date picker with predefined ranges included,
#'  multiple calendars grid display and other features.
#'  Made with the JavaScript library [easepick](https://easepick.com/).
#'
#' @param inputId The `input` slot that will be used to access the value.
#' @param label Display label for the control, or `NULL` for no label.
#' @param value Initial value, a `Date` or a `character` in same format as `format` argument.
#'  Use a vector of length two if `range = TRUE`.
#' @param range Activate range mode.
#' @param autoRanges Show predefined ranges to quickly select a range of dates.
#' @param autoApply Hide the apply and cancel buttons, and automatically
#'  apply a new date range as soon as two dates are clicked.
#' @param startView Date shown in calendar when date picker is opened.
#' @param format The default output format. See
#'  [online documentation](https://easepick.com/packages/datetime.html#tokens-format)
#'  for possible values.
#' @param lang Language. This option affect to day names and month names.
#' @param locale Icon and text for buttons. Named list where possible names are:
#'  `nextMonth` / `previousMonth` (newt and previous buttons, default is chevron icon),
#'  `cancel` / `apply` (text for buttons when `autoApply = FALSE`).
#' @param firstDay Day of start week. (0 - Sunday, 1 - Monday, 2 - Tuesday, etc...).
#' @param grid Number of calendar columns.
#' @param calendars Number of visible months.
#' @param months,years Enable dropdowns to select month or year.
#' @param minYear,maxYear Minimal and maximal year to select from when `years = TRUE`.
#' @param minDate,maxDate The minimum/earliest (resp. maximum/latest) date that can be selected.
#' @param minDays,maxDays The minimum (resp. maximum) days of the selected range.
#' @param filterDays A JavaScript function (as a character string) to mark days that cannot be selected.
#' @param weekNumbers Show week numbers.
#' @param delimiter Delimiter between dates (in range mode).
#' @param tooltip Showing tooltip with how much days will be selected (in range mode).
#' @param tooltipText Text for the tooltip.
#'  First value is used for singular, second for plural: `c("day", "days")`.
#' @param rangesPosition Position of predefined ranges block.
#' @param rangesLabels Labels of predefined ranges buttons.
#'  Default is `c("Today", "Yesterday", "Last 7 Days", "Last 30 Days", "This Month", "Last Month")`.
#' @param zIndex zIndex of picker.
#' @param readonly Add readonly attribute to input element.
#' @param inline Show calendar inline.
#' @param width Width of input field.
#' @param element Custom element as a `shiny.tag` (typically a `tags$button()`
#'  for example) on which attach the calendar. The element will have an id set as `<inputId>_trigger`.
#'
#' @return A `Date` server-side, default value is `NULL` unless `value` is provided.
#'
#' @note See [JavaScript documentation](https://easepick.com/packages/core.html#options)
#'  for more examples and options. Note that not all plugins are integrated in this widget.
#'
#' @seealso [updateDatepickerInput()] to update value server-side.
#'
#' @export
#'
#' @examples
datepickerInput <- function(inputId,
                            label,
                            value = NULL,
                            range = FALSE,
                            autoRanges = FALSE,
                            autoApply = TRUE,
                            startView = NULL,
                            format = "YYYY-MM-DD",
                            lang = "en-US",
                            locale = NULL,
                            firstDay = 1,
                            grid = NULL,
                            calendars = NULL,
                            months = FALSE,
                            years = FALSE,
                            minYear = 1950,
                            maxYear = NULL,
                            minDate = NULL,
                            maxDate = NULL,
                            minDays = NULL,
                            maxDays = NULL,
                            filterDays = NULL,
                            weekNumbers = FALSE,
                            delimiter = " - ",
                            tooltip = TRUE,
                            tooltipText = c("day", "days"),
                            rangesPosition = NULL,
                            rangesLabels = NULL,
                            zIndex = 10,
                            readonly = TRUE,
                            inline = FALSE,
                            width = NULL,
                            element = NULL) {
  value <- shiny::restoreInput(inputId, value)
  input <- tags$input(
    id = inputId,
    class = "form-control easepick-input",
    style = if (inline) css(display = "none")
  )
  if (!is.null(element)) {
    stopifnot(
      "datepickerInput: element must be a shiny.tag object" = inherits(element, "shiny.tag")
    )
    element$attribs[names(element$attribs) == "id"] <- NULL
    element <- tagAppendAttributes(
      tag = element,
      id = paste0(inputId, "_trigger")
    )
    input <- tagAppendAttributes(
      tag = input,
      style = css(display = "none")
    )
    element <- tagList(element, input)
    triggerId <- paste0(inputId, "_trigger")
  } else {
    element <- input
    triggerId <- NULL
  }

  plugins <- list("AmpPlugin", "LockPlugin")
  if (isTRUE(range)) {
    plugins <- append(plugins, "RangePlugin")
    if (!is.null(value) && !identical(length(value), 2L))
      stop("If range = TRUE and value is provided it must be of length two.", call. = FALSE)
  }
  if (isTRUE(autoRanges))
    plugins <- append(plugins, "PresetPlugin")
  value <- fmt_date(value)
  rangeOptions <- if (isTRUE(range)) {
    shiny:::dropNullsOrEmpty(list(
      startDate = value[1],
      endDate = value[2],
      delimiter = delimiter,
      tooltip = tooltip,
      locale = list(one = tooltipText[1], other = tooltipText[2])
    ))
  }
  presetOptions <- if (isTRUE(autoRanges)) {
    shiny:::dropNullsOrEmpty(list(
      position = rangesPosition,
      customLabels = rangesLabels
    ))
  }
  lockOptions <- shiny:::dropNullsOrEmpty(list(
    minDate = fmt_date(minDate),
    maxDate = fmt_date(maxDate),
    minDays = minDays,
    maxDays = maxDays,
    filter = filterDays
  ))
  ampOptions <- shiny:::dropNullsOrEmpty(list(
    dropdown = shiny:::dropNullsOrEmpty(list(
      minYear = minYear,
      maxYear = maxYear,
      months = months,
      years = years
    )),
    weekNumbers = weekNumbers
  ))
  config <- shiny:::dropNulls(list(
    easepick = shiny:::dropNullsOrEmpty(list(
      grid = grid,
      calendars = calendars,
      zIndex = zIndex,
      inline = inline,
      readonly = readonly,
      plugins = plugins,
      date = value[1],
      lang = lang,
      format = format,
      autoApply = autoApply,
      locale = locale,
      RangePlugin = rangeOptions,
      PresetPlugin = presetOptions,
      LockPlugin = lockOptions,
      AmpPlugin = ampOptions
    )),
    range = isTRUE(range),
    value = value,
    startView = fmt_date(startView),
    triggerId = triggerId
  ))

  tags$div(
    class = "form-group shiny-input-container",
    style = css(width = validateCssUnit(width)),
    shiny:::shinyInputLabel(inputId, label),
    element,
    tags$script(
      type = "application/json",
      `data-for` = inputId,
      jsonlite::toJSON(
        x = config,
        auto_unbox = TRUE,
        json_verbatim = TRUE,
        POSIXt = "epoch"
      )
    ),
    html_dependency_easepick()
  )
}

fmt_date <- function(x) {
  if (length(x) < 1)
    return(x)
  format(x, format = "%Y-%m-%d")
}

#' Change the value of [datepickerInput()] on the client
#'
#' @param inputId The id of the input object.
#' @inheritParams datepickerInput
#' @param session The session object passed to function given to shinyServer.
#'
#' @return No value.
#' @export
#'
#' @examples
updateDatepicker <- function(inputId,
                             label = NULL,
                             value = NULL,
                             range = NULL,
                             minDate = NULL,
                             maxDate = NULL,
                             minDays = NULL,
                             maxDays = NULL,
                             filterDays = NULL,
                             session = shiny::getDefaultReactiveDomain()) {
  if (!is.null(value)) {
    if (identical(length(value), 2L))
      range <- TRUE
    if (identical(length(value), 1L))
      range <- FALSE
  }
  lockOptions <- shiny:::dropNullsOrEmpty(list(
    minDate = fmt_date(minDate),
    maxDate = fmt_date(maxDate),
    minDays = minDays,
    maxDays = maxDays,
    filter = filterDays
  ))
  message <- shiny:::dropNulls(list(
    label = label,
    value = shinyWidgets:::list1(fmt_date(value)),
    range = if (!is.null(range)) isTRUE(range),
    lockOptions = lockOptions
  ))
  session$sendInputMessage(inputId, message)
}

