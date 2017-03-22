#' @title Actions Buttons Group Inputs
#'
#' @description
#' Create a group of actions buttons.
#'
#' @param inputIds The \code{input}s slot that will be used to access the value, one for each button.
#' @param labels Display a text in the center of each button.
#' @param status Color of the buttons
#' @param size Size of the buttons ('xs', 'sm', 'normal', 'lg')
#' @param direction Horizontal or vertical
#' @param fullwidth If TRUE, fill the width of the parent div
#' @return An actions buttons group control that can be added to a UI definition.
#'
#' @import shiny
#'
#' @export
#'


actionGroupButtons <-
  function(inputIds,
           labels,
           status = "default",
           size = "normal",
           direction = "horizontal",
           fullwidth = FALSE) {
    stopifnot(length(inputIds) == length(labels))
    size <-
      match.arg(arg = size,
                choices = c("xs", "sm", "normal", "lg"))
    direction <-
      match.arg(arg = direction,
                choices = c("horizontal", "vertical"))
    if (size == "normal") {
      if (direction == "horizontal") {
        div_class <- "btn-group"
        if (fullwidth) {
          div_class <- paste(div_class, "btn-group-justified")
        }
      } else {
        div_class <- "btn-group-vertical"
      }
    } else {
      if (direction == "horizontal") {
        div_class <- paste0("btn-group btn-group-", size)
        if (fullwidth) {
          div_class <- paste(div_class, "btn-group-justified")
        }
      } else {
        div_class <- paste0("btn-group-vertical btn-group-", size)
      }
    }
    status <-
      match.arg(
        arg = status,
        choices = c("default", "primary", "success", "info", "warning", "danger")
      )
    tags$div(
      class = div_class,
      role = "group",
      `aria-label` = "...",
      lapply(
        X = seq_along(labels),
        FUN = function(i) {
          tags$div(
            class = "btn-group",
            role = "group",
            tags$button(
              id = inputIds[i],
              type = "button",
              class = paste0("btn action-button btn-", status),
              labels[i]
            )
          )
        }
      )
    )
  }
