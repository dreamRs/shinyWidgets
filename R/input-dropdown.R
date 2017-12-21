#' @title Dropdown Button
#'
#' @description
#' Create a dropdown menu with Bootstrap
#'
#' @param ... List of tag to be displayed into the dropdown menu.
#' @param circle Logical. Use a circle button
#' @param icon An icon to appear on the button.
#' @param status Color, must be a valid Bootstrap status : default, primary, info, success, warning, danger.
#' @param size Size of the button : default, lg, sm, xs.
#' @param label Label to appear on the button. If circle = TRUE and tooltip = TRUE, label is used in tooltip.
#' @param tooltip Put a tooltip on the button, you can customize tooltip with \code{tooltipOptions}.
#' @param right Logical. The dropdown menu starts on the right.
#' @param up Logical. Display the dropdown menu above.
#' @param width Width of the dropdown menu content.
#' @param inputId Optionnal, id for the button, the button act like an \code{actionButton},
#' and you can use the id to toggle the droddown menu server-side.
#'
#'
#' @importFrom htmltools validateCssUnit tags tagList
#'
#' @export
#' @examples
#' \dontrun{
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'
#' dropdownButton(
#'  "Your contents goes here ! You can pass several elements",
#'  circle = TRUE, status = "danger", icon = icon("gear"), width = "300px",
#'  tooltip = tooltipOptions(title = "Click to see inputs !")
#' )
#'
#' }
#' }
dropdownButton <- function(..., circle = TRUE, status = "default",
                           size = "default", icon = NULL,
                           label = NULL, tooltip = FALSE, right =
                             FALSE, up = FALSE, width = NULL,
                           inputId = NULL) {

  status <- match.arg(
    arg = status,
    choices = c("default", "primary", "success", "info", "warning", "danger")
  )
  size <- match.arg(arg = size, choices = c("default", "lg", "sm", "xs"))
  if (is.null(inputId)) {
    inputId <- paste0("drop", sample.int(1e9, 1))
  }

  # dropdown content
  html_ul <- list(
    class = paste("dropdown-menu", ifelse(right, "dropdown-menu-right", "")),
    class = "dropdown-shinyWidgets",
    id = paste("dropdown-menu", inputId, sep = "-"),
    style = if (!is.null(width))
      paste0("width: ", htmltools::validateCssUnit(width), ";"),
    `aria-labelledby` = inputId,
    lapply(X = list(...), FUN = htmltools::tags$li, style =
             "margin-left: 10px; margin-right: 10px;")
  )

  # button
  if (circle) {
    html_button <- circleButton(
      inputId = inputId, icon = icon, status = status, size = size,
      class = "dropdown-toggle",
      # onclick = paste0("$(this).parent().toggleClass('open');")
      `data-toggle` = "dropdown"
    )
  } else {
    html_button <- list(
      class = paste0("btn btn-", status," action-button dropdown-toggle "),
      class = if (size != "default") paste0("btn-", size),
      type = "button",
      id = inputId,
      `data-toggle` = "dropdown",
      # onclick = paste0("$(this).parent().toggleClass('open');"),
      `aria-haspopup` = "true",
      `aria-expanded` = "true",
      list(icon, label),
      tags$span(class = "caret")
    )
    html_button <- do.call(htmltools::tags$button, html_button)
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
    tooltipJs <- htmltools::tags$script(
      sprintf(
        "$('#%s').tooltip({ placement: '%s', title: '%s', html: %s });",
        inputId, tooltip$placement, tooltip$title, tooltip$html
      )
    )
  } else {
    tooltipJs <- ""
  }

  dropdownTag <- htmltools::tags$div(
    class = ifelse(up, "dropup", "dropdown"),
    html_button,
    do.call(htmltools::tags$ul, html_ul),
    tooltipJs
  )
  attachShinyWidgetsDep(dropdownTag, "dropdown")
}


#' @title Tooltip options
#'
#' @description
#' List of options for tooltip for a dropdown menu button
#'
#' @param placement Placement of tooltip : right, top, bottom, left.
#' @param title Text of the tooltip
#' @param html Logical, allow HTML tags inside tooltip
#'
#'
#' @export

tooltipOptions <- function(placement = "right", title = "Params", html
                           = FALSE) {
  list(placement = placement, title = title, html = html)
}




#' Toggle a dropdown menu
#'
#' Open or close a dropdown menu server-side
#'
#' @param inputId Id for the dropdown to toggle
#'
#' @export
#'
# @examples
toggleDropdownButton <- function(inputId) {
  session <- shiny::getDefaultReactiveDomain()
  session$sendCustomMessage(
    type = "toggle-dropdown-button", list(id = inputId)
  )
}
