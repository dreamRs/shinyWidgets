
#' @title Buttons Group Radio Input Control
#'
#' @description
#' Create buttons grouped that act like radio buttons.
#'
#' @inheritParams shiny::radioButtons
#' @param status Add a class to the buttons, you can use Bootstrap status like 'info', 'primary', 'danger', 'warning' or 'success'.
#'  Or use an arbitrary strings to add a custom class, e.g. : with `status = "custom-class"`, buttons will have class `btn-custom-class`.
#' @param size Size of the buttons ('xs', 'sm', 'normal', 'lg')
#' @param direction Horizontal or vertical
#' @param justified If TRUE, fill the width of the parent div
#' @param individual If TRUE, buttons are separated.
#' @param checkIcon A list, if no empty must contain at least one element named 'yes'
#'  corresponding to an icon to display if the button is checked.
#' @param disabled Initialize buttons in a disabled state (users won't be able to select a value).
#'
#'
#' @return A buttons group control that can be added to a UI definition.
#'
#' @seealso [updateRadioGroupButtons()]
#'
#' @importFrom shiny restoreInput getCurrentTheme
#' @importFrom htmltools tags HTML validateCssUnit css tagFunction
#'
#' @export
#'
#' @example examples/radioGroupButtons.R
radioGroupButtons <- function(inputId,
                              label = NULL,
                              choices = NULL,
                              selected = NULL,
                              status = "default",
                              size = "normal",
                              direction = "horizontal",
                              justified = FALSE,
                              individual = FALSE,
                              checkIcon = list(),
                              width = NULL,
                              choiceNames = NULL,
                              choiceValues = NULL,
                              disabled = FALSE) {
  args <- normalizeChoicesArgs(choices, choiceNames, choiceValues)
  selected <- shiny::restoreInput(id = inputId, default = selected)
  if (!is.null(selected) && length(selected) > 1)
    stop("selected must be length 1")
  if (is.null(selected))
    selected <- args$choiceValues[[1]]
  size <- match.arg(arg = size, choices = c("xs", "sm", "normal", "lg"))
  direction <- match.arg(arg = direction, choices = c("horizontal", "vertical"))

  divClass <- if (individual) "" else "btn-group"
  if (!individual & direction == "vertical") {
    divClass <- paste0(divClass, "-vertical")
  }
  if (isTRUE(justified)) {
    if (direction != "vertical") {
      divClass <- paste(divClass, "btn-group-justified d-flex")
    } else {
      divClass <- paste(divClass, "btn-block")
    }
  }
  if (size != "normal") {
    divClass <- paste0(divClass, " btn-group-", size)
  }

  TAG <- tags$div(
    class = "form-group shiny-input-container shiny-input-radiogroup shiny-input-container-inline",
    style = css(width = validateCssUnit(width)),
    tags$label(
      id = paste0(inputId, "-label"),
      class = "control-label",
      `for` = inputId,
      label,
      class = if (is.null(label)) "shiny-label-null",
    ),
    if (!is.null(label)) tags$br(),
    tags$div(
      id = inputId,
      class = "radio-group-buttons",
      style = if (justified) "width: 100%;",
      tags$div(
        class = divClass,
        role = "group",
        `aria-labelledby` = paste0(inputId, "-label"),
        `data-toggle` = "buttons",
        class = "btn-group-container-sw",
        style = if (direction == "vertical") css(width = validateCssUnit(width)),
        htmltools::tagFunction(function() {
          markup_buttons_radio(
            shiny::getCurrentTheme(),
            list(
              inputId = inputId,
              choices = args,
              selected = selected,
              status = status,
              size = size,
              checkIcon = checkIcon,
              disabled = disabled,
              justified = justified
            )
          )
        })
      )
    )
  )
  attachShinyWidgetsDep(TAG)
}

#' @importFrom bslib is_bs_theme theme_version
markup_buttons_radio <- function(theme, args) {
  if (!bslib::is_bs_theme(theme)) {
    return(do.call(markup_buttons_radio_bs3, args))
  }
  if (bslib::theme_version(theme) %in% c("5")) {
    return(do.call(markup_buttons_radio_bs5, args))
  }
  do.call(markup_buttons_radio_bs3, args)
}

markup_buttons_radio_bs3 <- function(inputId, choices, selected, status, size, checkIcon, disabled = FALSE, justified = FALSE) {
  btn_wrapper <- function(...) {
    htmltools::tags$div(
      class = "btn-group btn-group-toggle",
      class = if (!identical(size, "normal")) paste0("btn-group-", size),
      class = if (isTRUE(justified)) "w-100",
      role = "group",
      ...
    )
  }
  if (!is.null(checkIcon) && !is.null(checkIcon$yes)) {
    displayIcon <- TRUE
  } else {
    displayIcon <- FALSE
  }
  mapply(
    FUN = function(name, value, statusElement) {
      btn_wrapper(
        tags$button(
          class = paste0("btn radiobtn btn-", statusElement),
          class = if (value %in% selected) "active",
          if (displayIcon) tags$span(class="radio-btn-icon-yes", checkIcon$yes),
          if (displayIcon) tags$span(class="radio-btn-icon-no", checkIcon$no),
          disabled = if (isTRUE(disabled)) "disabled",
          class = if (isTRUE(disabled)) "disabled",
          tags$input(
            type = "radio",
            autocomplete = "off",
            name = inputId,
            value = value,
            checked = if (value %in% selected) "checked"
          ),
          if (is.list(name)) name else HTML(name)
        )
      )
    },
    name = choices$choiceNames,
    value = choices$choiceValues,
    statusElement = rep(status, length.out = length(choices$choiceNames)),
    SIMPLIFY = FALSE,
    USE.NAMES = FALSE
  )
}


markup_buttons_radio_bs5 <- function(inputId, choices, selected, status, size, checkIcon, disabled = FALSE, justified = FALSE) {
  if (!is.null(checkIcon) && !is.null(checkIcon$yes)) {
    displayIcon <- TRUE
  } else {
    displayIcon <- FALSE
  }
  mapply(
    FUN = function(name, value, statusElement) {
      if (identical(statusElement, "default"))
        statusElement <- "outline-primary"
      tagList(
        tags$input(
          type = "radio",
          autocomplete = "off",
          id = paste0(inputId, which(choices$choiceValues == value)),
          name = inputId,
          value = value,
          class = "btn-check",
          checked = if (value %in% selected) "checked"
        ),
        tags$label(
          class = paste0("btn radiobtn btn-", statusElement),
          disabled = if (isTRUE(disabled)) "disabled",
          class = if (isTRUE(disabled)) "disabled",
          `for` = paste0(inputId, which(choices$choiceValues == value)),
          if (displayIcon) tags$span(class = "radio-btn-icon-yes", checkIcon$yes),
          if (displayIcon) tags$span(class = "radio-btn-icon-no", checkIcon$no),
          if (is.list(name)) name else HTML(name)
        )
      )
    },
    name = choices$choiceNames,
    value = choices$choiceValues,
    statusElement = rep(status, length.out = length(choices$choiceNames)),
    SIMPLIFY = FALSE,
    USE.NAMES = FALSE
  )
}



#' @title Change the value of a radio group buttons input on the client
#'
#' @description
#' Change the value of a radio group buttons input on the client
#'
#' @inheritParams shiny::updateRadioButtons
#' @inheritParams radioGroupButtons
#' @param disabled Logical, disable or enable buttons,
#'  if `TRUE` users won't be able to select a value.
#' @param disabledChoices Vector of specific choices to disable.
#'
#' @export
#'
#' @seealso [radioGroupButtons()]
#'
#' @importFrom htmltools tagList doRenderTags
#' @importFrom shiny getDefaultReactiveDomain
#'
#' @example examples/update-radio-buttons.R
updateRadioGroupButtons <- function(session = getDefaultReactiveDomain(),
                                    inputId,
                                    label = NULL,
                                    choices = NULL,
                                    selected = NULL,
                                    status = "default",
                                    size = "normal",
                                    justified = FALSE,
                                    checkIcon = list(),
                                    choiceNames = NULL,
                                    choiceValues = NULL,
                                    disabled = FALSE,
                                    disabledChoices = NULL) {
  args <- normalizeChoicesArgs(choices, choiceNames, choiceValues, mustExist = FALSE)
  if (!is.null(selected))
    selected <- as.character(selected)
  if (is.null(selected) && !is.null(args$choiceValues)) {
    selected <- args$choiceValues[[1]]
  }
  if (!is.null(disabledChoices))
    disabledChoices <- as.character(disabledChoices)
  options <- if (!is.null(args$choiceValues)) {
    doRenderTags(markup_buttons_radio(
      session$getCurrentTheme(),
      list(
        inputId = session$ns(inputId),
        choices = args,
        selected = selected,
        status = status,
        size = size,
        checkIcon = checkIcon,
        justified = justified
      )
    ))
  }
  message <- dropNulls(list(
    selected = selected,
    options = options,
    label = label,
    disabled = isTRUE(disabled),
    disabledChoices = list1(disabledChoices)
  ))
  session$sendInputMessage(inputId, message)
}

