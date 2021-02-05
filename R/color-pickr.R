
#' @title Color Pickr
#'
#' @description A widget to pick color with different themes and options.
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label Display label for the color pickr, or \code{NULL} for no label.
#' @param selected Default selected value.
#' @param swatchesOptional color swatches. When \code{NULL}, swatches are disabled.
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
#' @param pickr_width Color-picker width (correspond to popup window).
#' @param width Color-picker width (correspond to input).
#'
#' @note Widget based on JS library pickr by \href{https://github.com/Simonwep}{Simonwep}.
#'  See online documentation for more information: \url{https://github.com/Simonwep/pickr}.
#'
#' @return a color picker input widget that can be added to the UI of a shiny app.
#' @export
#'
#' @example examples/ex-color-pickr.R
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
                       pickr_width = NULL,
                       width = NULL) {

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
      ))
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
    tags$input(
      id = inputId,
      type = "text",
      class = "form-control pickr-color",
      readonly = "readonly"
    ),
    tags$script(
      type = "application/json",
      `data-for` = inputId,
      toJSON(config, auto_unbox = TRUE, json_verbatim = TRUE)
    ),
    html_dependency_pickr()
  )
}


#' @importFrom htmltools htmlDependency
html_dependency_pickr <- function() {
  htmlDependency(
    name = "pickr",
    version = "1.8.0",
    src = list(href = "shinyWidgets/pickr", file = "assets/pickr"),
    package = "shinyWidgets",
    script = c("js/pickr.min.js", "pickr-bindings.js"),
    stylesheet = c(
      "css/classic.min.css",
      "css/monolith.min.css",
      "css/nano.min.css"
    ),
    all_files = FALSE
  )
}


