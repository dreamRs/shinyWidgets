
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
#' @param min The date.min parameter sets the minimum allowable date that the calendar will consider, which cannot be earlier than this date.
#' @param max The date.max parameter sets the maximum allowable date that the calendar will consider, which cannot be later than this date.
#' @param type Determines the type of calendar displayed: 'default' | 'multiple' | 'month' | 'year'.
#' @param range TRUE or FALSE, in case of multiple type, allow to select a range of dates.
#' @param months The months parameter specifies the number of displayed months when the calendar type is set to 'multiple'.
#' @param jumpMonths The jumpMonths parameter controls the number of months to jump.
#' @param jumpToSelectedDate When the option is enabled and 1 or more selected date(s) are provided but without providing
#'  selected.month and selected.year, it will make the calendar jump to the first selected date. If set to false,
#'  the calendar will always open to the current month and year.
#' @param toggleSelected If toggleSelected parameter is true then clicking on the active cell will remove the selection from it.
#' @param ... Other settings passed to Slim Select JAvaScript method.
#' @param theme This parameter determines the theme of the calendar : 'light' or 'dark'.
#' @param placeholder A character string giving the user a hint as to what can be entered into the control.
#' @param input If `TRUE` (default), use an input and render calendar in a dropdown, otherwise calendar is rendered in the page.
#' @param inline Display calendar container inline.
#'
#' @return
#'  * UI: A `shiny.tag` object that can be used in a UI definition.
#'  * server: a **character** vector of dates selected
#' @export
#'
#' @example examples/calendar-pro.R
calendarProInput <- function(inputId,
                             label,
                             value = NULL,
                             min = NULL,
                             max = NULL,
                             type = c("default", "multiple", "month", "year"),
                             range = FALSE,
                             months = 2,
                             jumpMonths = 1,
                             jumpToSelectedDate = FALSE,
                             toggleSelected = TRUE,
                             ...,
                             theme = "light",
                             placeholder = NULL,
                             input = TRUE,
                             inline = FALSE,
                             width = NULL) {
  # selected <- restoreInput(id = inputId, default = selected)
  config <- list(
    type = match.arg(type),
    months = months,
    jumpMonths = jumpMonths,
    jumpToSelectedDate = jumpToSelectedDate,
    toggleSelected = toggleSelected,
    ...
  )
  config$input <- input
  config$settings$selected$dates <- list1(value)
  if (config$type == "multiple")
    config$settings$selection$day <- "multiple"
  if (isTRUE(range))
    config$settings$selection$day <- "multiple-ranged"
  config$date$min <- min
  config$date$max <- max
  config$settings$visibility$theme <- theme
  tag_el <- if (isTRUE(input)) {
    tags$input(
      type = "text",
      class = "form-control calendar-pro-element",
      readonly = NA,
      placeholder = placeholder,
      value = value
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

