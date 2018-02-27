
#' @title Selectize Group
#'
#' @description Group of mutually dependent `selectizeInput` for filtering data.frame's columns (like in Excel).
#'
#' @param id Module's id.
#' @param params a named list of parameters passed to each `selectizeInput`, you can use :
#'  `inputId` (obligatory, must be variable name), `label`, `placeholder`.
#' @param label character, global label on top of all labels.
#' @param btn_label reset button label.
#'
#' @return a \code{reactive} function containing data filtered.
#' @export
#'
#' @name selectizeGroup-module
#'
#' @importFrom htmltools tagList tags
#' @importFrom shiny NS selectizeInput actionLink icon singleton
#'
#' @examples
#' \dontrun{
#'
#' if (interactive()) {
#'
#' library(shiny)
#' library(shinyWidgets)
#'
#' data("mpg", package = "ggplot2")
#'
#' ui <- fluidPage(
#'   fluidRow(
#'     column(
#'       width = 10, offset = 1,
#'       tags$h3("Filter data with selectize group"),
#'       panel(
#'         selectizeGroupUI(
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
#'     module = selectizeGroupServer,
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
selectizeGroupUI <- function(id, params, label = NULL, btn_label = "Reset filters") {

  # Namespace
  ns <- NS(id)

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
      class="btn-group-justified selectize-group",
      role="group", `data-toggle`="buttons",
      lapply(
        X = seq_along(params),
        FUN = function(x) {
          input <- params[[x]]
          tagSelect <- tags$div(
            class="btn-group",
            selectizeInput(
              inputId = ns(input$inputId),
              label = input$title,
              choices = input$choices,
              selected = input$selected,
              multiple = TRUE,
              width = "100%",
              options = list(
                placeholder = input$placeholder, plugins = list("remove_button"),
                onInitialize = I('function() { this.setValue(""); }')
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
#' @rdname selectizeGroup-module
#' @importFrom shiny updateSelectizeInput observeEvent reactiveValues reactive
selectizeGroupServer <- function(input, output, session, data, vars) { # nocov start

  data <- as.data.frame(data)

  # Namespace
  ns <- session$ns

  toggleDisplayServer(session = session, id = ns("reset_all"), display = "none")

  lapply(
    X = vars,
    FUN = function(x) {
      vals <- sort(unique(data[[x]]))
      updateSelectizeInput(
        session = session,
        inputId = x,
        choices = vals,
        server = TRUE
      )
    }
  )

  observeEvent(input$reset_all, {
    lapply(
      X = vars,
      FUN = function(x) {
        vals <- sort(unique(data[[x]]))
        updateSelectizeInput(
          session = session,
          inputId = x,
          choices = vals,
          server = TRUE
        )
      }
    )
  })


  lapply(
    X = vars,
    FUN = function(x) {

      ovars <- vars[vars != x]

      observeEvent(input[[x]], {

        indicator <- lapply(
          X = vars,
          FUN = function(x) {
            data[[x]] %inT% input[[x]]
          }
        )
        indicator <- Reduce(f = `&`, x = indicator)
        data <- data[indicator, ]

        if (all(indicator)) {
          toggleDisplayServer(session = session, id = ns("reset_all"), display = "none")
        } else {
          toggleDisplayServer(session = session, id = ns("reset_all"), display = "block")
        }

        for (i in ovars) {
          if (is.null(input[[i]])) {
            updateSelectizeInput(
              session = session,
              inputId = i,
              choices = sort(unique(data[[i]])),
              server = TRUE
            )
          }
        }

        if (is.null(input[[x]])) {
          updateSelectizeInput(
            session = session,
            inputId = x,
            choices = sort(unique(data[[x]])),
            server = TRUE
          )
        }

      }, ignoreNULL = FALSE, ignoreInit = TRUE)

    }
  )

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




