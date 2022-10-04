#' Adds the content of www to shinyWidgets/
#'
#' @importFrom shiny addResourcePath registerInputHandler
#'
#' @noRd
#'
.onLoad <- function(...) {
  shiny::addResourcePath('shinyWidgets', system.file("assets", package = "shinyWidgets"))
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
    if (is.null(data)) {
      NULL
    } else {
      res <- try(anytime::anydate(unlist(data)), silent = TRUE)
      if ("try-error" %in% class(res)) {
        warning("Failed to parse dates!")
        # as.Date(NA)
        data
      } else {
        res
      }
    }
  }, force = TRUE)
  shiny::registerInputHandler("air.datetime", function(data, ...) {
    if (is.null(data)) {
      NULL
    } else {
      res <- try(anytime::anytime(unlist(data)), silent = TRUE)
      if ("try-error" %in% class(res)) {
        warning("Failed to parse dates!")
        # as.Date(NA)
        data
      } else {
        res
      }
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
}
