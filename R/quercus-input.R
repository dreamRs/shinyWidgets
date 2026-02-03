
#' @importFrom htmltools htmlDependency
html_dependency_quercus <- function() {
  htmlDependency(
    name = "quercus.js",
    version = "0.4.1",
    src = c(file = system.file("packer", package = "shinyWidgets")),
    script = "quercus.js"
  )
}


#' @title Quercus Input Widget
#'
#' @description A Lightweight and Customizable JavaScript Treeview Library with absolutely no dependencies.
#'  See original widget [quercus.js](https://github.com/stefaneichert/quercus.js).
#'
#' @param inputId The `input` slot that will be used to access the value.
#' @param label Display label for the control, or `NULL` for no label.
#' @param choices A `list` of `list` in a tree structure, see [create_tree()] for examples creating the right structure.
#' @param selected Inital selected values, note that you have to use node ID.
#' @param ... Arguments passed to Quercus.js's Treeview JavaScript method,
#'  see [online documentation](https://github.com/stefaneichert/quercus.js?tab=readme-ov-file#treeview-options) for available methods or examples.
#' @param nodeNameKey The key to retrieve label to use in `choices`. If [create_tree()] is used in `choices`, `nodeNameKey` must be set to `"text"`.
#' @param returnValue Value returned server-side, default to `"text"` the node text,
#'  other possibilities are `"id"` (if no ID provided in `choices = `, one is generated) or
#'  `"all"` to returned all the tree under the element selected.
#' @param unsetMaxWidth Default behavior in `quercus.js` is to set max-width to `600px`, this allow to disable this rule.
#' @param width The width of the input, e.g. `400px`, or `"100%`.
#'
#' @return A `shiny.tag` object that can be used in a UI definition.
#' @export
#'
#' @seealso [updateQuercusInput()] for updating from server.
#'
#' @example examples/quercus-default.R
quercusInput <- function(inputId,
                         label,
                         choices,
                         selected = NULL,
                         ...,
                         nodeNameKey = "text",
                         returnValue = c("text", "id", "all"),
                         unsetMaxWidth = TRUE,
                         width = NULL) {
  selected <- shiny::restoreInput(inputId, selected)
  returnValue <- match.arg(returnValue)
  if (!is.null(selected))
    selected <- as.character(selected)
  config <- dropNulls(list(
    containerId = inputId,
    data = toJSON(choices, auto_unbox = TRUE, json_verbatim = TRUE),
    nodeNameKey = nodeNameKey,
    ...,
    selected = list1(selected)
  ))
  config <- toJSON(config, auto_unbox = TRUE, json_verbatim = TRUE)
  tags$div(
    class = "form-group shiny-input-container",
    style = css(width = validateCssUnit(width)),
    label_input(inputId, label),
    tags$div(
      id = inputId,
      class = "quercus-widget",
      `data-return` = returnValue,
      tags$script(
        type = "application/json",
        `data-for` = inputId,
        HTML(config)
      )
    ),
    html_dependency_quercus(),
    if (isTRUE(unsetMaxWidth))
      tags$style(sprintf("#%s.custom-treeview-wrapper { max-width: unset; }", inputId)),
  )
}



#' @title Update Tree Input
#'
#' @description Update [treeInput()] from server.
#'
#' @inheritParams quercusInput
#' @inheritParams shiny::updateCheckboxGroupInput
#'
#' @return No value.
#' @export
#'
#'
#' @example examples/quercus-update.R
updateQuercusInput <- function(inputId,
                               label = NULL,
                               choices = NULL,
                               selected = NULL,
                               session = shiny::getDefaultReactiveDomain()) {
  if (!is.null(label))
    label <- doRenderTags(label)
  if (is.null(selected))
    selected <- character(0)
  message <- dropNulls(list(
    label = label,
    selected = list1(selected)
  ))
  if (!is.null(choices)) {
    message$data <- toJSON(choices, auto_unbox = TRUE, json_verbatim = TRUE)
  }
  session$sendInputMessage(inputId, message)
}


