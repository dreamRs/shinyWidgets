
#' @title Drop Menu
#'
#' @description A pop-up menu to hide inputs and other elements into.
#'
#' @param tag An HTML tag to which attach the menu.
#' @param ... UI elements to be displayed in the menu.
#' @param padding Amount of padding to apply. Can be numeric (in pixels) or character (e.g. "3em").
#' @param placement Positions of the menu relative to its reference element (\code{tag}).
#' @param trigger The event(s) which cause the menu to show.
#' @param arrow Determines if the menu has an arrow.
#' @param theme CSS theme to use.
#' @param hideOnClick Determines if the menu should hide if a mousedown event was fired
#'  outside of it (i.e. clicking on the reference element or the body of the page).
#' @param maxWidth Determines the maximum width of the menu.
#' @param options Additional options, see \code{\link{dropMenuOptions}}.
#'
#' @seealso \link[=drop-menu-interaction]{dropMenu interaction} for functions
#'  and examples to interact with \code{dropMenu} from server.
#'
#' @return A UI definition.
#' @export
#'
#' @importFrom htmltools tags validateCssUnit HTML as.tags
#' @importFrom jsonlite toJSON
#' @importFrom utils modifyList
#'
#' @example examples/ex-drop-menu.R
dropMenu <- function(tag, ...,
                     padding = "5px",
                     placement = c("bottom",
                                   "bottom-start",
                                   "bottom-end",
                                   "top",
                                   "top-start",
                                   "top-end",
                                   "right",
                                   "right-start",
                                   "right-end",
                                   "left",
                                   "left-start",
                                   "left-end"),
                     trigger = "click",
                     arrow = TRUE,
                     theme = c("light", "light-border", "material", "translucent"),
                     hideOnClick = TRUE,
                     maxWidth = "none",
                     options = NULL) {


  theme <- match.arg(theme)
  placement <- match.arg(placement)
  trigger <- match.arg(
    arg = trigger,
    several.ok = TRUE,
    choices = c("click", "mouseenter", "manual", "focus")
  )
  trigger <- paste(trigger, collapse = " ")
  if (!inherits(tag, c("shiny.tag", "shiny.tag.function"))) {
    stop("dropMenu: 'tag' must be a 'shiny.tag' or 'shiny.tag.function' object.")
  }
  tag_ <- as.tags(tag)
  if (is.null(tag_$attribs$id)) {
    stop("dropMenu: 'tag' must have an Id.")
  }
  ID <- tag_$attribs$id

  config <- list(
    options = list(
      arrow = arrow,
      theme = theme,
      trigger = trigger,
      placement = placement,
      maxWidth = maxWidth,
      hideOnClick = hideOnClick,
      flip = FALSE
    )
  )
  if (!is.null(options)) {
    config$options <- modifyList(
      x = config$options,
      val = options,
      keep.null = FALSE
    )
  }

  dropTag <- tags$div(
    class = "drop-menu-input",
    id = paste0(ID, "_dropmenu"),
    `data-target` = ID,
    `data-template` = paste0(ID, "-template"),
    tag,
    tags$div(
      style = "display: none;",
      style = sprintf("padding: %s;", validateCssUnit(padding)),
      id = paste0(ID, "-template"),
      ...
    ),
    tags$script(
      type = "application/json",
      `data-for` = paste0(ID, "_dropmenu"),
      HTML(toJSON(config, auto_unbox = TRUE, json_verbatim = TRUE))
    )
  )
  htmltools::attachDependencies(
    x = attachShinyWidgetsDep(dropTag),
    value = list(
      html_dependencies_popper(),
      html_dependencies_tippy()
    ),
    append = TRUE
  )
}




#' @title Drop menu options
#'
#' @description Those options will passed to the underlying JavaScript
#'  library powering \code{dropMenu} : tippy.js. See all available options
#'  here \url{https://atomiks.github.io/tippyjs/all-props/}.
#'
#' @param duration Duration of the CSS transition animation in ms.
#' @param animation The type of transition animation.
#' @param flip Determines if the tippy flips so that it is placed within
#'  the viewport as best it can be if there is not enough space.
#' @param ... Additional arguments.
#'
#' @return a \code{list} of options to be used in \code{\link{dropMenu}}.
#' @export
#'
dropMenuOptions <- function(duration = c(275, 250), animation = "fade", flip = FALSE, ...) {
  list(
    duration = duration,
    animation = animation,
    flip = flip,
    ...
  )
}



#' Interact with Drop Menu
#'
#' @param id Drop menu ID, the \code{tag}'s ID followed by \code{"_dropmenu"}.
#' @param session Shiny session.
#'
#' @export
#'
#' @name drop-menu-interaction
#'
#' @example examples/ex-drop-menu-interaction.R
enableDropMenu <- function(id, session = shiny::getDefaultReactiveDomain()) {
  if (!grepl(pattern = "_dropmenu$", x = id))
    warning("enableDropMenu: 'id' should be suffixed by '_dropmenu'.")
  session$sendInputMessage(id, list(
    action = "enable"
  ))
}

#' @export
#'
#' @rdname drop-menu-interaction
disableDropMenu <- function(id, session = shiny::getDefaultReactiveDomain()) {
  if (!grepl(pattern = "_dropmenu$", x = id))
    warning("disableDropMenu: 'id' should be suffixed by '_dropmenu'.")
  session$sendInputMessage(id, list(
    action = "disable"
  ))
}

#' @export
#'
#' @rdname drop-menu-interaction
showDropMenu <- function(id, session = shiny::getDefaultReactiveDomain()) {
  if (!grepl(pattern = "_dropmenu$", x = id))
    warning("showDropMenu: 'id' should be suffixed by '_dropmenu'.")
  session$sendInputMessage(id, list(
    action = "show"
  ))
}

#' @export
#'
#' @rdname drop-menu-interaction
hideDropMenu <- function(id, session = shiny::getDefaultReactiveDomain()) {
  if (!grepl(pattern = "_dropmenu$", x = id))
    warning("hideDropMenu: 'id' should be suffixed by '_dropmenu'.")
  session$sendInputMessage(id, list(
    action = "hide"
  ))
}




#' @importFrom htmltools htmlDependency
html_dependencies_popper <- function() {
  htmlDependency(
    name = "popper",
    version = "1.16.0",
    src = list(href = "shinyWidgets", file = "assets"),
    package = "shinyWidgets",
    script = "popper/popper.min.js",
    all_files = FALSE
  )
}

# # Combine all CSS animations files together
# jstools::crass_file(
#   input = list.files(path = "inst/assets/tippy/animations/", full.names = TRUE),
#   output = "inst/assets/tippy/dist/animations.min.css"
# )

# # Combine all CSS themes files together
# jstools::crass_file(
#   input = list.files(path = "inst/assets/tippy/themes/", full.names = TRUE),
#   output = "inst/assets/tippy/dist/themes.min.css"
# )


#' @importFrom htmltools htmlDependency
html_dependencies_tippy <- function() {
  htmlDependency(
    name = "tippy",
    version = "5.1.2",
    src = list(href = "shinyWidgets/tippy", file = "assets/tippy"),
    package = "shinyWidgets",
    script = c(
      "dist/tippy-bundle.iife.min.js"
    ),
    stylesheet = c(
      "dist/themes.min.css",
      "dist/animations.min.css"
    ),
    all_files = FALSE
  )
}




