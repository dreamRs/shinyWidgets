
#  ------------------------------------------------------------------------
#
# Title : shinyWidgets Gallery - global
#    By : Victor
#  Date : 2020-12-01
#
#  ------------------------------------------------------------------------


# shinyWidgets examples ---------------------------------------------------

library(shinydashboard) # shinydashboard bs4Dash
library(shinyWidgets)

if (any(ls(".GlobalEnv") %in% ls("package:shinyWidgets")))
  warning("Some function(s) from GlobalEnv will override those from shinyWidgets")

# ids <- paste0("Id", sprintf("%03d", 1:81))
.shinyWidgetGalleryId <- 1
# idss <- ids



# Funs --------------------------------------------------------------------

# Widget wrapper ----

.shinyWidgetGalleryFuns <- new.env()

.shinyWidgetGalleryFuns$widget_wrapper <- function(fun, args){
  raw <- paste0(
    deparse(substitute(fun)),
    gsub(
      pattern = "^list", replacement = "",
      x = paste(deparse(substitute(args)), collapse = "\n")
    )
  )
  raw <- gsub(pattern = "ID\\(\\.shinyWidgetGalleryId\\)", replacement = paste0("\"", args$inputId, "\""), x = raw)

  formatted <- sub(pattern = "\\(", replacement = "\\(\n   ", x = raw)
  formatted <- gsub(pattern = "\\)$", replacement = "\n\\)", x = formatted)
  formatted <- gsub(pattern = ",(\\s[[:graph:]]+\\s=)", replacement = ",\n  \\1", x = formatted)
  formatted <- gsub(pattern = "list\\(", replacement = "list\\(\n      ", x = formatted)
  formatted <- trimws(formatted)

  htmltools::tagList(
    do.call(fun, args), htmltools::hr(),
    htmltools::tags$b("Value :"),
    shiny::verbatimTextOutput(outputId = paste0("res", args$inputId)),
    htmltools::tags$b(tags$a(icon("code"), "Show code", `data-toggle`="collapse", href=paste0("#showcode", args$inputId))),
    htmltools::tags$div(
      class="collapse", id=paste0("showcode", args$inputId),
      .shinyWidgetGalleryFuns$rCodeContainer(
        id=paste0("code", args$inputId),
        formatted
      )
    )
  )
}

.shinyWidgetGalleryFuns$box_wrapper <- function(title, ..., footer = NULL) {
  box(
    title = title, status = "danger", width = NULL, footer = footer,
    ...
  )
}

.shinyWidgetGalleryFuns$pb_code <- function(id, ui, server) {
  htmltools::tagList(
    htmltools::tags$b(tags$a(icon("code"), "Show code", `data-toggle`="collapse", href=paste0("#showcode", id))),
    htmltools::tags$div(
      class="collapse", id=paste0("showcode", id),
      .shinyWidgetGalleryFuns$rCodeContainer(
        id=paste0("code", id),
        paste(
          "# ui",
          ui,
          "# server",
          server,
          sep = "\n"
        )
      )
    )
  )
}



# Highlight functions ----

.shinyWidgetGalleryFuns$injectHighlightHandler <- function() {
  code <- "
  Shiny.addCustomMessageHandler('highlight-code', function(message) {
  var id = message['id'];
  setTimeout(function() {
  var el = document.getElementById(id);
  hljs.highlightBlock(el);
  }, 100);
  });
  "
  htmltools::tags$script(code)
}

.shinyWidgetGalleryFuns$includeHighlightJs <- function() {
  resources <- system.file("www/shared/highlight", package = "shiny")
  list(
    htmltools::includeScript(file.path(resources, "highlight.pack.js")),
    htmltools::includeCSS(file.path(resources, "rstudio.css")),
    .shinyWidgetGalleryFuns$injectHighlightHandler()
  )
}

.shinyWidgetGalleryFuns$highlightCode <- function(session, id) {
  session$sendCustomMessage("highlight-code", list(id = id))
}

.shinyWidgetGalleryFuns$rCodeContainer <- function(...) {
  code <- htmltools::HTML(as.character(tags$code(class = "language-r", ...)))
  htmltools::tags$div(htmltools::tags$pre(code))
}

.shinyWidgetGalleryFuns$renderCode <- function(expr, env = parent.frame(), quoted = FALSE) {
  func <- NULL
  shiny::installExprFunction(expr, "func", env, quoted)
  shiny::markRenderFunction(shiny::textOutput, function() {
    paste(func(), collapse = "\n")
  })
}


# Message for tests

message("Running shinyWidgets gallery...")

