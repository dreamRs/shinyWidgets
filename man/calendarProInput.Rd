% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calendar-pro-input.R
\name{calendarProInput}
\alias{calendarProInput}
\title{Calendar Pro Input}
\usage{
calendarProInput(
  inputId,
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
  format = "\%Y-\%m-\%d",
  positionToInput = "auto",
  theme = "light",
  placeholder = NULL,
  input = TRUE,
  inline = FALSE,
  parseValue = TRUE,
  width = NULL
)
}
\arguments{
\item{inputId}{The \code{input} slot that will be used to access the value.}

\item{label}{Display label for the control, or \code{NULL} for no label.}

\item{value}{Initial value.}

\item{type}{Determines the type of calendar displayed and the selection process: 'default' | 'multiple' | 'range' | 'month' | 'year'.}

\item{min}{This parameter sets the minimum date that the user can choose. Dates earlier than the specified date will be disabled and not available for selection.}

\item{max}{This parameter sets the maximum date that the user can choose. Dates later than the specified date will be disabled and not available for selection.}

\item{disablePast}{This parameter disables all past days.}

\item{disableAllDays}{This parameter disables all days and can be useful when using \code{enable} is set.}

\item{disableWeekday}{This parameter allows you to disable specified weekdays. Specify an array with numbers, where each number represents a day of the week. For example, \code{0} is Sunday.}

\item{disableGaps}{This parameter disables the selection of days within a range with disabled dates. It only works when \code{type = "range"}.}

\item{disabled}{This parameter allows you to disable specific dates regardless of the specified range.}

\item{enabled}{This parameter allows you to enable specific dates regardless of the range and disabled dates.}

\item{months}{The months parameter specifies the number of displayed months when the calendar type is set to 'multiple'.}

\item{jumpMonths}{The jumpMonths parameter controls the number of months to jump.}

\item{jumpToSelectedDate}{When the option is enabled and 1 or more selected date(s) are provided but without providing
selected.month and selected.year, it will make the calendar jump to the first selected date. If set to false,
the calendar will always open to the current month and year.}

\item{toggleSelected}{If toggleSelected parameter is true then clicking on the active cell will remove the selection from it.}

\item{weekNumbers}{With this parameter, you can decide whether to display week numbers in the calendar.}

\item{weekNumbersSelect}{If \code{TRUE} select the week when week number is clicked.}

\item{weekend}{This parameter allows you to highlight weekends in the calendar.}

\item{time}{This parameter enables time selection. You can also specify the time format using a boolean value or a number: 24-hour or 12-hour format.}

\item{timeValue}{Initial time value.}

\item{...}{Other settings passed to Slim Select JAvaScript method.}

\item{format}{Format to use when displaying date in input field, if an initial value is provided it must be a date so that the format apply.}

\item{positionToInput}{This parameter specifies the position of the calendar relative to input,
if the calendar is initialized with the input parameter. Possible values: 'auto' | 'center' | 'left' | 'right' | c('bottom' | 'top', 'center' | 'left' | 'right')}

\item{theme}{This parameter determines the theme of the calendar : 'light' or 'dark'.}

\item{placeholder}{A character string giving the user a hint as to what can be entered into the control.}

\item{input}{If \code{TRUE} (default), use an input and render calendar in a dropdown, otherwise calendar is rendered in the page.}

\item{inline}{Display calendar container inline.}

\item{parseValue}{Convert input value to date/datetime in server or not.}

\item{width}{The width of the input, e.g. \code{'400px'}, or \code{'100\%'};
see \code{\link[shiny:validateCssUnit]{validateCssUnit()}}.}
}
\value{
\itemize{
\item UI: A \code{shiny.tag} object that can be used in a UI definition.
\item server: a \strong{character} vector of dates selected
}
}
\description{
A versatile JavaScript date and time picker component,
based on \href{https://github.com/uvarov-frontend/vanilla-calendar-pro}{vanilla-calendar-pro} JavaScript library.
}
\examples{

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
        width = "100\%"
      ),
      verbatimTextOutput("res1"),
      calendarProInput(
        inputId = "cal3",
        label = "Calendar with initial value:",
        format = "\%d/\%m/\%Y",
        value = Sys.Date() + 1,
        width = "100\%"
      ),
      verbatimTextOutput("res3"),
      calendarProInput(
        inputId = "cal5",
        label = "Calendar without input field:",
        input = FALSE,
        width = "100\%"
      ),
      verbatimTextOutput("res5"),
      calendarProInput(
        inputId = "cal7",
        label = "Calendar with week numbers:",
        placeholder = "Select a date",
        weekNumbers = TRUE,
        width = "100\%"
      ),
      verbatimTextOutput("res7")
    ),
    column(
      width = 6,
      calendarProInput(
        inputId = "cal2",
        label = "Calendar with multiple selection:",
        type = "multiple",
        placeholder = "Select multiple dates",
        width = "100\%"
      ),
      verbatimTextOutput("res2"),
      calendarProInput(
        inputId = "cal4",
        label = "Calendar with range selection:",
        type = "range",
        width = "100\%"
      ),
      verbatimTextOutput("res4"),
      calendarProInput(
        inputId = "cal6",
        label = "Calendar (range) without input field:",
        type = "range",
        months = 3,
        input = FALSE,
        width = "100\%"
      ),
      verbatimTextOutput("res6"),
      calendarProInput(
        inputId = "cal8",
        label = "Calendar select week:",
        type = "range",
        weekNumbers = TRUE,
        weekNumbersSelect = TRUE,
        width = "100\%"
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

}

if (interactive())
  shinyApp(ui, server)
}
