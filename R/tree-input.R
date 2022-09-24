
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
#' @param width The width of the input, e.g. `400px`, or `"100%`.
#'
#' @return A `shiny.tag` object that can be used in a UI definition.
#' @export
#'
#' @examples
treeInput <- function(inputId,
                      label,
                      choices,
                      selected = NULL,
                      closeDepth = 1,
                      returnValue = c("text", "id", "all"),
                      width = NULL) {
  returnValue <- match.arg(returnValue)
  config <- dropNulls(list(
    data = toJSON(choices, auto_unbox = FALSE, json_verbatim = TRUE),
    closeDepth = closeDepth,
    values = list1(selected)
  ))
  config <- toJSON(config, auto_unbox = TRUE, json_verbatim = TRUE)
  tags$div(
    class = "form-group shiny-input-container",
    style = css(width = validateCssUnit(width)),
    tags$label(
      label,
      class = "control-label",
      class = if (is.null(label)) "shiny-label-null",
      id = paste0(inputId, "-label"),
      `for` = inputId
    ),
    tags$div(
      id = inputId,
      class = "tree-widget",
      `data-return` = returnValue,
      tags$script(
        type = "application/json",
        `data-for` = inputId,
        config
      )
    ),
    html_dependency_tree()
  )
}
