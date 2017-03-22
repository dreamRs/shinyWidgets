
#' @title Circle Action button
#'
#' @description
#' Create a rounded action button.
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param icon An icon to appear on the button.
#' @param status Color of the button.
#' @param ... Named attributes to be applied to the button.
#'
#'
#' @import shiny
#' @importFrom htmltools tagList singleton
#'
#' @export


circleButton <- function (inputId, icon = NULL, status = "default", ...)
{
  htmltools::tagList(
    htmltools::singleton(
      tags$head(tags$link(rel='stylesheet', type='text/css',
                          href='shinyWidgets/circleButton/circle-button.css'))
    ),
    tags$button(id = inputId, type = "button",
      class = paste0("btn btn-", status, " btn-circle action-button"), icon, ...)
  )
}
