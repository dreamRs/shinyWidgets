# Calendar Pro Input

A versatile JavaScript date and time picker component, based on
[vanilla-calendar-pro](https://github.com/uvarov-frontend/vanilla-calendar-pro)
JavaScript library.

## Usage

``` r
calendarProInput(
  inputId,
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
  width = NULL
)
```

## Arguments

- inputId:

  The `input` slot that will be used to access the value.

- label:

  Display label for the control, or `NULL` for no label.

- value:

  Initial value.

- mode:

  This parameter determines whether selecting one or multiple days is
  allowed, or if date selection is completely disabled. Possible values
  are: 'single' \| 'multiple' \| 'multiple-ranged' \| false.

- type:

  Determines the type of calendar displayed and the selection process:
  'default' \| 'multiple' \| 'month' \| 'year'.

- displayDateMin:

  This parameter sets the minimum date that the user can choose. Dates
  earlier than the specified date will be disabled and not available for
  selection.

- displayDateMax:

  This parameter sets the maximum date that the user can choose. Dates
  later than the specified date will be disabled and not available for
  selection.

- firstWeekday:

  This parameter sets the first day of the week. Specify a number from 0
  to 6, where the number represents the day of the week identifier.
  According to JS standards, the days of the week start with 0, and 0 is
  Sunday.

- disableDatesPast:

  This parameter disables all past days.

- disableAllDates:

  This parameter disables all days and can be useful when using
  `enableDates` is set.

- disableWeekdays:

  This parameter allows you to disable specified weekdays. Specify an
  array with numbers, where each number represents a day of the week.
  For example, `0` is Sunday.

- disableDatesGaps:

  This parameter disables the selection of days within a range with
  disabled dates. It only works when `mode = "multiple-ranged"`.

- disableDates:

  This parameter allows you to disable specific dates regardless of the
  specified range.

- enableDates:

  This parameter allows you to enable specific dates regardless of the
  range and disabled dates.

- displayMonthsCount:

  The months parameter specifies the number of displayed months when the
  calendar type is set to 'multiple'.

- enableJumpToSelectedDate:

  When the option is enabled and 1 or more selected date(s) are provided
  but without providing selected.month and selected.year, it will make
  the calendar jump to the first selected date. If set to false, the
  calendar will always open to the current month and year.

- enableDateToggle:

  If true then clicking on a selected date again will deselect it.

- enableWeekNumbers:

  With this parameter, you can decide whether to display week numbers in
  the calendar.

- selectWeekNumbers:

  If `TRUE` select the week when week number is clicked.

- selectionTimeMode:

  This parameter enables time selection. You can also specify the time
  format using a boolean value or a number: 24-hour or 12-hour format.

- selectedTime:

  Initial time value.

- ...:

  Other settings passed to Calendar Pro JavaScript method, see [online
  documentation](https://vanilla-calendar.pro/docs/reference/settings)
  for reference.

- locale:

  This parameter sets the language localization of the calendar. You can
  specify a language label according to BCP 47 or provide arrays of
  month and weekday names. See [online
  documentation](https://vanilla-calendar.pro/docs/reference/settings#locale).

- format:

  Format to use when displaying date in input field, if an initial value
  is provided it must be a date so that the format apply.

- positionToInput:

  This parameter specifies the position of the calendar relative to
  input, if the calendar is initialized with the input parameter.
  Possible values: 'auto' \| 'center' \| 'left' \| 'right' \| c('bottom'
  \| 'top', 'center' \| 'left' \| 'right')

- selectedTheme:

  This parameter determines the theme of the calendar : 'light' or
  'dark'.

- placeholder:

  A character string giving the user a hint as to what can be entered
  into the control.

- inputMode:

  If `TRUE` (default), use an input and render calendar in a dropdown,
  otherwise calendar is rendered in the page.

- inline:

  Display calendar container inline.

- parseValue:

  Convert input value to date/datetime in server or not.

- width:

  The width of the input, e.g. `'400px'`, or `'100%'`; see
  [`validateCssUnit()`](https://rstudio.github.io/htmltools/reference/validateCssUnit.html).

## Value

- UI: A `shiny.tag` object that can be used in a UI definition.

- server: if `parseValue=FALSE` a **character** vector of dates
  selected, otherwise a Date/POSIXct objet.

## See also

[`updateCalendarPro()`](https://dreamrs.github.io/shinyWidgets/reference/updateCalendarPro.md)
to update the widget from the server.

## Examples

``` r
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  theme = bslib::bs_theme(5),
  tags$h2("Calendar Pro Input"),
  fluidRow(
    column(
      width = 6,
      calendarProInput(
        inputId = "cal1",
        label = "Calendar default:",
        placeholder = "Select a date",
        width = "100%"
      ),
      verbatimTextOutput("res1"),
      calendarProInput(
        inputId = "cal3",
        label = "Calendar with initial value:",
        value = Sys.Date() + 1,
        width = "100%"
      ),
      verbatimTextOutput("res3"),
      calendarProInput(
        inputId = "cal5",
        label = "Calendar without input field:",
        inputMode = FALSE,
        width = "300px"
      ),
      verbatimTextOutput("res5"),
      calendarProInput(
        inputId = "cal7",
        label = "Calendar with week numbers:",
        placeholder = "Select a date",
        enableWeekNumbers = TRUE,
        width = "100%"
      ),
      verbatimTextOutput("res7"),
      calendarProInput(
        inputId = "cal9",
        label = "Calendar with format and locale:",
        format = "%d/%m/%Y",
        locale = "fr",
        value = Sys.Date() + 1,
        width = "100%"
      ),
      verbatimTextOutput("res9"),
    ),
    column(
      width = 6,
      calendarProInput(
        inputId = "cal2",
        label = "Calendar with multiple selection:",
        mode = "multiple",
        placeholder = "Select multiple dates",
        width = "100%"
      ),
      verbatimTextOutput("res2"),
      calendarProInput(
        inputId = "cal4",
        label = "Calendar with range selection:",
        mode = "multiple-ranged",
        width = "100%"
      ),
      verbatimTextOutput("res4"),
      calendarProInput(
        inputId = "cal6",
        label = "Calendar (range) without input field:",
        mode = "multiple-ranged",
        type = "multiple",
        displayMonthsCount = 2,
        inputMode = FALSE,
        width = "100%"
      ),
      verbatimTextOutput("res6"),
      calendarProInput(
        inputId = "cal8",
        label = "Calendar select week:",
        mode = "multiple-ranged",
        enableWeekNumbers = TRUE,
        selectWeekNumbers = TRUE,
        width = "100%"
      ),
      verbatimTextOutput("res8")
    )
  )
)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$cal1)
  output$res2 <- renderPrint(input$cal2)
  output$res3 <- renderPrint(input$cal3)
  output$res4 <- renderPrint(input$cal4)
  output$res5 <- renderPrint(input$cal5)
  output$res6 <- renderPrint(input$cal6)
  output$res7 <- renderPrint(input$cal7)
  output$res8 <- renderPrint(input$cal8)
  output$res9 <- renderPrint(input$cal9)

}

if (interactive())
  shinyApp(ui, server)
```
