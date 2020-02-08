


colorPickr <- function(inputId, label, selected = "#112446",
                       swatches = NULL,
                       preview = TRUE, hue = TRUE, opacity = FALSE,
                       interaction = NULL,
                       theme = c("classic", "monolith", "nano"),
                       update = c("save", "changestop", "change", "swatchselect"),
                       hideOnselect = TRUE, comparison = TRUE,
                       useAsButton = TRUE, width = NULL) {

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
  }

  config <- list(
    update = update,
    hideOnselect = isTRUE(hideOnselect),
    options = dropNulls(list(
      useAsButton = useAsButton,
      theme = theme,
      default = selected,
      swatches = swatches,
      comparison = comparison,
      components = dropNulls(list(
        preview = preview,
        opacity = opacity,
        hue = hue,
        interaction = interaction
      ))
    ))
  )

  tags$div(
    class = "form-group shiny-input-container",
    style = if (!is.null(width)) paste0("width: ", validateCssUnit(width), ";"),
    if (!is.null(label)) tags$label(class = "control-label", `for` = inputId, label),
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
    html_dependencies_pickr()
  )
}



html_dependencies_pickr <- function() {
  htmlDependency(
    name = "pickr",
    version = "1.5.1",
    src = list(href = "shinyWidgets", file = "assets"),
    package = "shinyWidgets",
    script = c("pickr/js/pickr.min.js", "pickr/pickr-bindings.js"),
    stylesheet = c(
      "pickr/css/classic.min.css",
      "pickr/css/monolith.min.css",
      "pickr/css/nano.min.css"
    ),
    all_files = FALSE
  )
}


