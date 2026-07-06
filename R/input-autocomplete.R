
autocompleteInput <- function(inputId,
                              label = NULL,
                              choices = character(),
                              placeholder = "Rechercher...",
                              searchEngine = c("strict", "loose"),
                              maxResults = 5,
                              width = NULL) {
  searchEngine <- match.arg(searchEngine)
  cfg <- list(
    choices = unname(as.character(choices)),
    placeholder = placeholder,
    searchEngine = searchEngine,
    resultsList = list(maxResults = maxResults)
  )

  shiny::tagList(
    shiny::tags$div(
      id = inputId,
      class = "form-group shiny-input-container sw-autocomplete",
      style = css(width = validateCssUnit(width)),
      `data-config` = jsonlite::base64_enc(charToRaw(jsonlite::toJSON(cfg, auto_unbox = TRUE))),
      label_input(inputId, label),
      shiny::tags$input(
        type = "text",
        class = "form-control",
        autocomplete = "off",
        placeholder = placeholder
      )
    ),
    autocompleteDependency()
  )
}

autocompleteDependency <- function() {
  htmltools::htmlDependency(
    name = "shiny-autocompletejs",
    version = "0.0.1",
    src = c(file = system.file("packer", package = "shinyWidgets")),
    script = c("autocomplete.js"),
    stylesheet = "autoComplete.02.min.css"
  )
}

updateAutocompleteInput <- function(session, inputId, choices = NULL, value = NULL, placeholder = NULL) {
  message <- list()
  if (!is.null(choices)) message$choices <- unname(as.character(choices))
  if (!is.null(value)) message$value <- as.character(value)
  if (!is.null(placeholder)) message$placeholder <- as.character(placeholder)

  session$sendInputMessage(inputId, message)
}
