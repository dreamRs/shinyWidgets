
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
#' @importFrom shiny restoreInput
#' @importFrom htmltools tagList
#'
#' @export


circleButton <- function (inputId, icon = NULL, status = "default", size = "default", ...)
{
  value <- shiny::restoreInput(id = inputId, default = NULL)
  size <- match.arg(arg = size, choices = c("default", "lg", "sm", "xs"))
  attachShinyWidgetsDep(
    htmltools::tags$button(
      id = inputId, type = "button", style = "outline: none;", `data-val` = value,
      class = paste0("btn btn-", status, " action-button ",
                     ifelse(size == "default", "btn-circle",
                            paste0("btn-circle-", size))), icon, ...
    )
  )
}




squareButton <- function (inputId, icon = NULL, status = "default", size = "default", ...)
{
  size <- match.arg(arg = size, choices = c("default", "lg", "sm", "xs"))
  attachShinyWidgetsDep(
    htmltools::tags$button(
      id = inputId, type = "button", style = "outline: none;",
      class = paste0("btn btn-", status, " action-button ",
                     ifelse(size == "default", "btn-square",
                            paste0("btn-square-", size))), icon, ...
    )
  )
}
