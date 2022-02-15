
#' @title Bootstrap panel / alert
#'
#' @description Create a panel (box) with basic border and padding,
#' you can use Bootstrap status to style the panel,
#' see \url{https://getbootstrap.com/docs/3.4/components/#panels}.
#'
#' @param ... UI elements to include inside the panel or alert.
#' @param heading Title for the panel in a plain header.
#' @param footer Footer for the panel.
#' @param extra Additional elements to include like a table or a \code{list_group}, see examples.
#' @param status Bootstrap status for contextual alternative.
#'
#' @return A UI definition.
#' @export
#'
#' @name bootstrap-utils
#'
#' @importFrom htmltools tags
#'
#' @example examples/panel.R
#' @example examples/alert.R
#' @example examples/list_group.R
panel <- function(...,
                  heading = NULL,
                  footer = NULL,
                  extra = NULL,
                  status = c("default", "primary", "success", "info", "warning", "danger")) {
  status <- match.arg(
    arg = status,
    choices = c("default", "primary", "success", "info", "warning", "danger")
  )
  if (...length() > 0) {
    body <- tags$div(class = "panel-body card-body", ...)
  } else {
    body <- NULL
  }
  if (!is.null(heading)) {
    heading <- tags$div(
      class = "panel-heading card-header",
      class = paste0("bg-", status),
      if (is.character(heading))
        tags$h3(class = "panel-title m-0 card-title", heading)
      else
        heading
    )
  }
  tags$div(
    class = sprintf("panel card mb-3 panel-%1$s border-%1$s", status),
    heading, body, extra,
    if (!is.null(footer)) tags$div(class = "panel-footer card-footer", footer)
  )
}


#' @param dismissible Adds the possibility to close the alert.
#' @export
#' @rdname bootstrap-utils
#' @importFrom htmltools tags HTML tagFunction
alert <- function(..., status = c("info", "success", "danger", "warning"), dismissible = FALSE) {
  status <- match.arg(status)
  if (!isTRUE(dismissible)) {
    return(tags$div(
      class = paste0("alert alert-", status),
      ...
    ))
  }
  tagFunction(function() {
    theme <- shiny::getCurrentTheme()
    if (!bslib::is_bs_theme(theme)) {
      return(markup_alert_dismiss_bs3(..., status = status))
    }
    if (bslib::theme_version(theme) %in% c("5")) {
      return(markup_alert_dismiss_bs5(..., status = status))
    }
    markup_alert_dismiss_bs3(..., status = status)
  })
}

markup_alert_dismiss_bs3 <- function(..., status) {
  tags$div(
    class = sprintf("alert alert-%s alert-dismissible", status),
    tags$button(
      type = "button",
      class = "close",
      `data-dismiss` = "alert",
      `aria-label` = "Close",
      tags$span(`aria-hidden` = "true", HTML("&times;"))
    ),
    ...
  )
}

markup_alert_dismiss_bs5 <- function(..., status) {
  tags$div(
    class = sprintf("alert alert-%s alert-dismissible", status),
    tags$button(
      type = "button",
      class = "btn-close",
      `data-bs-dismiss` = "alert",
      `aria-label` = "Close"
    ),
    ...
  )
}


#' @export
#' @rdname bootstrap-utils
#' @importFrom htmltools tags
list_group <- function(...) {
  tags$ul(
    class = "list-group",
    lapply(
      X = list(...),
      FUN = function(x) {
        # tags$li(class = "list-group-item", x)
        do.call(tags$li, c(list(class = "list-group-item"), x))
      }
    )
  )
}










