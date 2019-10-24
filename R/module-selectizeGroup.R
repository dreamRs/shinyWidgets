
#' @title Selectize Group
#'
#' @description Group of mutually dependent `selectizeInput` for filtering data.frame's columns (like in Excel).
#'
#' @param id Module's id.
#' @param params A named list of parameters passed to each `selectizeInput`, you can use :
#'  `inputId` (obligatory, must be variable name), `label`, `placeholder`.
#' @param label Character, global label on top of all labels.
#' @param btn_label Character, reset button label.
#' @param inline If \code{TRUE} (the default), `selectizeInput`s are horizontally positioned, otherwise vertically.
#'
#' @return a \code{reactive} function containing data filtered.
#' @export
#'
#' @name selectizeGroup-module
#'
#' @importFrom htmltools tagList tags
#' @importFrom shiny NS selectizeInput actionLink icon singleton
#'
#' @example examples/selectizeGroup-default.R
#' @example examples/selectizeGroup-vars.R
#' @example examples/selectizeGroup-subset.R
selectizeGroupUI <- function(id, params, label = NULL, btn_label = "Reset filters", inline = TRUE) {

  # Namespace
  ns <- NS(id)

  if (inline) {
    selectizeGroupTag <- tagList(
      tags$b(label),
      tags$div(
        class="btn-group-justified selectize-group",
        role="group", `data-toggle`="buttons",
        lapply(
          X = seq_along(params),
          FUN = function(x) {
            input <- params[[x]]
            tagSelect <- tags$div(
              class = "btn-group",
              id = ns(paste0("container-", input$inputId)),
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
  } else {
    selectizeGroupTag <- tagList(
      tags$b(label),
      lapply(
        X = seq_along(params),
        FUN = function(x) {
          input <- params[[x]]
          tagSelect <- selectizeInput(
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
          return(tagSelect)
        }
      ),
      actionLink(
        inputId = ns("reset_all"),
        label = btn_label,
        icon = icon("remove"),
        style = "float: right;"
      )
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
    selectizeGroupTag
  )

}


#' @param input,output,session standards \code{shiny} server arguments.
#' @param data Either a \code{data.frame} or a \code{reactive}
#'  function returning a \code{data.frame} (do not use parentheses).
#' @param vars character, columns to use to create filters,
#'  must correspond to variables listed in \code{params}. Can be a
#'  \code{reactive} function, but values must be included in the initial ones (in \code{params}).
#'
#' @export
#'
#' @rdname selectizeGroup-module
#' @importFrom shiny updateSelectizeInput observeEvent reactiveValues reactive is.reactive
selectizeGroupServer <- function(input, output, session, data, vars) { # nocov start

  # Namespace
  ns <- session$ns
  toggleDisplayServer(
    session = session, id = ns("reset_all"), display = "none"
  )


  # data <- as.data.frame(data)
  rv <- reactiveValues(data = NULL, vars = NULL)
  observe({
    if (is.reactive(data)) {
      rv$data <- data()
    } else {
      rv$data <- as.data.frame(data)
    }
    if (is.reactive(vars)) {
      rv$vars <- vars()
    } else {
      rv$vars <- vars
    }
    for (var in names(rv$data)) {
      if (var %in% rv$vars) {
        toggleDisplayServer(
          session = session, id = ns(paste0("container-", var)), display = "table-cell"
        )
      } else {
        toggleDisplayServer(
          session = session, id = ns(paste0("container-", var)), display = "none"
        )
      }
    }
  })

  observe({
    lapply(
      X = rv$vars,
      FUN = function(x) {
        vals <- sort(unique(rv$data[[x]]))
        updateSelectizeInput(
          session = session,
          inputId = x,
          choices = vals,
          server = TRUE
        )
      }
    )
  })

  observeEvent(input$reset_all, {
    lapply(
      X = rv$vars,
      FUN = function(x) {
        vals <- sort(unique(rv$data[[x]]))
        updateSelectizeInput(
          session = session,
          inputId = x,
          choices = vals,
          server = TRUE
        )
      }
    )
  })


  observe({
    vars <- rv$vars
    lapply(
      X = vars,
      FUN = function(x) {

        ovars <- vars[vars != x]

        observeEvent(input[[x]], {

          data <- rv$data

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
  })

  return(reactive({
    data <- rv$data
    vars <- rv$vars
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




