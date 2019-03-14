
#' Display a spinner above an output when this one recalculate
#'
#' @param output An output element, typically the result of \code{renderPlot}.
#' @param spin Style of the spinner, choice between : \code{circle}, \code{bounce}, \code{folding-cube},
#'  \code{rotating-plane}, \code{cube-grid}, \code{fading-circle}, \code{double-bounce}, \code{dots}, \code{cube}.
#' @param color Color for the spinner.
#'
#' @note The spinner don't disappear from the page, it's only masked by the plot,
#'  so the plot must have a non-transparent background. For a more robust way to
#'  insert loaders, see package "shinycssloaders".
#'
#' @return a list of tags
#' @export
#'
#' @importFrom htmltools tags tagList singleton
#'
#' @examples
#' # wrap an output:
#' addSpinner(shiny::plotOutput("plot"))
#'
#' # Complete demo:
#'
#' if (interactive()) {
#'
#' library(shiny)
#' library(shinyWidgets)
#'
#' ui <- fluidPage(
#'   tags$h2("Exemple spinners"),
#'   actionButton(inputId = "refresh", label = "Refresh", width = "100%"),
#'   fluidRow(
#'     column(
#'       width = 5, offset = 1,
#'       addSpinner(plotOutput("plot1"), spin = "circle", color = "#E41A1C"),
#'       addSpinner(plotOutput("plot3"), spin = "bounce", color = "#377EB8"),
#'       addSpinner(plotOutput("plot5"), spin = "folding-cube", color = "#4DAF4A"),
#'       addSpinner(plotOutput("plot7"), spin = "rotating-plane", color = "#984EA3"),
#'       addSpinner(plotOutput("plot9"), spin = "cube-grid", color = "#FF7F00")
#'     ),
#'     column(
#'       width = 5,
#'       addSpinner(plotOutput("plot2"), spin = "fading-circle", color = "#FFFF33"),
#'       addSpinner(plotOutput("plot4"), spin = "double-bounce", color = "#A65628"),
#'       addSpinner(plotOutput("plot6"), spin = "dots", color = "#F781BF"),
#'       addSpinner(plotOutput("plot8"), spin = "cube", color = "#999999")
#'     )
#'   ),
#'   actionButton(inputId = "refresh2", label = "Refresh", width = "100%")
#' )
#'
#' server <- function(input, output, session) {
#'
#'   dat <- reactive({
#'     input$refresh
#'     input$refresh2
#'     Sys.sleep(3)
#'     Sys.time()
#'   })
#'
#'   lapply(
#'     X = seq_len(9),
#'     FUN = function(i) {
#'       output[[paste0("plot", i)]] <- renderPlot({
#'         dat()
#'         plot(sin, -pi, i*pi)
#'       })
#'     }
#'   )
#'
#' }
#'
#' shinyApp(ui, server)
#'
#' }
#'
addSpinner <- function(output, spin = "double-bounce", color = "#112446") {
  spin <- match.arg(
    arg = spin, choices = c(
      "circle", "bounce", "folding-cube", "rotating-plane", "cube-grid",
      "fading-circle", "double-bounce", "dots", "cube"
    )
  )
  alea <- paste(sample(letters, 12, T), collapse = "")
  if (spin == "circle") {
    tagSpin <- tags$div(
      tags$style(
        sprintf(
          ".sk-circle .sk-child-%s:before {background-color: %s;}",
          alea, color
        )
      ),
      tags$div(
        class = "sk-circle loading-spinner",
        lapply(
          X = seq_len(12),
          FUN = function(i) {
            tags$div(
              class = sprintf("sk-circle%s sk-child sk-child-%s", i, alea)
            )
          }
        )
      )
    )
  } else if (spin == "double-bounce") {
    tagSpin <- tags$div(
      class = "spinner loading-spinner",
      tags$div(class = "double-bounce1", style = sprintf("background-color: %s;", color)),
      tags$div(class = "double-bounce2", style = sprintf("background-color: %s;", color))
    )
  } else if (spin == "folding-cube") {
    tagSpin <- tags$div(
      class="loading-spinner",
      tags$style(
        sprintf(
          ".sk-folding-cube .sk-cube-%s:before {background-color: %s;}",
          alea, color
        )
      ),
      tags$div(
        class="sk-folding-cube",
        tags$div(class=sprintf("sk-cube1 sk-cube sk-cube-%s", alea)),
        tags$div(class=sprintf("sk-cube2 sk-cube sk-cube-%s", alea)),
        tags$div(class=sprintf("sk-cube4 sk-cube sk-cube-%s", alea)),
        tags$div(class=sprintf("sk-cube3 sk-cube sk-cube-%s", alea))
      )
    )
  } else if (spin == "rotating-plane") {
    tagSpin <- tags$div(
      class="loading-spinner",
      tags$div(
        class="rotating-plane",
        style = sprintf("background-color: %s;", color)
      )
    )
  } else if (spin == "cube-grid") {
    tagSpin <- tags$div(
      class="sk-cube-grid loading-spinner",
      lapply(
        X = seq_len(9),
        FUN = function(i) {
          tags$div(
            style = sprintf("background-color: %s;", color),
            class=sprintf("sk-cube sk-cube%s", i)
          )
        }
      )
    )
  } else if (spin == "fading-circle") {
    tagSpin <- tags$div(
      class="spinner loading-spinner",
      tags$style(
        sprintf(
          ".sk-fading-circle .sk-circle-%s:before {background-color: %s;}",
          alea, color
        )
      ),
      tags$div(
        class="sk-fading-circle",
        lapply(
          X = seq_len(12),
          FUN = function(i) {
            tags$div(
              class=sprintf("sk-circle%s sk-circle sk-circle-%s", i, alea)
            )
          }
        )
      )
    )
  } else if (spin == "bounce") {
    tagSpin <- tags$div(
      class="spinner-bounce loading-spinner",
      tags$div(
        style = sprintf("background-color: %s;", color),
        class="bounce1"
      ),
      tags$div(
        style = sprintf("background-color: %s;", color),
        class="bounce2"
      ),
      tags$div(
        style = sprintf("background-color: %s;", color),
        class="bounce3"
      )
    )
  } else if (spin == "dots") {
    tagSpin <- tags$div(
      class="spinner-dots loading-spinner",
      tags$div(
        style = sprintf("background-color: %s;", color),
        class="dot1"
      ),
      tags$div(
        style = sprintf("background-color: %s;", color),
        class="dot2"
      )
    )
  } else if (spin == "cube") {
    tagSpin <- tags$div(
      class="spinner-cube loading-spinner",
      tags$div(
        style = sprintf("background-color: %s;", color),
        class="cube1"
      ),
      tags$div(
        style = sprintf("background-color: %s;", color),
        class="cube2"
      )
    )
  }

  style <- try(get_style(output), silent = TRUE)
  if (inherits(style, "try-error"))
    style <- list()
  tagList(
    singleton(tags$head(
      tags$link(href = "shinyWidgets/spinner/spin.css", rel = "stylesheet", type = "text/css"),
      tags$style(".recalculating {opacity: 0.01 !important}")
    )),
    tags$div(
      style = "position: relative;",
      style = if(!is.null(style$width)) paste0("width:", style$width, ";"),
      style = if(!is.null(style$height)) paste0("height:", style$height, ";"),
      tagSpin,
      output
    )
  )
}

#' @importFrom htmltools tagGetAttribute
#' @importFrom stats setNames
get_style <- function(tag) {
  if (inherits(tag, "shiny.tag")) {
    style <- htmltools::tagGetAttribute(tag, "style")
    if (is.null(style))
      return(list())
    style <- strsplit(x = style, split = ";")[[1]]
    style <- lapply(
      X = style,
      FUN = function(x) {
        x <- strsplit(x, ":")[[1]]
        x <-  trimws(x)
        setNames(list(x[2]), x[1])
      }
    )
    Reduce(c, style)
  } else if (inherits(tag, "shiny.tag.list")) {
    get_style(tag[[1]])
  } else {
    list()
  }
}
