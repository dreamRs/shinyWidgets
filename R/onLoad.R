#' Adds the content of www to shinyWidgets/
#'
#' @importFrom shiny addResourcePath registerInputHandler
#'
#' @noRd
#'
.onLoad <- function(...) {
  shiny::addResourcePath("shinyWidgets", system.file("assets", package = "shinyWidgets"))
  shiny::registerInputHandler("sw.numericRange", function(data, ...) {
    if (is.null(data)) {
      NULL
    } else {
      data[vapply(data, is.null, logical(1))] <- NA
      result <- as.numeric(unlist(data))
      if (all(is.na(result))) {
        return(NULL)
      } else {
        return(result)
      }
    }
  }, force = TRUE)
  shiny::registerInputHandler("air.date", function(data, ...) {
    if (is.null(data))
      return(NULL)
    if (!is.list(data))
      return(NULL)
    if (is.null(data$date))
      return(NULL)
    res <- try(as.Date(unlist(data$date)), silent = TRUE)
    if (inherits(res, "try-error")) {
      warning("Failed to parse dates!")
      # as.Date(NA)
      data
    } else {
      res
    }
  }, force = TRUE)
  shiny::registerInputHandler("air.datetime", function(data, ...) {
    if (is.null(data))
      return(NULL)
    if (!is.list(data))
      return(NULL)
    if (is.null(data$date))
      return(NULL)
    tz <- data$tz %||% ""
    res <- try(as.POSIXct(unlist(data$date), tz = tz), silent = TRUE)
    if (inherits(res, "try-error")) {
      warning("Failed to parse dates!")
      # as.Date(NA)
      data
    } else {
      res
    }
  }, force = TRUE)
  shiny::registerInputHandler("sw.tree", function(data, ...) {
    if (is.null(data) || length(data) < 1) {
      NULL
    } else {
      return(unlist(data, use.names = FALSE))
    }
  }, force = TRUE)
  shiny::registerInputHandler("sw.tree.all", function(data, ...) {
    if (is.null(data)) {
      NULL
    } else {
      data
    }
  }, force = TRUE)
  shiny::registerInputHandler("calendarPro.date", function(data, ...) {
    if (length(data) < 1 || length(data$selectedDates) < 1)
      return(NULL)
    if (!is.null(data$selectedTime)) {
      fmt <- if (grepl(pattern = "(A|P)M", x = data$selectedTime)) {
        "%Y-%m-%d %I:%M %p"
      } else {
        "%Y-%m-%d %H:%M"
      }
      res <- try(as.POSIXct(
        paste(unlist(data$selectedDates), data$selectedTime),
        format = fmt
      ), silent = TRUE)
    } else {
      res <- try(as.Date(unlist(data$selectedDates)), silent = TRUE)
    }
    if (inherits(res, "try-error")) {
      warning("calendarProInput: Failed to parse dates, try using parseValue = FALSE", call. = FALSE)
      data
    } else {
      res
    }
  }, force = TRUE)
  shiny::registerInputHandler("calendarPro.monthyear", function(data, ...) {
    if (length(data) < 1)
      return(NULL)
    res <- try(as.Date(
      paste(
        data$selectedYear,
        data$selectedMonth + 1,
        "01",
        sep = "-"
      )
    ), silent = TRUE)
    if (inherits(res, "try-error")) {
      warning("calendarProInput: Failed to parse dates, try using parseValue = FALSE", call. = FALSE)
      data
    } else {
      res
    }
  }, force = TRUE)
  shiny::registerInputHandler("calendarPro.raw", function(data, ...) {
    if (length(data) < 1)
      return(NULL)
    return(data)
  }, force = TRUE)
}
