
#' @title Circle Action button
#'
#' @description
#' Create a rounded action button.
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param icon An icon to appear on the button.
#' @param status Color of the button.
#' @param size Size of the button : default, lg, sm, xs.
#' @param ... Named attributes to be applied to the button.
#'
#'
#' @import shiny
#' @importFrom htmltools tagList singleton
#'
#' @export


circleButton <- function (inputId, icon = NULL, status = "default", size = "default", ...)
{
  attachShinyWidgetsDep(
    tags$button(
      id = inputId, type = "button",
      class = paste0("btn btn-", status, " action-button ", ifelse(size == "default", "btn-circle", paste0("btn-circle-", size))), icon, ...
    )
  )
}
