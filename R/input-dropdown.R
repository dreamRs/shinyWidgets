
#' @title Dropdown Button
#'
#' @description
#' Create a dropdown menu
#'
#' @param ... List of tag to be displayed into the dropdown menu.
#' @param circle Logical. Use a circle button
#' @param icon An icon to appear on the button.
#' @param status Color of the button.
#' @param label Label to appear on the button. If circle = TRUE and tooltip = TRUE, label is used in tooltip
#' @param tooltip Put a tooltip on the button
#' @param width Width of the dropdown menu
#'
#'
#' @import shiny
#' @importFrom htmltools validateCssUnit tagList singleton
#'
#' @export


dropdownButton <- function(..., circle = TRUE, status = "default", icon = NULL,
                           label = NULL, tooltip = FALSE, width = NULL) {

  status <- match.arg(arg = status, choices = c("default", "primary", "success", "info", "warning", "danger"))
  buttonID <- paste0("drop", sample.int(1e9, 1))

  # dropdown content
  html_ul <- list(
    class = "dropdown-menu",
    style = if (!is.null(width))
      paste0("width: ", validateCssUnit(width), ";"),
    `aria-labelledby` = buttonID,
    lapply(X = list(...), FUN = tags$li, style = "margin-left: 10px; margin-right: 10px;")
  )

  # button
  if (circle) {
    html_button <- circleButton(
      inputId = buttonID, icon = icon, status = status,
      class = "btn-lg dropdown-toggle", `data-toggle` = "dropdown"
    )
  } else {
    html_button <- list(
      class = paste0("btn btn-", status," dropdown-toggle"),
      type = "button",
      id = buttonID,
      `data-toggle` = "dropdown",
      `aria-haspopup` = "true",
      `aria-expanded` = "true",
      label,
      tags$span(class = "caret")
    )
    html_button <- do.call(tags$button, html_button)
  }

  # tooltip
  if (identical(tooltip, TRUE))
    tooltip <- tooltipOptions(title = label)

  if (!is.null(tooltip) && !identical(tooltip, FALSE)) {
    tooltip <- lapply(tooltip, function(x) {
      if (identical(x, TRUE))
        "true"
      else if (identical(x, FALSE))
        "false"
      else x
    })
    js_tooltip <- tags$script(
      # whisker::whisker.render(
      #   template = "$('#{{buttonID}}').tooltip({ placement: '{{{placement}}}', title: '{{{title}}}', html: {{{html}}} });",
      #   data = list(buttonID = buttonID, placement = tooltip$placement,
      #               title = tooltip$title, html = tooltip$html)
      # )
      sprintf(
        "$('#%s').tooltip({ placement: '%s', title: '%s', html: %s });",
        buttonID, tooltip$placement, tooltip$title, tooltip$html
      )
    )
  } else {
    js_tooltip <- ""
  }

  tags$div(
    class = "dropdown",
    html_button,
    do.call(tags$ul, html_ul),
    tags$script("$('.dropdown-menu').click(function(e) {e.stopPropagation();});"),
    js_tooltip
  )
}


#' @title Tooltip options
#'
#' @description
#' List of options for tooltip for a dropdown menu button
#'
#' @param placement Placement of tooltip : right, top, bottom, left.
#' @param title Text of the tooltip
#' @param html Logical.
#'
#'
#' @export

tooltipOptions <- function(placement = "right", title = "Params", html = FALSE) {
  list(placement = placement, title = title, html = html)
}

