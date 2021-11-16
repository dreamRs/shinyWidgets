
#' @title Pretty Switch Input
#'
#' @description A toggle switch to replace checkbox
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label Display label for the control, or \code{NULL} for no label.
#' @param value Initial value (\code{TRUE} or \code{FALSE}).
#' @param status Add a class to the switch, you can use Bootstrap status like 'info', 'primary', 'danger', 'warning' or 'success'.
#' @param slim Change the style of the switch (\code{TRUE} or \code{FALSE}), see examples.
#' @param fill Change the style of the switch (\code{TRUE} or \code{FALSE}), see examples.
#' @param bigger Scale the switch a bit bigger (\code{TRUE} or \code{FALSE}).
#' @param inline Display the input inline, if you want to place switch next to each other.
#' @param width The width of the input, e.g. `400px`, or `100%`.
#'
#' @note Appearance is better in a browser such as Chrome than in RStudio Viewer
#'
#' @seealso See \code{\link{updatePrettySwitch}} to update the value server-side.
#'
#' @return \code{TRUE} or \code{FALSE} server-side.
#' @export
#'
#' @importFrom htmltools validateCssUnit tags
#' @importFrom shiny restoreInput
#'
#' @example examples/prettySwitch.R
prettySwitch <- function(inputId,
                         label,
                         value = FALSE,
                         status = "default",
                         slim = FALSE,
                         fill = FALSE,
                         bigger = FALSE,
                         inline = FALSE,
                         width = NULL) {
  value <- shiny::restoreInput(id = inputId, default = value)
  status <- match.arg(status, c("default", "primary", "success",
                                "info", "danger", "warning"))
  inputTag <- tags$input(id = inputId, type = "checkbox")
  if (!is.null(value) && value)
    inputTag$attribs$checked <- "checked"
  if (fill & slim)
    message("slim = TRUE & fill = TRUE don't work well together.")
  switchTag <- tags$div(
    class = "form-group shiny-input-container",
    style = if (!is.null(width))  paste0("width: ", validateCssUnit(width), ";"),
    class = if (inline) "shiny-input-container-inline",
    style = if (inline) "display: inline-block; margin-right: 10px;",
    tags$div(
      class="pretty p-default p-switch", inputTag,
      class=if(bigger) "p-bigger",
      class=if(fill) "p-fill", class=if(slim) "p-slim",
      tags$div(
        class="state",
        class=if(status != "default") paste0("p-", status),
        tags$label(tags$span(label))
      )
    )
  )
  attachShinyWidgetsDep(switchTag, "pretty")
}


#' Change the value of a pretty switch on the client
#'
#' @param session The session object passed to function given to shinyServer.
#' @param inputId The id of the input object.
#' @param label The label to set for the input object.
#' @param value The value to set for the input object.
#'
#' @export
#'
#' @example examples/updatePrettySwitch.R
updatePrettySwitch <- function(session = getDefaultReactiveDomain(),
                               inputId,
                               label = NULL,
                               value = NULL) {
  message <- dropNulls(list(label = label, value = value))
  session$sendInputMessage(inputId, message)
}





#' @title Pretty Toggle Input
#'
#' @description A single checkbox that changes appearance if checked or not.
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label_on Display label for the control when value is \code{TRUE}.
#' @param label_off Display label for the control when value is \code{FALSE}
#' @param icon_on Optional, display an icon on the checkbox when value is \code{TRUE}, must be an icon created with \code{icon}.
#' @param icon_off Optional, display an icon on the checkbox when value is \code{FALSE}, must be an icon created with \code{icon}.
#' @param value Initial value (\code{TRUE} or \code{FALSE}).
#' @param status_on Add a class to the checkbox when value is \code{TRUE},
#' you can use Bootstrap status like 'info', 'primary', 'danger', 'warning' or 'success'.
#' @param status_off Add a class to the checkbox when value is \code{FALSE},
#' you can use Bootstrap status like 'info', 'primary', 'danger', 'warning' or 'success'.
#' @param shape Shape of the checkbox between \code{square}, \code{curve} and \code{round}.
#' @param outline Color also the border of the checkbox (\code{TRUE} or \code{FALSE}).
#' @param fill Fill the checkbox with color (\code{TRUE} or \code{FALSE}).
#' @param thick Make the content inside checkbox smaller (\code{TRUE} or \code{FALSE}).
#' @param plain Remove the border when checkbox is checked (\code{TRUE} or \code{FALSE}).
#' @param bigger Scale the checkboxes a bit bigger (\code{TRUE} or \code{FALSE}).
#' @param animation Add an animation when checkbox is checked, a value between
#' \code{smooth}, \code{jelly}, \code{tada}, \code{rotate}, \code{pulse}.
#' @param inline Display the input inline, if you want to place checkboxes next to each other.
#' @param width The width of the input, e.g. `400px`, or `100%`.
#'
#' @seealso See \code{\link{updatePrettyToggle}} to update the value server-side.
#'
#' @return \code{TRUE} or \code{FALSE} server-side.
#' @export
#'
#' @importFrom htmltools validateCssUnit tags
#' @importFrom shiny restoreInput
#'
#' @example examples/prettyToggle.R
prettyToggle <- function(inputId,
                         label_on,
                         label_off,
                         icon_on = NULL,
                         icon_off = NULL,
                         value = FALSE,
                         status_on = "success",
                         status_off = "danger",
                         shape = c("square", "curve", "round"),
                         outline = FALSE,
                         fill = FALSE,
                         thick = FALSE,
                         plain = FALSE,
                         bigger = FALSE,
                         animation = NULL,
                         inline = FALSE,
                         width = NULL) {
  value <- shiny::restoreInput(id = inputId, default = value)
  status_on <- match.arg(status_on, c("default", "primary", "success",
                                      "info", "danger", "warning"))
  status_off <- match.arg(status_off, c("default", "primary",
                                        "success", "info", "danger", "warning"))
  shape <- match.arg(shape)
  if(!is.null(icon_on)) {
    icon_on <- validateIcon(icon_on)
    icon_on$attribs$class <- paste("icon", icon_on$attribs$class)
  }
  if(!is.null(icon_off)) {
    icon_off <- validateIcon(icon_off)
    icon_off$attribs$class <- paste("icon", icon_off$attribs$class)
  }
  if (!is.null(animation))
    animation <- match.arg(animation, c("smooth", "jelly", "tada",
                                        "rotate", "pulse"))
  inputTag <- tags$input(id = inputId, type = "checkbox")
  if (!is.null(value) && value)
    inputTag$attribs$checked <- "checked"
  toggleTag <- tags$div(
    class = "form-group shiny-input-container",
    style = if (!is.null(width))  paste0("width: ", validateCssUnit(width), ";"),
    class = if (inline) "shiny-input-container-inline",
    style = if (inline) "display: inline-block; margin-right: 10px;",
    tags$div(
      class = "pretty p-toggle", inputTag,
      class = if(is.null(icon_on) & is.null(icon_off)) "p-default",
      class = if(plain) "p-plain",
      class = if(bigger) "p-bigger",
      class = if(shape!="square") paste0("p-", shape),
      class = if(fill) "p-fill", class=if(thick) "p-thick",
      class = if(!is.null(icon_on) | !is.null(icon_off)) "p-icon",
      class = if(!is.null(animation)) paste0("p-", animation),
      tags$div(
        class = "state p-on",
        class = if(status_on != "default") paste0("p-", status_on, if(outline)"-o"),
        if(!is.null(icon_on)) icon_on,
        tags$label(tags$span(label_on))
      ),
      tags$div(
        class = "state p-off",
        class = if(status_off != "default") paste0("p-", status_off, if(outline)"-o"),
        if(!is.null(icon_off)) icon_off,
        tags$label(tags$span(label_off))
      )
    )
  )
  attachShinyWidgetsDep(toggleTag, "pretty")
}


#' Change the value of a pretty toggle on the client
#'
#' @param session The session object passed to function given to shinyServer.
#' @param inputId The id of the input object.
#' @param label The label to set for the input object.
#' @param value The value to set for the input object.
#'
#' @export
#'
#' @example examples/updatePrettyToggle.R
updatePrettyToggle <- function(session = getDefaultReactiveDomain(),
                               inputId,
                               label = NULL,
                               value = NULL) {
  message <- dropNulls(list(label = label, value = value))
  session$sendInputMessage(inputId, message)
}








#' @title Pretty Checkbox Input
#'
#' @description Create a pretty checkbox that can be used to specify logical values.
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label Display label for the control.
#' @param value Initial value (\code{TRUE} or \code{FALSE}).
#' @param status Add a class to the checkbox,
#' you can use Bootstrap status like 'info', 'primary', 'danger', 'warning' or 'success'.
#' @param shape Shape of the checkbox between \code{square}, \code{curve} and \code{round}.
#' @param outline Color also the border of the checkbox (\code{TRUE} or \code{FALSE}).
#' @param fill Fill the checkbox with color (\code{TRUE} or \code{FALSE}).
#' @param thick Make the content inside checkbox smaller (\code{TRUE} or \code{FALSE}).
#' @param animation Add an animation when checkbox is checked, a value between
#' \code{smooth}, \code{jelly}, \code{tada}, \code{rotate}, \code{pulse}.
#' @param icon Optional, display an icon on the checkbox, must be an icon created with \code{icon}.
#' @param plain Remove the border when checkbox is checked (\code{TRUE} or \code{FALSE}).
#' @param bigger Scale the checkboxes a bit bigger (\code{TRUE} or \code{FALSE}).
#' @param inline Display the input inline, if you want to place checkboxes next to each other.
#' @param width The width of the input, e.g. `400px`, or `100%`.
#'
#' @note Due to the nature of different checkbox design, certain animations are not applicable in some arguments combinations.
#' You can find examples on the pretty-checkbox official page : \url{https://lokesh-coder.github.io/pretty-checkbox/}.
#'
#' @seealso See \code{\link{updatePrettyCheckbox}} to update the value server-side. See \code{\link{prettySwitch}} and
#' \code{\link{prettyToggle}} for similar widgets.
#'
#' @return \code{TRUE} or \code{FALSE} server-side.
#' @export
#'
#' @importFrom htmltools validateCssUnit tags
#' @importFrom shiny restoreInput
#'
#' @example examples/prettyCheckbox.R
prettyCheckbox <- function(inputId,
                           label,
                           value = FALSE,
                           status = "default",
                           shape = c("square", "curve", "round"),
                           outline = FALSE,
                           fill = FALSE,
                           thick = FALSE,
                           animation = NULL,
                           icon = NULL,
                           plain = FALSE,
                           bigger = FALSE,
                           inline = FALSE,
                           width = NULL) {
  value <- shiny::restoreInput(id = inputId, default = value)
  status <- match.arg(status, c("default", "primary", "success",
                                "info", "danger", "warning"))
  shape <- match.arg(shape)
  if(!is.null(icon)) {
    icon <- validateIcon(icon)
    icon$attribs$class <- paste("icon", icon$attribs$class)
  }
  if (!is.null(animation))
    animation <- match.arg(animation, c("smooth", "jelly", "tada",
                                        "rotate", "pulse"))
  inputTag <- tags$input(id = inputId, type = "checkbox")
  if (!is.null(value) && value)
    inputTag$attribs$checked <- "checked"
  checkTag <- tags$div(
    class = "form-group shiny-input-container",
    style = if (!is.null(width))  paste0("width: ", validateCssUnit(width), ";"),
    class = if (inline) "shiny-input-container-inline",
    style = if (inline) "display: inline-block; margin-right: 10px;",
    tags$div(
      class = "pretty", inputTag,
      class = if(is.null(icon)) "p-default",
      class = if(plain) "p-plain",
      class = if(bigger) "p-bigger",
      class = if(shape!="square") paste0("p-", shape),
      class = if(fill) "p-fill", class=if(thick) "p-thick",
      class = if(!is.null(animation)) paste0("p-", animation),
      class = if(!is.null(icon)) "p-icon",
      tags$div(
        class = "state",
        class = if(status != "default") paste0("p-", status, if(outline)"-o"),
        if(!is.null(icon)) icon,
        tags$label(tags$span(label))
      )
    )
  )
  attachShinyWidgetsDep(checkTag, "pretty")
}


#' Change the value of a pretty checkbox on the client
#'
#' @param session The session object passed to function given to shinyServer.
#' @param inputId The id of the input object.
#' @param label The label to set for the input object.
#' @param value The value to set for the input object.
#'
#' @export
#'
#' @example examples/updatePrettyCheckbox.R
updatePrettyCheckbox <- function(session = getDefaultReactiveDomain(),
                                 inputId,
                                 label = NULL,
                                 value = NULL) {
  message <- dropNulls(list(label = label, value = value))
  session$sendInputMessage(inputId, message)
}







#' @title Pretty Checkbox Group Input Control
#'
#' @description Create a group of pretty checkboxes that can be
#' used to toggle multiple choices independently. The
#' server will receive the input as a character vector
#' of the selected values.
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label Display label for the control.
#' @param choices List of values to show checkboxes for. If elements of the list
#'  are named then that name rather than the value is displayed to the user. If
#'  this argument is provided, then \code{choiceNames} and \code{choiceValues} must not be provided,
#'  and vice-versa. The values should be strings; other types (such as logicals and
#'  numbers) will be coerced to strings.
#' @param selected The values that should be initially selected, if any.
#' @param status Add a class to the checkbox,
#' you can use Bootstrap status like 'info', 'primary', 'danger', 'warning' or 'success'.
#' @param shape Shape of the checkbox between \code{square}, \code{curve} and \code{round}.
#' @param outline Color also the border of the checkbox (\code{TRUE} or \code{FALSE}).
#' @param fill Fill the checkbox with color (\code{TRUE} or \code{FALSE}).
#' @param thick Make the content inside checkbox smaller (\code{TRUE} or \code{FALSE}).
#' @param animation Add an animation when checkbox is checked, a value between
#' \code{smooth}, \code{jelly}, \code{tada}, \code{rotate}, \code{pulse}.
#' @param icon Optional, display an icon on the checkbox, must be an icon created with \code{icon}.
#' @param plain Remove the border when checkbox is checked (\code{TRUE} or \code{FALSE}).
#' @param bigger Scale the checkboxes a bit bigger (\code{TRUE} or \code{FALSE}).
#' @param inline If \code{TRUE}, render the choices inline (i.e. horizontally).
#' @param width The width of the input, e.g. `400px`, or `100%`.
#' @param choiceNames List of names to display to the user.
#' @param choiceValues List of values corresponding to \code{choiceNames}
#'
#' @seealso \code{\link{updatePrettyCheckboxGroup}} for updating values server-side.
#'
#' @return A character vector or \code{NULL} server-side.
#' @export
#'
#' @importFrom htmltools validateCssUnit tags tagList
#' @importFrom shiny restoreInput
#'
#' @example examples/prettyCheckboxGroup.R
prettyCheckboxGroup <- function(inputId,
                                label,
                                choices = NULL,
                                selected = NULL,
                                status = "default",
                                shape = c("square", "curve", "round"),
                                outline = FALSE,
                                fill = FALSE,
                                thick = FALSE,
                                animation = NULL,
                                icon = NULL,
                                plain = FALSE,
                                bigger = FALSE,
                                inline = FALSE,
                                width = NULL,
                                choiceNames = NULL,
                                choiceValues = NULL) {
  status <- match.arg(status, c("default", "primary", "success",
                                "info", "danger", "warning"))
  shape <- match.arg(shape)
  if (is.null(choices) && is.null(choiceNames) && is.null(choiceValues)) {
    choices <- character(0)
  }
  args <- normalizeChoicesArgs(choices, choiceNames, choiceValues)
  selected <- shiny::restoreInput(id = inputId, default = selected)
  if (!is.null(selected))
    selected <- as.character(selected)
  options <- generatePretty(
    inputId = inputId,
    selected = selected,
    inline = inline,
    type = "checkbox",
    choiceNames = args$choiceNames,
    choiceValues = args$choiceValues,
    status = status,
    shape = shape,
    outline = outline,
    fill = fill,
    thick = thick,
    animation = animation,
    icon = icon,
    plain = plain,
    bigger = bigger
  )
  divClass <- "form-group shiny-input-checkboxgroup shiny-input-container"
  if (inline)
    divClass <- paste(divClass, "shiny-input-container-inline")
  checkgroupTag <- tags$div(
    id = inputId,
    style = if (!is.null(width)) paste0("width: ", validateCssUnit(width), ";"),
    class = divClass,
    tags$label(
      class = "control-label",
      `for` = inputId,
      class = if (is.null(label)) "shiny-label-null",
      label
    ),
    options
  )
  attachShinyWidgetsDep(checkgroupTag, "pretty")
}

generatePretty <- function(inputId,
                           selected,
                           inline,
                           type = "checkbox",
                           choiceNames,
                           choiceValues,
                           status = "primary",
                           shape = "square",
                           outline = FALSE,
                           fill = FALSE,
                           thick = FALSE,
                           animation = NULL,
                           icon = NULL,
                           plain = FALSE,
                           bigger = FALSE) {
  if(!is.null(icon)) {
    icon <- validateIcon(icon)
    icon$attribs$class <- paste("icon", icon$attribs$class)
  }
  options <- mapply(choiceValues, choiceNames, FUN = function(value,
                                                              name) {
    inputTag <- tags$input(type = type, name = inputId, value = value)
    if (value %in% selected)
      inputTag$attribs$checked <- "checked"
    if (inline) {
      # tags$label(class = paste0(type, "-inline"), inputTag)
      tags$div(
        class = "pretty", inputTag,
        # class = paste0(type, "-inline"),
        class = if(is.null(icon)) "p-default",
        class = if(plain) "p-plain",
        class = if(bigger) "p-bigger",
        class = if(shape!="square") paste0("p-", shape),
        class = if(fill) "p-fill", class=if(thick) "p-thick",
        class = if(!is.null(animation)) paste0("p-", animation),
        class = if(!is.null(icon)) "p-icon",
        tags$div(
          class = "state",
          class = if(status != "default") paste0("p-", status, if(outline)"-o"),
          if(!is.null(icon)) icon,
          tags$label(tags$span(name))
        )
      )
    }
    else {
      tagList(
        tags$div(
          class ="pretty", inputTag,
          # class = paste0(type, "-inline"),
          # style="display: block;",
          class = if(is.null(icon)) "p-default",
          class = if(plain) "p-plain",
          class = if(bigger) "p-bigger",
          class = if(shape!="square") paste0("p-", shape),
          class = if(fill) "p-fill", class=if(thick) "p-thick",
          class = if(!is.null(animation)) paste0("p-", animation),
          class = if(!is.null(icon)) "p-icon",
          tags$div(
            class = "state",
            class = if(status != "default") paste0("p-", status, if(outline)"-o"),
            if(!is.null(icon)) icon,
            tags$label(tags$span(name))
          )
        ),
        tags$div(style = "height:3px;")
      )
    }
  }, SIMPLIFY = FALSE, USE.NAMES = FALSE)
  tags$div(
    if (!inline) tags$div(style = "height:7px;"),
    class = "shiny-options-group", options
  )
}







#' Change the value of a pretty checkbox on the client
#'
#' @param session The \code{session} object passed to function given to shinyServer.
#' @param inputId The id of the input object.
#' @param label The label to set for the input object.
#' @param choices The choices to set for the input object, updating choices will reset
#' parameters like \code{status}, \code{shape}, ... on the checkboxes, you can re-specify
#' (or change them) in argument \code{prettyOptions}.
#' @param selected The value to set for the input object.
#' @param inline If \code{TRUE}, render the choices inline (i.e. horizontally).
#' @param choiceNames The choices names to set for the input object.
#' @param choiceValues The choices values to set for the input object.
#' @param prettyOptions Arguments passed to \code{\link{prettyCheckboxGroup}}
#'  for styling checkboxes. This can be needed if you update choices.
#'
#' @export
#'
#' @example examples/updatePrettyCheckboxGroup.R
updatePrettyCheckboxGroup <- function(session = getDefaultReactiveDomain(),
                                      inputId,
                                      label = NULL,
                                      choices = NULL,
                                      selected = NULL,
                                      inline = FALSE,
                                      choiceNames = NULL,
                                      choiceValues = NULL,
                                      prettyOptions = list()) {
  updatePrettyOptions(
    session, inputId, label, choices, selected,
    inline, "checkbox", choiceNames, choiceValues, prettyOptions
  )
}



updatePrettyOptions <- function(session = getDefaultReactiveDomain(),
                                inputId,
                                label = NULL,
                                choices = NULL,
                                selected = NULL,
                                inline = FALSE,
                                type = NULL,
                                choiceNames = NULL,
                                choiceValues = NULL,
                                prettyOptions = list()) {
  if (is.null(type))
    stop("Please specify the type ('checkbox' or 'radio')")
  args <- normalizeChoicesArgs(choices, choiceNames, choiceValues,
                                       mustExist = FALSE)
  if (!is.null(selected))
    selected <- as.character(selected)
  options <- if (!is.null(args$choiceValues)) {
    htmltools::doRenderTags(
      generatePretty(
        inputId = session$ns(inputId),
        selected = selected,
        inline = inline,
        type = type,
        choiceNames =  args$choiceNames,
        choiceValues = args$choiceValues,
        status = prettyOptions$status %||% "default",
        shape = prettyOptions$shape %||% "square",
        outline = prettyOptions$outline %||% FALSE,
        fill = prettyOptions$fill %||% FALSE,
        thick = prettyOptions$thick %||% FALSE,
        animation = prettyOptions$animation,
        icon = prettyOptions$icon,
        plain = prettyOptions$plain %||% FALSE,
        bigger = prettyOptions$bigger %||% FALSE
      )
    )
  }
  message <- dropNulls(list(label = label, options = options,
                                    value = selected))
  session$sendInputMessage(inputId, message)
}





#' @title Pretty radio Buttons Input Control
#'
#' @description Create a set of radio buttons used to select an item from a list.
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label Display label for the control.
#' @param choices List of values to show radio buttons for. If elements of the list
#'  are named then that name rather than the value is displayed to the user. If
#'  this argument is provided, then \code{choiceNames} and \code{choiceValues} must not be provided,
#'  and vice-versa. The values should be strings; other types (such as logicals and
#'  numbers) will be coerced to strings.
#' @param selected The values that should be initially selected,
#' (if not specified then defaults to the first value).
#' @param status Add a class to the radio,
#' you can use Bootstrap status like 'info', 'primary', 'danger', 'warning' or 'success'.
#' @param shape Shape of the radio between \code{square}, \code{curve} and \code{round}.
#' @param outline Color also the border of the radio (\code{TRUE} or \code{FALSE}).
#' @param fill Fill the radio with color (\code{TRUE} or \code{FALSE}).
#' @param thick Make the content inside radio smaller (\code{TRUE} or \code{FALSE}).
#' @param animation Add an animation when radio is checked, a value between
#' \code{smooth}, \code{jelly}, \code{tada}, \code{rotate}, \code{pulse}.
#' @param icon Optional, display an icon on the radio, must be an icon created with \code{icon}.
#' @param plain Remove the border when radio is checked (\code{TRUE} or \code{FALSE}).
#' @param bigger Scale the radio a bit bigger (\code{TRUE} or \code{FALSE}).
#' @param inline If \code{TRUE}, render the choices inline (i.e. horizontally).
#' @param width The width of the input, e.g. `400px`, or `100%`.
#' @param choiceNames List of names to display to the user.
#' @param choiceValues List of values corresponding to \code{choiceNames}
#'
#' @return A character vector or \code{NULL} server-side.
#' @export
#'
#' @importFrom htmltools validateCssUnit tags tagList
#' @importFrom shiny restoreInput
#'
#' @example examples/prettyRadioButtons.R
prettyRadioButtons <- function(inputId,
                               label,
                               choices = NULL,
                               selected = NULL,
                               status = "primary",
                               shape = c("round", "square", "curve"),
                               outline = FALSE,
                               fill = FALSE,
                               thick = FALSE,
                               animation = NULL,
                               icon = NULL,
                               plain = FALSE,
                               bigger = FALSE,
                               inline = FALSE,
                               width = NULL,
                               choiceNames = NULL,
                               choiceValues = NULL) {
  status <- match.arg(status, c("default", "primary", "success",
                                "info", "danger", "warning"))
  shape <- match.arg(shape)
  if (is.null(choices) && is.null(choiceNames) && is.null(choiceValues)) {
    choices <- character(0)
  }
  args <- normalizeChoicesArgs(choices, choiceNames, choiceValues)
  selected <- shiny::restoreInput(id = inputId, default = selected)
  selected <- if (is.null(selected)) {
    args$choiceValues[[1]]
  } else {
    as.character(selected)
  }
  if (length(selected) > 1)
    stop("The 'selected' argument must be of length 1")
  options <- generatePretty(
    inputId = inputId,
    selected = selected,
    inline = inline,
    type = "radio",
    choiceNames = args$choiceNames,
    choiceValues = args$choiceValues,
    status = status,
    shape = shape,
    outline = outline,
    fill = fill,
    thick = thick,
    animation = animation,
    icon = icon,
    plain = plain,
    bigger = bigger
  )
  divClass <- "form-group shiny-input-radiogroup shiny-input-container"
  if (inline)
    divClass <- paste(divClass, "shiny-input-container-inline")
  radioTag <- htmltools::tags$div(
    id = inputId,
    style = if (!is.null(width)) paste0("width: ", validateCssUnit(width), ";"),
    class = divClass,
    tags$label(
      class = "control-label",
      `for` = inputId,
      class = if (is.null(label)) "shiny-label-null",
      label
    ),
    options
  )
  attachShinyWidgetsDep(radioTag, "pretty")
}



#' Change the value pretty radio buttons on the client
#'
#' @param session The \code{session} object passed to function given to shinyServer.
#' @param inputId The id of the input object.
#' @param label The label to set for the input object.
#' @param choices The choices to set for the input object, updating choices will reset
#' parameters like \code{status}, \code{shape}, ... on the radio buttons, you can re-specify
#' (or change them) in argument \code{prettyOptions}.
#' @param selected The value to set for the input object.
#' @param inline If \code{TRUE}, render the choices inline (i.e. horizontally).
#' @param choiceNames The choices names to set for the input object.
#' @param choiceValues The choices values to set for the input object.
#' @param prettyOptions Arguments passed to \code{\link{prettyRadioButtons}}
#'  for styling radio buttons. This can be needed if you update choices.
#'
#' @export
#'
#' @example examples/updatePrettyRadioButtons.R
updatePrettyRadioButtons <- function(session = getDefaultReactiveDomain(),
                                     inputId,
                                     label = NULL,
                                     choices = NULL,
                                     selected = NULL,
                                     inline = FALSE,
                                     choiceNames = NULL,
                                     choiceValues = NULL,
                                     prettyOptions = list()) {
  if (is.null(selected)) {
    if (!is.null(choices))
      selected <- choices[[1]]
    else if (!is.null(choiceValues))
      selected <- choiceValues[[1]]
  }
  if (is.list(prettyOptions) && is.null(prettyOptions$shape))
    prettyOptions$shape <- "round"
  if (is.list(prettyOptions) && is.null(prettyOptions$status))
    prettyOptions$status <- "primary"
  updatePrettyOptions(
    session, inputId, label, choices, selected,
    inline, "radio", choiceNames, choiceValues, prettyOptions
  )
}

