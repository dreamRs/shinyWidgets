
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



slimSelectInput <- function(inputId,
                            label,
                            choices,
                            selected = NULL,
                            multiple = FALSE,
                            search = TRUE,
                            ...,
                            inline = FALSE,
                            width = NULL) {
  selected <- restoreInput(id = inputId, default = selected)
  choices <- choicesWithNames(choices)
  data <- dropNulls(list(
    data = make_slim_data(choices),
    selected = selected,
    settings = dropNulls(list(
      showSearch = search,
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
    style = css(width = validateCssUnit(width)),
    label_input(inputId, label),
    tag_select,
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
