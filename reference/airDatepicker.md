# Air Date Picker Input

An alternative to
[`shiny::dateInput()`](https://rdrr.io/pkg/shiny/man/dateInput.html) to
select single, multiple or date range based on [Air Datepicker
library](https://air-datepicker.com/). And two alias to select months or
years.

## Usage

``` r
airDatepickerInput(
  inputId,
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
  width = NULL
)

timepickerOptions(
  dateTimeSeparator = NULL,
  timeFormat = NULL,
  minHours = NULL,
  maxHours = NULL,
  minMinutes = NULL,
  maxMinutes = NULL,
  hoursStep = NULL,
  minutesStep = NULL
)

airMonthpickerInput(inputId, label = NULL, value = NULL, ...)

airYearpickerInput(inputId, label = NULL, value = NULL, ...)
```

## Arguments

- inputId:

  The `input` slot that will be used to access the value.

- label:

  Display label for the control, or `NULL` for no label.

- value:

  Initial value(s), dates as character string are accepted in
  `yyyy-mm-dd` format, or Date/POSIXct object. Can be a single value or
  several values.

- multiple:

  Select multiple dates. If `TRUE`, then one can select unlimited dates.
  If `numeric` is passed, then amount of selected dates will be limited
  by it.

- range:

  Select a date range.

- timepicker:

  Add a timepicker below calendar to select time.

- separator:

  Separator between dates when several are selected, default to `" - "`.

- placeholder:

  A character string giving the user a hint as to what can be entered
  into the control.

- dateFormat:

  Format to use to display date(s), default to `yyyy-MM-dd`, see [online
  documentation](https://air-datepicker.com/docs?scrollTo=dateFormat)
  for possible values.

- firstDay:

  Day index from which week will be started. Possible values are from 0
  to 6, where 0 - Sunday and 6 - Saturday. By default value is taken
  from current localization, but if it passed here then it will have
  higher priority.

- minDate:

  The minimum allowed date. Either a Date object, or a string in
  `yyyy-mm-dd` format.

- maxDate:

  The maximum allowed date. Either a Date object, or a string in
  `yyyy-mm-dd` format.

- disabledDates:

  A vector of dates to disable, e.g. won't be able to select one of
  dates passed.

- disabledDaysOfWeek:

  Day(s) of week to disable, numbers from 0 (Sunday) to 6 (Saturday).

- highlightedDates:

  A vector of dates to highlight.

- view:

  Starting view, one of `'days'` (default), `'months'` or `'years'`.

- startView:

  Date shown in calendar when date picker is opened.

- minView:

  Minimal view, one of `'days'` (default), `'months'` or `'years'`.

- monthsField:

  Names for the months when view is 'months', use `'monthsShort'` for
  abbreviations or `'months'` for full names.

- clearButton:

  If `TRUE`, then button "Clear" will be visible.

- todayButton:

  If `TRUE`, then button "Today" will be visible to set view to current
  date, if a `Date` is used, it will set view to the given date and
  select it..

- autoClose:

  If `TRUE`, then after date selection, datepicker will be closed.

- timepickerOpts:

  Options for timepicker, see `timepickerOptions()`.

- position:

  Where calendar should appear, a two word string like `'bottom left'`
  (default), or `'top right'`, `'left top'`.

- update_on:

  When to send selected value to server: on `'change'` or when calendar
  is `'close'`d.

- onlyTimepicker:

  Display only the time picker.

- toggleSelected:

  When `TRUE`, in range mode, it's not possible to select the same date
  as start and end.

- addon:

  Display a calendar icon to `'right'` or the `'left'` of the widget, or
  `'none'`. This icon act like an
  [`shiny::actionButton()`](https://rdrr.io/pkg/shiny/man/actionButton.html),
  you can retrieve value server-side with `input$<inputId>_button`.

- addonAttributes:

  A [`list()`](https://rdrr.io/r/base/list.html) of additional
  attributes to use for the addon tag, like `class` for example.

- language:

  Language to use, can be one of `ar`, `cs`, `da`, `de`, `en`, `es`,
  `fi`, `fr`, `hu`, `it`, `ja`, `ko`, `nl`, `pl`, `pt-BR`, `pt`, `ro`,
  `ru`, `si`, `sk`, `sv`, `th`, `tr`, `uk`, `zh`.

- tz:

  The timezone.

- inline:

  If `TRUE`, datepicker will always be visible.

- readonly:

  If `TRUE`, datepicker will be readonly and the input field won't be
  editable.

- onkeydown:

  Attribute passed to the input field.

- width:

  The width of the input, e.g. `'400px'`, or `100%`.

- dateTimeSeparator:

  Separator between date and time, default to `" "`.

- timeFormat:

  Desirable time format. You can use:

  - `h` — hours in 12-hour mode

  - `hh` — hours in 12-hour mode with leading zero

  - `H` — hours in 24-hour mode

  - `HH` — hours in 24-hour mode with leading zero

  - `m` — minutes

  - `mm` — minutes with leading zero

  - `aa` — day period lower case

  - `AA` — day period upper case

- minHours:

  Minimal hours value, must be between 0 and 23. You will not be able to
  choose value lower than this.

- maxHours:

  Maximum hours value, must be between 0 and 23. You will not be able to
  choose value higher than this.

- minMinutes:

  Minimal minutes value, must be between 0 and 59. You will not be able
  to choose value lower than this.

- maxMinutes:

  Maximum minutes value, must be between 0 and 59. You will not be able
  to choose value higher than this.

- hoursStep:

  Hours step in slider.

- minutesStep:

  Minutes step in slider.

- ...:

  Arguments passed to `airDatepickerInput`.

## Value

a `Date` object or a `POSIXct` in UTC timezone.

## Note

Since shinyWidgets 0.5.2 there's no more conflicts with
[`shiny::dateInput()`](https://rdrr.io/pkg/shiny/man/dateInput.html).

## See also

- [`demoAirDatepicker()`](https://dreamrs.github.io/shinyWidgets/reference/demoAirDatepicker.md)
  for demo apps

- [`updateAirDateInput()`](https://dreamrs.github.io/shinyWidgets/reference/updateAirDateInput.md)
  for updating from server

## Examples

``` r
if (interactive()) {

# examples of different options to select dates:
demoAirDatepicker("datepicker")

# select month(s)
demoAirDatepicker("months")

# select year(s)
demoAirDatepicker("years")

# select date and time
demoAirDatepicker("timepicker")

# You can select multiple dates :
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  airDatepickerInput(
    inputId = "multiple",
    label = "Select multiple dates:",
    placeholder = "You can pick 5 dates",
    multiple = 5, clearButton = TRUE
  ),
  verbatimTextOutput("res")
)

server <- function(input, output, session) {
  output$res <- renderPrint(input$multiple)
}

shinyApp(ui, server)

}
```
