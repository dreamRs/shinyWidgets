


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
                       comparison = TRUE,
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
      comparison = comparison,
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
    html_dependency_pickr()
  )
}



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


