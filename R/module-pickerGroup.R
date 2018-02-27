
#' @title Picker Group
#'
#' @description Group of mutually dependent `pickerInput` for filtering data.frame's columns.
#'
#' @param id Module's id.
#' @param params a named list of parameters passed to each `pickerInput`, you can use :
#'  `inputId` (obligatory, must be variable name), `label`, `placeholder`.
#' @param label character, global label on top of all labels.
#' @param btn_label reset button label.
#' @param options See \code{\link{pickerInput}} options argument.
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
#' \dontrun{
#'
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
#'             manufacturer = list(inputId = "manufacturer", title = "Manufacturer:"),
#'             model = list(inputId = "model", title = "Model:"),
#'             trans = list(inputId = "trans", title = "Trans:"),
#'             class = list(inputId = "class", title = "Class:")
#'           )
#'         ), status = "primary"
#'       ),
#'       dataTableOutput(outputId = "table")
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
#'   output$table <- renderDataTable(res_mod())
#' }
#'
#' shinyApp(ui, server)
#'
#' }
#'
#' }
pickerGroupUI <- function(id, params, label = NULL, btn_label = "Reset filters", options = list()) {

  # Namespace
  ns <- NS(id)

  # # ids
  # ids <- unlist(lapply(params, `[[`, "inputId"), use.names = FALSE)
  # cond <- paste0(paste0("[", paste(paste0("input['", ns(ids), "']"), collapse = ", "), "]"), ".length > 0")

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
    tags$b(label),
    tags$div(
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
    ),
    actionLink(
      inputId = ns("reset_all"),
      label = btn_label,
      icon = icon("remove"),
      style = "float: right;"
    )
  )

}

#' @param input standard \code{shiny} input.
#' @param output standard \code{shiny} output.
#' @param session standard \code{shiny} session.
#' @param data a \code{data.frame}, or an object coercible to \code{data.frame}.
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

  # toggleDisplayServer(session = session, id = ns("reset_all"), display = "none")

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
        # tmp <- unique(data[, c(x, "indicator")])
        tmp <- aggregate(
          formula = as.formula(paste("indicator", x, sep = "~")),
          data = data,
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


