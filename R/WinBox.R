
#' @title Winbox JavaScript Dependencies
#'
#' @description Include dependencies, place anywhere in the shiny UI.
#'
#' @param css_rules CSS rules to be included in a `style` tag in the document head.
#'  By default it set a `min-height` to the body element.
#'
#' @importFrom htmltools htmlDependency doRenderTags tags
#' @importFrom utils packageVersion
#'
#' @export
#'
#' @example inst/examples/WinBox/basic.R
html_dependency_winbox <- function(css_rules = "body{min-height:100vh}.winbox.modal{display:block;overflow:unset}") {
  if (!is.null(css_rules)) {
    styles <- doRenderTags(tags$style(css_rules))
  } else {
    styles <- NULL
  }
  htmlDependency(
    name = "winbox",
    version = "0.2.82",
    src = list(file = "packer"),
    all_files = FALSE,
    package = "shinyWidgets",
    script = "WinBox.js",
    head = styles
  )
}



#' @title WinBox
#'
#' @description A window manager with JavaScript library [WinBox.js](https://nextapps-de.github.io/winbox/).
#'
#' @param title Title for the window.
#' @param ui Content of the window.
#' @param options List of options, see [wbOptions()].
#' @param controls List of controls, see [wbControls()].
#' @param id An unique identifier for the window, if a window with the same `id` is already open,
#'  it will be closed before opening the new one. When closing windows, use `id = NULL` to close last one opened.
#' @param padding Padding for the window content.
#' @param auto_height Automatically set height of the window according to content.
#'  Note that if content does not have a fix height it may not work properly.
#' @param session Shiny session.
#'
#' @return No value, a window is openned in the UI.
#'
#' @note You need to include [html_dependency_winbox()] in your UI definition for this function to work.
#'
#' @name WinBox
#' @export
#'
#' @importFrom shiny getDefaultReactiveDomain
#' @importFrom htmltools tags css
#'
#' @example inst/examples/WinBox/default.R
WinBox <- function(title,
                   ui,
                   options = wbOptions(),
                   controls = wbControls(),
                   id = NULL,
                   padding = "5px 10px",
                   auto_height = FALSE,
                   session = shiny::getDefaultReactiveDomain()) {
  if (!is.null(padding))
    ui <- tags$div(ui, style = css(padding = padding))
  res <- utils::getFromNamespace("processDeps", "shiny")(ui, session)
  if (is.null(id))
    id <- paste0("winbox-", genId())
  options$id <- id
  options$title <- as.character(title)
  options$class <- controls
  session$sendCustomMessage("WinBox-show", list(
    html = res$html,
    deps = res$deps,
    options = options,
    auto_height = isTRUE(auto_height)
  ))
}

#' @rdname WinBox
#' @export
closeWinBox <- function(id, session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage("WinBox-close", dropNulls(list(id = id)))
}



#' WinBox Options
#'
#' @param width,height Set the initial width/height of the window (supports units "px" and "%").
#' @param minwidth,minheight Set the minimal width/height of the window (supports units "px" and "%").
#' @param x,y Set the initial position of the window (supports: "right" for x-axis, "bottom" for y-axis,
#'  "center" for both, units "px" and "%" for both).
#' @param max,min Automatically toggles the window into maximized / minimized state when created.
#' @param top,right,bottom,left Set or limit the viewport of the window's available area (supports units "px" and "%").
#' @param background Set the background of the window (supports all CSS styles which are also supported by the style-attribute "background",
#'  e.g. colors, transparent colors, hsl, gradients, background images).
#' @param border Set the border width of the window (supports all css units, like px, %, em, rem, vh, vmax).
#' @param modal Shows the window as modal.
#' @param index Set the initial z-index of the window to this value (could be increased automatically when unfocused/focused).
#' @param ... Other options, see https://github.com/nextapps-de/winbox?tab=readme-ov-file#options.
#'
#' @return A `list` of options to use in [WinBox()].
#' @export
#'
#' @example inst/examples/WinBox/options.R
wbOptions <- function(width = NULL,
                      height = NULL,
                      minwidth = NULL,
                      minheight = NULL,
                      x = NULL,
                      y = NULL,
                      max = NULL,
                      min = NULL,
                      top = NULL,
                      right = NULL,
                      bottom = NULL,
                      left = NULL,
                      background = NULL,
                      border = NULL,
                      modal = NULL,
                      index = 1045,
                      ...) {
  dropNulls(list(
    width = width,
    height = height,
    minwidth = minwidth,
    minheight = minheight,
    x = x,
    y = y,
    max = max,
    min = min,
    top = top,
    right = right,
    bottom = bottom,
    left = left,
    background = background,
    border = border,
    modal = modal,
    index = index,
    ...
  ))
}


#' WinBox controls
#'
#' @param animation If `FALSE`, disables the windows transition animation.
#' @param shadow If `FALSE`, disables the windows drop shadow.
#' @param header If `FALSE`, hide the window header incl. title and toolbar.
#' @param min If `FALSE`, hide the minimize icon.
#' @param max If `FALSE`, hide the maximize icon.
#' @param full If `FALSE`, hide the fullscreen icon.
#' @param close If `FALSE`, hide the close icon.
#' @param resize If `FALSE`, disables the window resizing capability.
#' @param move If `FALSE`, disables the window moving capability.
#'
#' @return A `list` of controls to use in [WinBox()].
#' @export
#'
#' @example inst/examples/WinBox/controls.R
wbControls <- function(animation = TRUE,
                       shadow = TRUE,
                       header = TRUE,
                       min = TRUE,
                       max = TRUE,
                       full = FALSE,
                       close = TRUE,
                       resize = TRUE,
                       move = TRUE) {
  classes <- c(
    animation = animation,
    shadow = shadow,
    header = header,
    min = min,
    max = max,
    full = full,
    close = close,
    resize = resize,
    move = move
  )
  classes <- paste0("no-", names(classes)[!unname(classes)])
  list1(classes)
}
