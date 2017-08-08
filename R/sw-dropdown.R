#' @title Dropdown
#'
#' @description
#' Create a dropdown menu
#'
#' @param ... List of tag to be displayed into the dropdown menu.
#' @param style Character. if \code{default} use Bootstrap button (like an \code{actionButton}), else use an
#' \code{actionBttn}, see argument \code{style} for possible values.
#' @param icon An icon to appear on the button.
#' @param status Color, must be a valid Bootstrap status : default, primary, info, success, warning, danger.
#' @param size Size of the button : default, lg, sm, xs.
#' @param label Label to appear on the button. If circle = TRUE and tooltip = TRUE, label is used in tooltip.
#' @param tooltip Put a tooltip on the button, you can customize tooltip with \code{tooltipOptions}.
#' @param right Logical. The dropdown menu starts on the right.
#' @param up Logical. Display the dropdown menu above.
#' @param width Width of the dropdown menu content.
#' @param animate Add animation on the dropdown, can be logical or result of \code{animateOptions}.
#'
#' @details
#' This function is similar to \code{dropdownButton} but don't use Boostrap, so you can put \code{pickerInput} in it.
#' Moreover you can add animations on the appearance / disappearance of the dropdown with animate.css.
#'
#' @seealso \code{\link{animateOptions}} for animation, \code{\link{tooltipOptions}} for tooltip and
#' \code{\link{actionBttn}} for the button.
#'
#' @import shiny
#' @importFrom htmltools validateCssUnit tagList singleton
#'
#' @export
#' @examples
#' \dontrun{
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'
#' dropdown(
#'   "Content goes here",
#'   style = "unite", icon = icon("gear"), status = "danger", width = "300px",
#'   animate = animateOptions(
#'     enter = animations$fading_entrances$fadeInLeftBig,
#'     exit = animations$fading_exits$fadeOutRightBig
#'   )
#' )
#'
#' }
#' }
dropdown <- function(..., style = "default", status = "default", size = "md", icon = NULL,
                     label = NULL, tooltip = FALSE, right = FALSE, up = FALSE, width = NULL, animate = FALSE) {


  alea <- sample.int(1e9, 1)
  btnId <- paste0("sw-btn-", alea)
  dropId <- paste0("sw-drop-", alea)
  contentId <- paste0("sw-content-", alea)

  # Dropdown content
  dropcontent <- tags$div(
    id=contentId, class="sw-dropdown-content animated",
    class=if(up) "sw-dropup-content", class=if(right) "sw-dropright-content",
    style=if(!is.null(width)) paste("width:", htmltools::validateCssUnit(width)),
    # shiny::conditionalPanel(condition = paste0("input['", btnId, "'] > 0"), ...)
    ...
  )
  # Button
  if (style == "default") {
    status <- match.arg(
      arg = status,
      choices = c("default", "primary", "success", "info", "warning", "danger")
    )
    btn <- tags$button(
      class = paste0("btn btn-", status," ", ifelse(size == "default" | size == "md", "", paste0("btn-", size))),
      type = "button", id = btnId, list(icon, label),
      tags$span(class = ifelse(up, "glyphicon glyphicon-triangle-top", "glyphicon glyphicon-triangle-bottom"))
    )
  } else {
    btn <- actionBttn(inputId = btnId, label = label, icon = icon, style = style, color = status, size = size)
  }


  # Final tag
  dropdownTag <- tags$div(class = "sw-dropdown", id=dropId, btn, dropcontent)


  # Tooltip
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
    tooltipJs <- tags$script(
      sprintf(
        "$('#%s').tooltip({ placement: '%s', title: '%s', html: %s });",
        btnId, tooltip$placement, tooltip$title, tooltip$html
      )
    )
    dropdownTag <- htmltools::tagAppendChild(dropdownTag, tooltipJs)
  }

  # Animate
  if (identical(animate, TRUE))
    animate <- animateOptions()

  if (!is.null(animate) && !identical(animate, FALSE)) {
    dropdownTag <- htmltools::tagAppendChild(
      dropdownTag,tags$script(
        sprintf(
          "$(function() {swDrop('%s', '%s', '%s', '%s', '%s', '%s');});",
          btnId, contentId, dropId,
          animate$enter, animate$exit, as.character(animate$duration)
        )
      )
    )
    dropdownTag <- attachShinyWidgetsDep(dropdownTag, "animate")
  } else {
    dropdownTag <- htmltools::tagAppendChild(
      dropdownTag,tags$script(
        sprintf(
          "$(function() {swDrop('%s', '%s', '%s', '%s', '%s', '%s');});",
          btnId, contentId, dropId, "sw-none", "sw-none", "1"
        )
      )
    )
  }

  # dependancies
  attachShinyWidgetsDep(dropdownTag, "sw-dropdown")
}






#' Animate options
#'
#' @param enter Animation name on appearance
#' @param exit Animation name on disappearance
#' @param duration Duration of the animation
#'
#' @return a list
#' @export
#'
#' @seealso \code{\link{animations}}
#'
#'
#' @examples
#' \dontrun{
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'
#' dropdown(
#'  "Your contents goes here ! You can pass several elements",
#'  circle = TRUE, status = "danger", icon = icon("gear"), width = "300px",
#'  animate = animateOptions(enter = "fadeInDown", exit = "fadeOutUp", duration = 3)
#' )
#'
#' }
#' }
animateOptions <- function(enter = "fadeInDown", exit = "fadeOutUp", duration = 1) {
  list(enter = enter, exit = exit, duration = duration)
}





#' @title Animation names
#'
#' @description List of all animations by categories
#'
#' @format A list of lists
#' @source \url{https://github.com/daneden/animate.css/blob/master/animate-config.json}
"animations"





