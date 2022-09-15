
#' @title Picker Group
#'
#' @description Group of mutually dependent \code{\link{pickerInput}} for filtering \code{data.frame}'s columns.
#'
#' @param id Module's id.
#' @param params A named list of parameters passed to each \code{\link{pickerInput}}, you can use :
#'  `inputId` (obligatory, must be variable name), `label`, `placeholder`.
#' @param label Character, global label on top of all labels.
#' @param btn_label Character, reset button label.
#' @param options See \code{\link{pickerInput}} options argument.
#' @param inline If \code{TRUE} (the default), \code{pickerInput}s are horizontally positioned, otherwise vertically.
#'
#' @return a \code{reactive} function containing data filtered.
#' @export
#'
#' @name pickerGroup-module
#'
#' @importFrom htmltools tagList tags singleton
#' @importFrom shiny NS actionLink icon
#' @importFrom utils modifyList
#'
#' @examples
#' if (interactive()) {
#'
#' library(shiny)
#' library(shinyWidgets)
#'
#'
#' data("mpg", package = "ggplot2")
#'
#'
#' ui <- fluidPage(
#'   fluidRow(
#'     column(
#'       width = 10, offset = 1,
#'       tags$h3("Filter data with picker group"),
#'       panel(
#'         pickerGroupUI(
#'           id = "my-filters",
#'           params = list(
#'             manufacturer = list(inputId = "manufacturer", label = "Manufacturer:"),
#'             model = list(inputId = "model", label = "Model:"),
#'             trans = list(inputId = "trans", label = "Trans:"),
#'             class = list(inputId = "class", label = "Class:")
#'           )
#'         ), status = "primary"
#'       ),
#'       DT::dataTableOutput(outputId = "table")
#'     )
#'   )
#' )
#'
#' server <- function(input, output, session) {
#'   res_mod <- callModule(
#'     module = pickerGroupServer,
#'     id = "my-filters",
#'     data = mpg,
#'     vars = c("manufacturer", "model", "trans", "class")
#'   )
#'   output$table <- DT::renderDataTable(res_mod())
#' }
#'
#' shinyApp(ui, server)
#'
#' }
#'
#'
#' ### Not inline example
#'
#' if (interactive()) {
#'
#'   library(shiny)
#'   library(shinyWidgets)
#'
#'
#'   data("mpg", package = "ggplot2")
#'
#'
#'   ui <- fluidPage(
#'     fluidRow(
#'       column(
#'         width = 4,
#'         tags$h3("Filter data with picker group"),
#'         pickerGroupUI(
#'           id = "my-filters",
#'           inline = FALSE,
#'           params = list(
#'             manufacturer = list(inputId = "manufacturer", label = "Manufacturer:"),
#'             model = list(inputId = "model", label = "Model:"),
#'             trans = list(inputId = "trans", label = "Trans:"),
#'             class = list(inputId = "class", label = "Class:")
#'           )
#'         )
#'       ),
#'       column(
#'         width = 8,
#'         DT::dataTableOutput(outputId = "table")
#'       )
#'     )
#'   )
#'
#'   server <- function(input, output, session) {
#'     res_mod <- callModule(
#'       module = pickerGroupServer,
#'       id = "my-filters",
#'       data = mpg,
#'       vars = c("manufacturer", "model", "trans", "class")
#'     )
#'     output$table <- DT::renderDataTable(res_mod())
#'   }
#'
#'   shinyApp(ui, server)
#'
#' }
pickerGroupUI <- function(id, params, label = NULL, btn_label = "Reset filters", options = list(), inline = TRUE) {

  # Namespace
  ns <- NS(id)

  if (isTRUE(inline)) {
    tagPicker <- tags$div(
      class="btn-group-justified picker-group",
      role="group", `data-toggle`="buttons",
      lapply(
        X = seq_along(params),
        FUN = function(x) {
          input <- params[[x]]
          tagSelect <- tags$div(
            class="btn-group",
            pickerInput(
              inputId = ns(input$inputId),
              label = input$label,
              selected = input$selected,
              choices = input$choices,
              multiple = TRUE,
              width = "100%",
              options = modifyList(
                x = options,
                val = list(
                  `actions-box` = FALSE,
                  `selected-text-format`= "count > 5",
                  `count-selected-text` = "{0} choices (on a total of {1})"
                )
              )
            )
          )
          return(tagSelect)
        }
      )
    )
  } else {
    tagPicker <- lapply(
      X = params,
      FUN = function(x) {
        pickerInput(
          inputId = ns(x$inputId),
          label = x$label,
          selected = x$selected,
          choices = x$choices,
          multiple = TRUE,
          width = "100%",
          options = modifyList(
            x = options,
            val = list(
              `actions-box` = FALSE,
              `selected-text-format`= "count > 5",
              `count-selected-text` = "{0} choices (on a total of {1})"
            )
          )
        )
      }
    )
  }

  tagList(
    singleton(
      tagList(
        tags$link(
          rel="stylesheet",
          type="text/css",
          href="shinyWidgets/modules/styles-modules.css"
        ), toggleDisplayUi()
      )
    ),
    tags$label(label),
    tagPicker,
    actionLink(
      inputId = ns("reset_all"),
      label = btn_label,
      icon = icon("xmark"),
      style = "float: right;"
    )
  )

}

#' @param input standard \code{shiny} input.
#' @param output standard \code{shiny} output.
#' @param session standard \code{shiny} session.
#' @param data a \code{data.frame}, or an object that can be coerced to \code{data.frame}.
#' @param vars character, columns to use to create filters,
#'  must correspond to variables listed in \code{params}.
#'
#' @export
#'
#' @rdname pickerGroup-module
#' @importFrom shiny observeEvent reactiveValues reactive observe reactiveValuesToList
#' @importFrom stats aggregate as.formula
pickerGroupServer <- function(input, output, session, data, vars) { # nocov start

  data <- as.data.frame(data)

  # Namespace
  ns <- session$ns

  lapply(
    X = vars,
    FUN = function(x) {
      vals <- sort(unique(data[[x]]))
      updatePickerInput(
        session = session,
        inputId = x,
        choices = vals
      )
    }
  )

  observeEvent(input$reset_all, {
    lapply(
      X = vars,
      FUN = function(x) {
        vals <- sort(unique(data[[x]]))
        updatePickerInput(
          session = session,
          inputId = x,
          choices = vals
        )
      }
    )
  })

  data_r <- reactiveValues()

  observe({
    inputs <- reactiveValuesToList(input)
    inputs[["reset_all"]] <- NULL
    indicator <- lapply(
      X = vars,
      FUN = function(x) {
        data[[x]] %inT% inputs[[x]]
      }
    )
    data$indicator <- Reduce(f = `&`, x = indicator)
    if (all(data$indicator)) {
      toggleDisplayServer(session = session, id = ns("reset_all"), display = "none")
    } else {
      toggleDisplayServer(session = session, id = ns("reset_all"), display = "block")
    }
    lapply(
      X = vars,
      FUN = function(x) {
        tmp <- aggregate(
          list(indicator = data$indicator),
          by = setNames(list(data[[x]]), x),
          FUN = Reduce, f = `|`
        )
        updatePickerInput(
          session = session,
          inputId = x,
          choices = tmp[[x]],
          selected = inputs[[x]],
          choicesOpt = list(
            disabled = !tmp$indicator,
            style = ifelse(
              !tmp$indicator,
              yes = "color: rgba(119, 119, 119, 0.5);",
              no = ""
            )
          )
        )
      }
    )
  })


  return(reactive({
    indicator <- lapply(
      X = vars,
      FUN = function(x) {
        data[[x]] %inT% input[[x]]
      }
    )
    indicator <- Reduce(f = `&`, x = indicator)
    data <- data[indicator, ]
    return(data)
  }))
}
# nocov end


