
#' @importFrom htmltools htmlDependency
html_dependency_virtualselect <- function() {
  htmlDependency(
    name = "virtual-select",
    version = "1.0.24",
    src = c(file = system.file("packer", package = "shinyWidgets")),
    script = "virtual-select.js"
  )
}


#' Prepare choices for [virtualSelectInput()]
#'
#' @param .data An object of type [data.frame()].
#' @param label Variable to use as labels (displayed to user).
#' @param value Variable to use as values (retrieved server-side).
#' @param group_by Variable identifying groups to use option group feature.
#' @param description Optional variable allowing to show a text under the labels.
#' @param alias Optional variable containing text to use with search feature.
#'
#' @return A `list` to use as `choices` argument of [virtualSelectInput()].
#' @export
#'
#' @importFrom rlang enexprs eval_tidy is_null
#'
#' @example inst/examples/virtual-select/prepare-choices/app.R
prepare_choices <- function(.data,
                            label,
                            value,
                            group_by = NULL,
                            description = NULL,
                            alias = NULL) {
  args <- lapply(
    X = enexprs(
      label = label,
      value = value,
      group_by = group_by,
      description = description,
      alias = alias
    ),
    FUN = eval_tidy,
    data = as.data.frame(.data)
  )
  args <- dropNulls(args)
  if (!is_null(args$group_by)) {
    type <- "transpose_group"
    groups <- args$group_by
    args$group_by <- NULL
    args <- lapply(
      X = unique(groups),
      FUN = function(group) {
        list(
          label = group,
          options = lapply(args, `[`, groups == group)
        )
      }
    )
  } else {
    type <- "transpose"
  }
  structure(list(choices = args, type = type), class = c("list", "vs_choices"))
}



#' @title Virtual Select Input
#'
#' @description A select dropdown widget made for performance,
#'  based on [virtual-select](https://github.com/sa-si-dev/virtual-select) JavaScript library.
#'
#' @param choices List of values to select from.
#' You can use:
#'  * `vector` use a simple vector for better performance.
#'  * `named list` / `named vector` in the same way as with [shiny::selectInput()]
#'  * custom formatted `list` allowing to use more options, must correspond to [virtual-select specifications](https://sa-si-dev.github.io/virtual-select/#/properties)
#'  * output of [prepare_choices()]
#' @inheritParams shiny::selectInput
#' @param search Enable search feature.
#' @param hideClearButton Hide clear value button.
#' @param autoSelectFirstOption Select first option by default on load.
#' @param showSelectedOptionsFirst Show selected options at the top of the dropbox.
#' @param showValueAsTags Show each selected values as tags with remove icon.
#' @param optionsCount No.of options to show on viewport.
#' @param noOfDisplayValues Maximum no.of values to show in the tooltip for multi-select.
#' @param allowNewOption Allow to add new option by searching.
#' @param disableSelectAll Disable select all feature of multiple select.
#' @param disableOptionGroupCheckbox Disable option group title checkbox.
#' @param disabled Disable entire dropdown.
#' @param ... Other arguments passed to JavaScript method, see
#'  [virtual-select documentation](https://sa-si-dev.github.io/virtual-select/#/properties) for a full list of options.
#' @param stateInput Activate or deactivate the special input value `input$<inputId>_open` to know if the menu is opened or not, see details.
#' @param html Allow usage of HTML in choices.
#' @param inline Display inline with label or not.
#'
#' @return A `shiny.tag` object that can be used in a UI definition.
#'
#' @note State of the menu (open or close) is accessible server-side through the input value:
#'  `input$<inputId>_open`, which can be `TRUE` (opened) or `FALSE` (closed) or `NULL` (when initialized).
#'
#' @seealso
#'  * [demoVirtualSelect()] for demo apps
#'  * [updateVirtualSelect()] for updating from server
#'
#' @export
#'
#' @importFrom htmltools tags css validateCssUnit HTML
#' @importFrom shiny restoreInput
#' @importFrom jsonlite toJSON
#'
#' @example inst/examples/virtual-select/default/app.R
virtualSelectInput <- function(inputId,
                               label,
                               choices,
                               selected = NULL,
                               multiple = FALSE,
                               search = FALSE,
                               hideClearButton = !multiple,
                               autoSelectFirstOption = !multiple,
                               showSelectedOptionsFirst = FALSE,
                               showValueAsTags = FALSE,
                               optionsCount = 10,
                               noOfDisplayValues = 50,
                               allowNewOption = FALSE,
                               disableSelectAll = !multiple,
                               disableOptionGroupCheckbox = !multiple,
                               disabled = FALSE,
                               ...,
                               stateInput = TRUE,
                               html = FALSE,
                               inline = FALSE,
                               width = NULL) {
  selected <- restoreInput(id = inputId, default = selected)
  choices <- process_choices(choices)
  data <- list(
    stateInput = stateInput,
    options = toJSON(choices, auto_unbox = FALSE, json_verbatim = TRUE),
    config = dropNulls(list(
      multiple = multiple,
      search = search,
      selectedValue = selected,
      hideClearButton = hideClearButton,
      autoSelectFirstOption = autoSelectFirstOption,
      showSelectedOptionsFirst = showSelectedOptionsFirst,
      showValueAsTags = showValueAsTags,
      optionsCount = optionsCount,
      noOfDisplayValues = noOfDisplayValues,
      allowNewOption = allowNewOption,
      disableSelectAll = disableSelectAll,
      disableOptionGroupCheckbox = disableOptionGroupCheckbox,
      disabled = disabled,
      ...
    ))
  )
  data <- toJSON(data, auto_unbox = TRUE, json_verbatim = TRUE)
  if (isTRUE(html))
    data <- HTML(data)

  if (!inline) {
    div_css <- css(
      width = "100%",
      maxWidth = "none",
      display = "block"
    )
  } else {
    div_css <- css(
      display = "inline-block"
    )
  }
  tags$div(
    class = "form-group shiny-input-container",
    class = if (isTRUE(inline)) "shiny-input-container-inline",
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
      class = "virtual-select",
      style = div_css,
      tags$script(
        type = "application/json",
        `data-for` = inputId,
        data
      )
    ),
    html_dependency_virtualselect()
  )
}



#' Update virtual select from server
#'
#' @inheritParams virtualSelectInput
#' @inheritParams shiny::updateSelectInput
#' @param disable Disable (`TRUE`) or enable (`FALSE`) the select menu.
#' @param disabledChoices List of disabled option's values.
#'
#' @return No value.
#' @export
#'
#' @importFrom shiny getDefaultReactiveDomain
#' @importFrom htmltools doRenderTags
#'
#' @example inst/examples/virtual-select/update/app.R
updateVirtualSelect <- function(inputId,
                                label = NULL,
                                choices = NULL,
                                selected = NULL,
                                disable = NULL,
                                disabledChoices = NULL,
                                session = shiny::getDefaultReactiveDomain()) {
  if (!is.null(label))
    label <- doRenderTags(label)
  if (!is.null(choices)) {
    choices <- process_choices(choices)
    choices <- toJSON(choices, auto_unbox = FALSE, json_verbatim = TRUE)
  }
  message <- dropNulls(list(
    label = label,
    options = choices,
    value = selected,
    disable = disable,
    disabledChoices = list1(disabledChoices)
  ))
  session$sendInputMessage(inputId, message)
}




#' Demo for [virtualSelectInput()]
#'
#' @param name Name of the demo app to launch.
#'
#' @return No value.
#' @export
#'
#' @importFrom shiny runApp shinyAppFile
#'
#' @examples
#' \dontrun{
#'
#' # Default usage
#' demoVirtualSelect("default")
#'
#' # Update widget from server
#' demoVirtualSelect("update")
#'
#' # Differents ways of specifying choices
#' demoVirtualSelect("choices-format")
#'
#' # Prepare choices from a data.frame
#' demoVirtualSelect("prepare-choices")
#'
#' }
demoVirtualSelect <- function(name = c("default", "update", "choices-format", "prepare-choices")) {
  name <- match.arg(name )
  runApp(
    shinyAppFile(
      appFile = system.file("examples", "virtual-select", name, "app.R", package = "shinyWidgets")
    ),
    display.mode = "showcase"
  )
}

