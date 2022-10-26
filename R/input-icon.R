
#' @title Create a text input control with icon(s)
#'
#' @description Extend form controls by adding text or icons before,
#'  after, or on both sides of a classic `textInput`.
#'
#' @inheritParams shiny::textInput
#' @param icon An [shiny::icon()] (or equivalent) or a `list`, containing `icon`s
#'  or text, to be displayed on the right or left of the text input.
#' @param size Size of the input, default to `NULL`, can
#'  be `"sm"` (small) or `"lg"` (large).
#'
#' @return A text input control that can be added to a UI definition.
#' @seealso See [updateTextInputIcon()] to update server-side, and [numericInputIcon()] for using numeric value.
#' @export
#'
#' @importFrom shiny restoreInput
#' @importFrom htmltools tags validateCssUnit
#'
#' @example examples/textInputIcon.R
textInputIcon <- function(inputId,
                          label,
                          value = "",
                          placeholder = NULL,
                          icon = NULL,
                          size = NULL,
                          width = NULL) {
  value <- shiny::restoreInput(id = inputId, default = value)
  tag <- tags$div(
    class = "form-group shiny-input-container",
    if (!is.null(label)) {
      tags$label(label, class = "control-label", `for` = inputId)
    },
    style = if (!is.null(width)) paste0("width: ", validateCssUnit(width), ";"),
    tags$div(
      class = "input-group",
      class = validate_size(size),
      markup_input_group(icon, "left", theme_func = shiny::getCurrentTheme),
      tags$input(
        id = inputId,
        type = "text",
        class = "form-control text-input-icon",
        value = value,
        placeholder = placeholder
      ),
      markup_input_group(icon, "right", theme_func = shiny::getCurrentTheme),
    )
  )
  attachShinyWidgetsDep(tag)
}

#' @title Change the value of a text input icon on the client
#'
#' @inheritParams shiny::updateTextInput
#' @param icon Icon to update, note that you can update icon only
#'  if initialized in [textInputIcon()].
#'
#' @return No value.
#' @seealso [textInputIcon()]
#' @export
#'
#' @importFrom htmltools doRenderTags
#'
#' @examples
#' library(shiny)
#' library(shinyWidgets)
#'
#' ui <- fluidPage(
#'   textInputIcon(
#'     inputId = "id",
#'     label = "With an icon",
#'     icon = icon("circle-user")
#'   ),
#'   actionButton("updateValue", "Update value"),
#'   actionButton("updateIcon", "Update icon"),
#'   verbatimTextOutput("value")
#' )
#'
#' server <- function(input, output, session) {
#'
#'   output$value <- renderPrint(input$id)
#'
#'   observeEvent(input$updateValue, {
#'     updateTextInputIcon(
#'       session = session,
#'       inputId = "id",
#'       value = paste(sample(letters, 8), collapse = "")
#'     )
#'   })
#'
#'   observeEvent(input$updateIcon, {
#'     i <- sample(c("home", "gears", "dollar-sign", "globe", "sliders-h"), 1)
#'     updateTextInputIcon(
#'       session = session,
#'       inputId = "id",
#'       icon = icon(i)
#'     )
#'   })
#'
#' }
#'
#' if (interactive())
#'   shinyApp(ui, server)
updateTextInputIcon <- function(session = getDefaultReactiveDomain(),
                                inputId,
                                label = NULL,
                                value = NULL,
                                placeholder = NULL,
                                icon = NULL) {
  right <- markup_input_group(icon, "right", theme_func = session$getCurrentTheme)
  if (!is.null(right))
    right <- as.character(right)
  left <- markup_input_group(icon, "left", theme_func = session$getCurrentTheme)
  if (!is.null(left))
    left <- as.character(left)
  message <- dropNulls(list(
    label = label,
    value = value,
    placeholder = placeholder,
    right = right,
    left = left
  ))
  session$sendInputMessage(inputId, message)
}






#' @title Create a numeric input control with icon(s)
#'
#' @description Extend form controls by adding text or icons before,
#'  after, or on both sides of a classic `numericInput`.
#'
#' @inheritParams shiny::numericInput
#' @inheritParams textInputIcon
#' @param help_text Help text placed below the widget and only
#'  displayed if value entered by user is outside of `min` and `max`.
#'
#' @return A numeric input control that can be added to a UI definition.
#' @seealso See [updateNumericInputIcon()] to update server-side, and [textInputIcon()] for using text value.
#' @export
#'
#' @importFrom shiny restoreInput
#' @importFrom htmltools tags validateCssUnit css
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
  tag <- tags$div(
    class = "form-group shiny-input-container",
    if (!is.null(label)) {
      tags$label(label, class = "control-label", `for` = inputId)
    },
    style = css(width = validateCssUnit(width)),
    tags$div(
      class = "input-group",
      class = validate_size(size),
      markup_input_group(icon, "left", theme_func = shiny::getCurrentTheme),
      tags$input(
        id = inputId,
        type = "number",
        class = "form-control numeric-input-icon",
        value = value,
        min = min,
        max = max,
        step = step
      ),
      markup_input_group(icon, "right", theme_func = shiny::getCurrentTheme)
    ),
    tags$span(class = "help-block invalid-feedback hidden d-none", help_text)
  )
  attachShinyWidgetsDep(tag)
}


#' @title Change the value of a numeric input icon on the client
#'
#' @inheritParams shiny::updateNumericInput
#' @param icon Icon to update, note that you can update icon only
#'  if initialized in [numericInputIcon()].
#'
#' @return No value.
#' @seealso [numericInputIcon()]
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
#'     inputId = "id",
#'     label = "With an icon",
#'     value = 10,
#'     icon = icon("percent")
#'   ),
#'   actionButton("updateValue", "Update value"),
#'   actionButton("updateIcon", "Update icon"),
#'   verbatimTextOutput("value")
#' )
#'
#' server <- function(input, output, session) {
#'
#'   output$value <- renderPrint(input$id)
#'
#'   observeEvent(input$updateValue, {
#'     updateNumericInputIcon(
#'       session = session,
#'       inputId = "id",
#'       value = sample.int(100, 1)
#'     )
#'   })
#'
#'   observeEvent(input$updateIcon, {
#'     i <- sample(c("home", "gears", "dollar-sign", "globe", "sliders-h"), 1)
#'     updateNumericInputIcon(
#'       session = session,
#'       inputId = "id",
#'       icon = icon(i)
#'     )
#'   })
#'
#' }
#'
#' if (interactive())
#'   shinyApp(ui, server)
updateNumericInputIcon <- function(session = getDefaultReactiveDomain(),
                                   inputId,
                                   label = NULL,
                                   value = NULL,
                                   min = NULL,
                                   max = NULL,
                                   step = NULL,
                                   icon = NULL) {
  right <- markup_input_group(icon, "right", theme_func = session$getCurrentTheme)
  if (!is.null(right))
    right <- as.character(right)
  left <- markup_input_group(icon, "left", theme_func = session$getCurrentTheme)
  if (!is.null(left))
    left <- as.character(left)
  message <- dropNulls(list(
    label = label,
    value = formatNoSci(value),
    min = formatNoSci(min),
    max = formatNoSci(max),
    step = formatNoSci(step),
    right = right,
    left = left
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

#' @importFrom htmltools tagList tagFunction
#' @importFrom shiny getCurrentTheme
#' @importFrom bslib is_bs_theme theme_version
markup_input_group <- function(icon, side = c("left", "right"), theme_func = NULL) {
  side <- match.arg(side)
  if (is.null(icon))
    return(NULL)
  if (inherits(icon, "shiny.tag") & side == "right")
    return(NULL)
  if (!inherits(icon, "shiny.tag") & length(icon) < 2)
    icon <- c(icon, list(NULL))
  if (!inherits(icon, "shiny.tag"))
    icon <- icon[which(side == c("left", "right"))]
  if (is.null(icon[[1]]))
    return(NULL)
  tagList(tagFunction(function() {
    if (is.function(theme_func))
      theme <- theme_func()
    if (!bslib::is_bs_theme(theme)) {
      return(markup_input_group_bs3(icon, side))
    }
    if (bslib::theme_version(theme) %in% c("5")) {
      return(markup_input_group_bs5(icon, side))
    }
    markup_input_group_bs3(icon, side)
  }))
}


markup_input_group_bs3 <- function(icon, side = c("left", "right")) {
  tags$div(
    class = "input-group-addon sw-input-icon",
    class = switch(
      side,
      left = "input-group-prepend",
      right = "input-group-append"
    ),
    tags$span(class = "input-group-text", icon)
  )
}

markup_input_group_bs5 <- function(icon, side = c("left", "right")) {
  tags$span(class = "input-group-text sw-input-icon", icon)
}
