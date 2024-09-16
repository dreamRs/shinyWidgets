
#' @importFrom htmltools htmlDependency
html_dependency_slimselect <- function() {
  htmlDependency(
    name = "slim-select",
    version = "2.8.2",
    src = c(file = system.file("packer", package = "shinyWidgets")),
    script = "slim-select.js",
    all_files = FALSE
  )
}


#' Prepare choices for [slimSelectInput()]
#'
#' @param .data An object of type [data.frame()].
#' @param label Variable to use as labels (displayed to user).
#' @param value Variable to use as values (retrieved server-side).
#' @param html Alternative HTML to be displayed instaed of label.
#' @param selected Is the option must be selected ?
#' @param display Allows to hide elements of selected values.
#' @param disabled Allows the ability to disable the select dropdown as well as individual options.
#' @param mandatory When using multi select you can set a mandatory on the option to prevent capability
#'  to deselect particular option. Note options with mandatory flag is not selected by default, you need select them yourselfs.
#' @param class Add CSS classes.
#' @param style Add custom styles to options.
#' @param .by Variable identifying groups to use option group feature.
#' @param selectAll Enable select all feature for options groups.
#' @param closable Allow to close options groups, one of: 'off', 'open', 'close'.
#'
#' @return A `list` to use as `choices` argument of [slimSelectInput()].
#' @export
#'
#' @example examples/prepare_slim_choices.R
prepare_slim_choices <- function(.data,
                                 label,
                                 value,
                                 html = NULL,
                                 selected = NULL,
                                 display = NULL,
                                 disabled = NULL,
                                 mandatory = NULL,
                                 class = NULL,
                                 style = NULL,
                                 .by = NULL,
                                 selectAll = NULL,
                                 closable = NULL) {
  args <- lapply(
    X = enexprs(
      text = label,
      value = value,
      html = html,
      selected = selected,
      display = display,
      disabled = disabled,
      mandatory = mandatory,
      class = class,
      style = style,
      .by = .by,
      selectAll = selectAll,
      closable = closable
    ),
    FUN = eval_tidy,
    data = as.data.frame(.data)
  )
  args <- dropNulls(args)
  if (!is.null(args$selectAll))
    args$selectAll <- rep_len(args$selectAll, length.out = nrow(.data))
  if (!is.null(args$closable))
    args$closable <- rep_len(args$closable, length.out = nrow(.data))
  if (!is_null(args$.by)) {
    groups <- args$.by
    args$.by <- NULL
    args <- lapply(
      X = unique(groups),
      FUN = function(group) {
        selectAll <- args$selectAll[groups == group][1]
        args$selectAll <- NULL
        closable <- args$closable[groups == group][1]
        args$closable <- NULL
        options <- lapply(args, `[`, groups == group)
        dropNulls(list(
          label = group,
          selectAll = selectAll,
          closable = closable,
          options = lapply(
            X = seq_along(options[[1]]),
            FUN = function(i) {
              lapply(options, `[`, i)
            }
          )
        ))
      }
    )
  } else {
    args$selectAll <- NULL
    args$closable <- NULL
    args <- lapply(
      X = seq_along(args[[1]]),
      FUN = function(i) {
        lapply(args, `[`, i)
      }
    )
  }
  I(args)
}


#' @title Slim Select Input
#'
#' @description An advanced select dropdown,
#'  based on [slim-select](https://github.com/brianvoe/slim-select) JavaScript library.
#'
#' @param choices List of values to select from.
#' You can use:
#'  * `vector` a simple vector.
#'  * `named list` / `named vector` in the same way as with [shiny::selectInput()]
#'  * cuxtom choices prepared with [prepare_slim_choices()].
#' @inheritParams shiny::selectInput
#' @param search Enable search feature.
#' @param placeholder Placeholder text.
#' @param allowDeselect This will allow you to deselect a value on a single/multiple select dropdown.
#' @param closeOnSelect A boolean value in which determines whether or not to close the content area upon selecting a value.
#' @param keepOrder If `TRUE` will maintain the order in which options are selected.
#' @param alwaysOpen If `TRUE` keep the select open at all times.
#' @param contentPosition Will set the css position to either relative or absolute.
#' @param ... Other settings passed to Slim Select JAvaScript method.
#' @param inline Display the widget inline.
#'
#' @return A `shiny.tag` object that can be used in a UI definition.
#' @export
#'
#' @example inst/examples/slim-select/basic/app.R
slimSelectInput <- function(inputId,
                            label,
                            choices,
                            selected = NULL,
                            multiple = FALSE,
                            search = TRUE,
                            placeholder = NULL,
                            allowDeselect = NULL,
                            closeOnSelect = !multiple,
                            keepOrder = NULL,
                            alwaysOpen = NULL,
                            contentPosition = NULL,
                            ...,
                            inline = FALSE,
                            width = NULL) {
  selected <- restoreInput(id = inputId, default = selected)
  data <- dropNulls(list(
    data = if (inherits(choices, "AsIs")) {
      if (!isTRUE(multiple) & isTRUE(allowDeselect)) {
        c(list(list(placeholder = TRUE, text = placeholder, value = NULL)), list(as.list(choices)))
      } else {
        as.list(choices)
      }
    } else {
      if (!isTRUE(multiple) & isTRUE(allowDeselect)) {
        c(list(list(placeholder = TRUE, text = placeholder, value = NULL)), make_slim_data(choicesWithNames(choices)))
      } else {
        make_slim_data(choicesWithNames(choices))
      }
    },
    selected = selected,
    settings = dropNulls(list(
      showSearch = search,
      placeholderText = placeholder,
      allowDeselect = allowDeselect,
      closeOnSelect = closeOnSelect,
      keepOrder = keepOrder,
      alwaysOpen = alwaysOpen,
      contentPosition = contentPosition,
      ...
    ))
  ))
  tag_select <- tags$select(
    id = inputId,
    class = "slim-select",
    tags$script(
      type = "application/json",
      `data-for` = inputId,
      toJSON(data, auto_unbox = TRUE, json_verbatim = TRUE)
    )
  )
  if (multiple)
    tag_select$attribs$multiple <- "multiple"
  tags$div(
    class = "form-group shiny-input-container",
    class = if (isTRUE(inline)) "shiny-input-container-inline",
    style = css(width = validateCssUnit(width), height = "auto"),
    label_input(inputId, label),
    tag_select,
    tags$div(id = paste0(inputId, "-placeholder"), style = css(height = "auto")),
    html_dependency_slimselect()
  )
}


make_slim_data <- function(choices) {
  lapply(
    X = seq_along(choices),
    FUN = function(i) {
      label <- names(choices)[i]
      choice <- choices[[i]]
      if (is.list(choice)) {
        list(
          label = label,
          options = make_slim_data(choice)
        )
      } else {
        list(text = label, value = choice)
      }
    }
  )
}



#' @title Update slim select from server
#'
#' @description
#' Update a [slimSelectInput()] from the server.
#'
#'
#' @inheritParams slimSelectInput
#' @inheritParams shiny::updateSelectInput
#' @param disable Disable (`TRUE`) or enable (`FALSE`) the select menu.
#' @param open Open (`TRUE`) or close (`FALSE`) the dropdown.
#'
#' @return No value.
#'
#' @seealso [slimSelectInput()] for creating a widget in the UI.
#'
#' @export
#'
#' @importFrom shiny getDefaultReactiveDomain
#' @importFrom htmltools doRenderTags
#'
#' @example inst/examples/slim-select/update/app.R
updateSlimSelect <- function(inputId,
                             label = NULL,
                             choices = NULL,
                             selected = NULL,
                             disable = NULL,
                             open = NULL,
                             session = shiny::getDefaultReactiveDomain()) {
  if (!is.null(label))
    label <- doRenderTags(label)
  data <- if (!is.null(choices)) {
    if (inherits(choices, "AsIs")) {
      as.list(choices)
    } else {
      make_slim_data(choicesWithNames(choices))
    }
  }
  message <- dropNulls(list(
    label = label,
    data = data,
    selected = selected,
    disable = disable,
    open = open
  ))
  session$sendInputMessage(inputId, message)
}
