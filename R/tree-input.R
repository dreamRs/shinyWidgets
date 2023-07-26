
#' @importFrom htmltools htmlDependency
html_dependency_tree <- function() {
  htmlDependency(
    name = "treejs",
    version = "1.8.3",
    src = c(file = system.file("packer", package = "shinyWidgets")),
    script = "tree.js"
  )
}


#' @title Tree Input Widget
#'
#' @description A tree input widget allowing to select values in a hierarchical structure.
#'
#' @param inputId The `input` slot that will be used to access the value.
#' @param label Display label for the control, or `NULL` for no label.
#' @param choices A `list` of `list` in a tree structure, see [create_tree()] for examples creating the right structure.
#' @param selected Inital selected values, note that you have to use node ID.
#' @param closeDepth Expand level, default to only first one visible.
#' @param returnValue Value returned server-side, default to `"text"` the node text,
#'  other possibilities are `"id"` (if no ID provided in `choices = `, one is generated) or
#'  `"all"` to returned all the tree under the element selected.
#' @param width The width of the input, e.g. `400px`, or `"100%`.
#'
#' @return A `shiny.tag` object that can be used in a UI definition.
#' @export
#'
#' @seealso [updateTreeInput()] for updating from server.
#'
#' @example examples/tree-default.R
treeInput <- function(inputId,
                      label,
                      choices,
                      selected = NULL,
                      closeDepth = 1,
                      returnValue = c("text", "id", "all"),
                      width = NULL) {
  selected <- shiny::restoreInput(inputId, selected)
  returnValue <- match.arg(returnValue)
  if (!is.null(selected))
    selected <- as.character(selected)
  config <- dropNulls(list(
    data = toJSON(choices, auto_unbox = FALSE, json_verbatim = TRUE),
    closeDepth = closeDepth,
    values = list1(selected)
  ))
  config <- toJSON(config, auto_unbox = TRUE, json_verbatim = TRUE)
  tags$div(
    class = "form-group shiny-input-container",
    style = css(width = validateCssUnit(width)),
    label_input(inputId, label),
    tags$div(
      id = inputId,
      class = "tree-widget",
      `data-return` = returnValue,
      tags$script(
        type = "application/json",
        `data-for` = inputId,
        HTML(config)
      )
    ),
    html_dependency_tree()
  )
}



#' @title Update Tree Input
#'
#' @description Update [treeInput()] from server.
#'
#' @inheritParams shiny::updateCheckboxGroupInput
#'
#' @return No value.
#' @export
#'
#'
#' @example examples/tree-update.R
updateTreeInput <- function(inputId,
                            label = NULL,
                            selected = NULL,
                            session = shiny::getDefaultReactiveDomain()) {
  if (!is.null(label))
    label <- doRenderTags(label)
  message <- dropNulls(list(
    label = label,
    values = list1(selected)
  ))
  session$sendInputMessage(inputId, message)
}
