
#' @importFrom htmltools htmlDependency
html_dependency_tree <- function() {
  htmlDependency(
    name = "treejs",
    version = "1.8.3",
    src = c(file = system.file("packer", package = "shinyWidgets")),
    script = "tree.js"
  )
}

treeInput <- function(inputId, label, choices, closeDepth = 1, width = NULL) {
  config <- list(
    data = toJSON(choices, auto_unbox = FALSE, json_verbatim = TRUE),
    closeDepth = closeDepth
  )
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
      # style = css(
      #   width = "100%",
      #   maxWidth = "none"
      # ),
      tags$script(
        type = "application/json",
        `data-for` = inputId,
        config
      )
    ),
    html_dependency_tree()
  )
}
