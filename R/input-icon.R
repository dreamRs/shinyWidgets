
#' @title Create a text input control with icon(s)
#'
#' @description Extend form controls by adding text or icons before,
#'  after, or on both sides of a classic \code{textInput}.
#'
#' @inheritParams shiny::textInput
#' @param icon An \code{icon} or a \code{list}, containing \code{icon}s
#'  or text, to be displayed on the right or left of the text input.
#' @param size Size of the input, default to \code{NULL}, can
#'  be \code{"sm"} (small) or \code{"lg"} (large).
#'
#' @return A text input control that can be added to a UI definition.
#' @export
#'
#' @importFrom shiny restoreInput
#' @importFrom htmltools tags validateCssUnit
#'
#' @example examples/textInputIcon.R
textInputIcon <- function(inputId, label, value = "", placeholder = NULL,
                          icon = NULL, size = NULL, width = NULL) {
  value <- shiny::restoreInput(id = inputId, default = value)
  addons <- validate_addon(icon)
  tags$div(
    class = "form-group shiny-input-container",
    if (!is.null(label)) {
      tags$label(label, `for` = inputId)
    },
    style = if (!is.null(width)) paste0("width: ", validateCssUnit(width), ";"),
    tags$div(
      class = "input-group",
      class = validate_size(size),
      addons$left, tags$input(
        id = inputId,
        type = "text",
        class = "form-control",
        value = value,
        placeholder = placeholder
      ), addons$right
    )
  )
}




#' @title Create a numeric input control with icon(s)
#'
#' @description Extend form controls by adding text or icons before,
#'  after, or on both sides of a classic \code{numericInput}.
#'
#' @inheritParams shiny::numericInput
#' @param icon An \code{icon} or a \code{list}, containing \code{icon}s
#'  or text, to be displayed on the right or left of the numeric input.
#' @param size Size of the input, default to \code{NULL}, can
#'  be \code{"sm"} (small) or \code{"lg"} (large).
#'
#' @return A numeric input control that can be added to a UI definition.
#' @export
#'
#' @importFrom shiny restoreInput
#' @importFrom htmltools tags validateCssUnit
#'
#' @example examples/numericInputIcon.R
numericInputIcon <- function(inputId, label, value,
                             min = NULL, max = NULL, step = NULL,
                             icon = NULL, size = NULL, width = NULL) {
  value <- shiny::restoreInput(id = inputId, default = value)
  addons <- validate_addon(icon)
  tags$div(
    class = "form-group shiny-input-container",
    if (!is.null(label)) {
      tags$label(label, `for` = inputId)
    },
    style = if (!is.null(width)) paste0("width: ", validateCssUnit(width), ";"),
    tags$div(
      class = "input-group",
      class = validate_size(size),
      addons$left, tags$input(
        id = inputId,
        type = "number",
        class = "form-control",
        value = value,
        min = min,
        max = max,
        step = step
      ), addons$right
    )
  )
}

validate_size <- function(size) {
  if (is.null(size) || !nchar(size)) {
    return(NULL)
  } else {
    size <- match.arg(arg = size, choices = c("sm", "lg"))
    return(paste0("input-group-", size))
  }
}

validate_addon <- function(icon) {
  if (!is.null(icon)) {
    if (inherits(icon, "shiny.tag")) {
      left <- tags$span(class = "input-group-addon", icon)
      right <- NULL
    } else if (inherits(icon, "list")) {
      if (length(icon) <= 1) {
        left <- tags$span(class = "input-group-addon", icon)
        right <- NULL
      } else {
        left <- if (!is.null(icon[[1]])) {
          tags$span(class = "input-group-addon", icon[[1]])
        } else {
          NULL
        }
        right <- tags$span(class = "input-group-addon", icon[[2]])
      }
    } else {
      stop("InputIcon: icon must be an icon or a list.")
    }
  } else {
    left <- right <- NULL
  }
  list(left = left, right = right)
}




