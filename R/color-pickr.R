
#' @title Color Pickr
#'
#' @description A widget to pick color with different themes and options.
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label Display label for the color pickr, or \code{NULL} for no label.
#' @param selected Default selected value.
#' @param swatches Optional color swatches. When \code{NULL}, swatches are disabled.
#' @param preview Display comparison between previous state and new color.
#' @param hue Display hue slider.
#' @param opacity Display opacity slider.
#' @param interaction List of parameters to show or hide components on the
#'  bottom interaction bar. See link below for documentation.
#' @param theme Which theme you want to use. Can be 'classic', 'monolith' or 'nano'.
#' @param update When to update value server-side.
#' @param position Defines the position of the color-picker.
#' @param hideOnSave Hide color-picker after selecting a color.
#' @param useAsButton Show color-picker in a button instead of an input with value displayed.
#' @param inline Always show color-picker in page as a full element.
#' @param i18n List of translations for labels, see online documentation.
#' @param pickr_width Color-picker width (correspond to popup window).
#' @param width Color-picker width (correspond to input).
#'
#' @note Widget based on JS library pickr by \href{https://github.com/Simonwep}{Simonwep}.
#'  See online documentation for more information: \url{https://github.com/Simonwep/pickr}.
#'
#' @return a color picker input widget that can be added to the UI of a shiny app.
#' @export
#'
#'
#' @importFrom htmltools tags
#' @importFrom utils modifyList
#' @importFrom jsonlite toJSON
#'
#' @example examples/pickr-color.R
colorPickr <- function(inputId,
                       label,
                       selected = "#112446",
                       swatches = NULL,
                       preview = TRUE,
                       hue = TRUE,
                       opacity = FALSE,
                       interaction = NULL,
                       theme = c("classic", "monolith", "nano"),
                       update = c("save", "changestop", "change", "swatchselect"),
                       position = "bottom-middle",
                       hideOnSave = TRUE,
                       useAsButton = FALSE,
                       inline = FALSE,
                       i18n = NULL,
                       pickr_width = NULL,
                       width = NULL) {
  
  selected <- restoreInput(id = inputId, default = selected)
  theme <- match.arg(theme)
  update <- match.arg(update)

  if (is.null(interaction)) {
    interaction <- list(
      cancel = FALSE,
      clear = TRUE,
      save = TRUE,
      hex = TRUE,
      rgba = TRUE,
      input = TRUE
    )
  } else if (is.list(interaction)) {
    interaction <- modifyList(
      x = list(
        cancel = FALSE,
        clear = TRUE,
        save = TRUE,
        hex = TRUE,
        rgba = TRUE,
        input = TRUE
      ),
      val = interaction
    )
  }

  if (isTRUE(inline)) {
    hideOnSave <- FALSE
    useAsButton <- TRUE
    pickr_width <- width %||% pickr_width
  }

  if (!is.null(pickr_width)) {
    pickr_width <- validateCssUnit(pickr_width)
  }

  config <- dropNulls(list(
    update = update,
    hideOnSave = isTRUE(hideOnSave),
    width = pickr_width,
    inline = isTRUE(inline),
    options = dropNulls(list(
      useAsButton = !isTRUE(useAsButton),
      theme = theme,
      default = selected,
      swatches = swatches,
      inline = inline,
      showAlways = inline,
      position = position,
      components = dropNulls(list(
        preview = preview,
        opacity = opacity,
        hue = hue,
        interaction = interaction
      )),
      i18n = i18n
    ))
  ))

  tags$div(
    class = "form-group shiny-input-container",
    style = if (!is.null(width)) paste0("width: ", validateCssUnit(width), ";"),
    tags$label(
      class = "control-label",
      `for` = inputId, label,
      class = if (is.null(label)) "shiny-label-null",
      style = if (isTRUE(useAsButton)) "vertical-align: bottom;"
    ),
    tags$div(
      id = inputId,
      class = "pickr-color-container",
      tags$input(
        type = "text",
        class = "form-control pickr-color",
        readonly = "readonly"
      ),
      tags$script(
        type = "application/json",
        `data-for` = inputId,
        toJSON(config, auto_unbox = TRUE, json_verbatim = TRUE)
      )
    ),
    html_dependency_pickr(),
    html_dependency_shinyWidgets()
  )
}





#' Update color pickr server-side
#'
#' @param session The session object passed to function given to shinyServer.
#' @param inputId	The id of the input object.
#' @param value The value to set for the input object.
#' @param action Action to performon color-picker: enable, disable, show or hide.
#'
#' @return No return value.
#' @export
#'
#' @rdname colorPickr
updateColorPickr <- function(session = getDefaultReactiveDomain(), inputId, value = NULL, action = NULL) {
  if (!is.null(action)) {
    action <- match.arg(action, c("disable", "enable", "hide", "show"))
  }
  message <- dropNulls(list(value = value, action = action))
  session$sendInputMessage(inputId, message)
}


