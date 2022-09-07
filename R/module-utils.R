
# utils used for modules



`%inT%` <- function(x, table) {
  if (!is.null(table) && ! "" %in% table) {
    x %in% table
  } else {
    rep_len(TRUE, length(x))
  }
}



`%inF%` <- function(x, table) {
  if (!is.null(table) && ! "" %in% table) {
    x %in% table
  } else {
    rep_len(FALSE, length(x))
  }
}

ws2underscore <- function(x) {
  gsub(" ", "_", x)
}

#' Hide/Show an HTML tag
#'
#' @return a script tag.
#' @noRd
toggleDisplayUi <- function() {
  htmltools::tags$script(
    paste(
      "Shiny.addCustomMessageHandler('toggleDisplay',",
      "function(data) {",
      "$('#' + data.id).css('display', data.display);",
      "});",
      sep = "\n"
    )
  )
}
#'  Toggle Input Server
#'
#' @param session shiny session.
#' @param id shiny input id.
#' @param display character, 'none' to hide, 'block' or 'inline-block' to show
#'
#' @noRd
toggleDisplayServer <- function(session, id, display = c("none", "block", "inline-block", "table-cell")) {
  display <- match.arg(display)
  session$sendCustomMessage(
    type = 'toggleDisplay',
    message = list(id = id, display = display)
  )
}
