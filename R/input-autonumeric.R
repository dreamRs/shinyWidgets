
currencyInput <- function(inputId, label, value, format = "euro", width = NULL) {
  value <- shiny::restoreInput(inputId, value)
  tags$div(
    class = "form-group shiny-input-container",
    style = if (!is.null(width)) paste0("width: ", validateCssUnit(width), ";"),
    if (!is.null(label)) tags$label(`for` = inputId, label),
    tags$input(
      type = "text",
      style = "text-align: center; font-size: 1.5rem;",
      value = value,
      id = inputId,
      class = "form-control currency-input"
    ),
    tags$script(
      type = "application/json",
      `data-for` = inputId,
      jsonlite::toJSON(
        x = list(
          format = format
        ),
        auto_unbox = TRUE,
        json_verbatim = TRUE
      )
    ),
    html_dependency_autonumeric()
  )
}

