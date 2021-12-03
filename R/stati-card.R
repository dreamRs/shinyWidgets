
#' Minimal statistic cards
#'
#' @param value Value to display.
#' @param subtitle A subtitle to describe the value.
#' @param icon An optional icon created with \code{icon()}.
#' @param left Display value and subtitle to the right.
#' @param color Text color.
#' @param background Background color.
#' @param animate Add an animation when value is displayed.
#' @param duration Duration of animation.
#' @param id An id that can be used to update the card server-side.
#'
#' @note Based on work by Dastanbek and ArielDavid on codepen.io
#'
#' @return A UI definition.
#' @export
#'
#' @name stati-card
#'
#' @importFrom htmltools tags
#'
#' @example examples/ex-stati-card.R
statiCard <- function(value,
                      subtitle,
                      icon = NULL,
                      left = FALSE,
                      color = "steelblue",
                      background = "white",
                      animate = FALSE,
                      duration = 2000,
                      id = NULL) {
  if (is.null(id))
    id <- paste0("stati-value-", sample.int(1e6, 1))
  tags$div(
    html_dependency_stati(),
    class = "stati",
    class = if (isTRUE(left)) "left",
    style = sprintf("color:%s; background:%s;", color, background),
    if (!isTRUE(left)) icon,
    tags$div(
      class = "stati-content",
      tags$b(
        class = "stati-value",
        class = if (isTRUE(animate)) "stati-card-animated",
        style = if (isTRUE(animate)) sprintf("fill:%s;", color),
        id = id,
        `data-value` = value,
        `data-duration` = duration,
        title = value,
        if (!isTRUE(animate)) value
      ),
      tags$span(
        class = "stati-subtitle",
        subtitle,
        title = subtitle,
        style = if (isTRUE(animate)) "margin-top: -12px;"
      )
    ),
    if (isTRUE(left)) icon,
  )
}

#' @param session Shiny session.
#'
#' @export
#'
#' @rdname stati-card
#'
#' @importFrom shiny getDefaultReactiveDomain
updateStatiCard <- function(id,
                            value,
                            duration = 2000,
                            session = getDefaultReactiveDomain()) {
  session$sendInputMessage(
    inputId = id,
    message = list(
      id = session$ns(id),
      value = value,
      duration = duration
    )
  )
}
