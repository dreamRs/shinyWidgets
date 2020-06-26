
#' @title Create a text input control with icon(s)
#'
#' @description Extend form controls by adding text or icons before,
#'  after, or on both sides of a classic \code{textInput}.
#'
#' @inheritParams shiny::textInput
#' @param icon An \code{icon} or a \code{list}, containing \code{icon}s
#'  or text, to be displayed on the right or left of the text input.
#' @param size Size of the input, default to \code{NULL}, can
#'  be \code{"sm"} (small) or \code{"lg"} (large).
#'
#' @return A text input control that can be added to a UI definition.
#' @export
#'
#' @importFrom shiny restoreInput
#' @importFrom htmltools tags validateCssUnit
#'
#' @example examples/textInputIcon.R
textInputIcon <- function(inputId, label, value = "", placeholder = NULL,
                          icon = NULL, size = NULL, width = NULL) {
  value <- shiny::restoreInput(id = inputId, default = value)
  addons <- validate_addon(icon)
  tags$div(
    class = "form-group shiny-input-container",
    if (!is.null(label)) {
      tags$label(label, class = "control-label", `for` = inputId)
    },
    style = if (!is.null(width)) paste0("width: ", validateCssUnit(width), ";"),
    tags$div(
      class = "input-group",
      class = validate_size(size),
      addons$left, tags$input(
        id = inputId,
        type = "text",
        class = "form-control",
        value = value,
        placeholder = placeholder
      ), addons$right
    )
  )
}

#' @title Change the value of a text input icon on the client
#'
#' @inheritParams shiny::updateTextInput
#'
#' @return No value.
#' @export
#'
#' @importFrom shiny updateTextInput
#'
#' @examples
#' library(shiny)
#' library(shinyWidgets)
#'
#' ui <- fluidPage(
#'   textInputIcon(
#'     inputId = "ex1",
#'     label = "With an icon",
#'     icon = icon("user-circle-o")
#'   ),
#'   actionButton("update", "Random value")
#' )
#'
#' server <- function(input, output, session) {
#'
#'   observeEvent(input$update, {
#'     updateTextInputIcon(
#'       session = session,
#'       inputId = "ex1",
#'       value = paste(sample(letters, 8), collapse = "")
#'     )
#'   })
#'
#' }
#'
#' if (interactive())
#'   shinyApp(ui, server)
updateTextInputIcon <- shiny::updateTextInput





#' @title Create a numeric input control with icon(s)
#'
#' @description Extend form controls by adding text or icons before,
#'  after, or on both sides of a classic \code{numericInput}.
#'
#' @inheritParams shiny::numericInput
#' @param icon An \code{icon} or a \code{list}, containing \code{icon}s
#'  or text, to be displayed on the right or left of the numeric input.
#' @param size Size of the input, default to \code{NULL}, can
#'  be \code{"sm"} (small) or \code{"lg"} (large).
#' @param help_text Help text placed below the widget and only
#'  displayed if value entered by user is outside of \code{min} and \code{max}.
#'
#' @return A numeric input control that can be added to a UI definition.
#' @export
#'
#' @importFrom shiny restoreInput
#' @importFrom htmltools tags validateCssUnit
#'
#' @example examples/numericInputIcon.R
numericInputIcon <- function(inputId,
                             label,
                             value,
                             min = NULL,
                             max = NULL,
                             step = NULL,
                             icon = NULL,
                             size = NULL,
                             help_text = NULL,
                             width = NULL) {
  value <- shiny::restoreInput(id = inputId, default = value)
  addons <- validate_addon(icon)
  tag <- tags$div(
    class = "form-group shiny-input-container",
    if (!is.null(label)) {
      tags$label(label, class = "control-label", `for` = inputId)
    },
    style = if (!is.null(width)) paste0("width: ", validateCssUnit(width), ";"),
    tags$div(
      class = "input-group",
      class = validate_size(size),
      addons$left, tags$input(
        id = inputId,
        type = "number",
        class = "form-control shinywidgets-numeric",
        value = value,
        min = min,
        max = max,
        step = step
      ), addons$right
    ),
    tags$span(class = "help-block hidden", help_text)
  )
  attachShinyWidgetsDep(tag)
}


#' @title Change the value of a numeric input icon on the client
#'
#' @inheritParams shiny::updateNumericInput
#' @param icon Icon to update, note that you can update icon only
#'  if initialized in \code{\link{numericInputIcon}}.
#'
#' @return No value.
#' @export
#'
#' @importFrom htmltools doRenderTags
#'
#' @examples
#' library(shiny)
#' library(shinyWidgets)
#'
#' ui <- fluidPage(
#'   numericInputIcon(
#'     inputId = "ex1",
#'     label = "With an icon",
#'     value = 10,
#'     icon = icon("percent")
#'   ),
#'   actionButton("update", "Random value")
#' )
#'
#' server <- function(input, output, session) {
#'
#'   observeEvent(input$update, {
#'     updateNumericInputIcon(
#'       session = session,
#'       inputId = "ex1",
#'       value = sample.int(100, 1)
#'     )
#'   })
#'
#' }
#'
#' if (interactive())
#'   shinyApp(ui, server)
updateNumericInputIcon <- function(session,
                                   inputId,
                                   label = NULL,
                                   value = NULL,
                                   min = NULL,
                                   max = NULL,
                                   step = NULL,
                                   icon = NULL) {
  addons <- validate_addon(icon)
  if (!is.null(addons$right))
    addons$right <- htmltools::doRenderTags(addons$right)
  if (!is.null(addons$left))
    addons$left <- htmltools::doRenderTags(addons$left)
  message <- dropNulls(list(
    label = label,
    value = formatNoSci(value),
    min = formatNoSci(min),
    max = formatNoSci(max),
    step = formatNoSci(step),
    right = addons$right,
    left = addons$left
  ))
  session$sendInputMessage(inputId, message)
}




validate_size <- function(size) {
  if (is.null(size) || !nchar(size)) {
    return(NULL)
  } else {
    size <- match.arg(arg = size, choices = c("sm", "lg"))
    return(paste0("input-group-", size))
  }
}

validate_addon <- function(icon) {
  if (!is.null(icon)) {
    if (inherits(icon, "shiny.tag")) {
      left <- tags$span(class = "input-group-addon", icon)
      right <- NULL
    } else if (inherits(icon, "list")) {
      if (length(icon) <= 1) {
        left <- tags$span(class = "input-group-addon", icon)
        right <- NULL
      } else {
        left <- if (!is.null(icon[[1]])) {
          tags$span(class = "input-group-addon", icon[[1]])
        } else {
          NULL
        }
        right <- tags$span(class = "input-group-addon", icon[[2]])
      }
    } else {
      stop("InputIcon: icon must be an icon or a list.")
    }
  } else {
    left <- right <- NULL
  }
  list(left = left, right = right)
}




