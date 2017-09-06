


# shinyWidgets examples ---------------------------------------------------

library("shinydashboard")
library("shinyWidgets")
if (!require("formatR")) install.packages("formatR")

# data("animations", package = "shinyWidgets")


if (any(ls(".GlobalEnv") %in% ls("package:shinyWidgets")))
  warning("Some function(s) from GlobalEnv will override those from shinyWidgets")



# Ids widgets
ids <- paste0("Id", sprintf("%03d", 1:75))
ids <- 1
idss <- ids

# ID <- function(ids) {
#   if (length(ids) == 0) stop("Not enougth IDs")
#   res <- ids[1]
#   ids <<- ids[-1]
#   return(res)
# }
ID <- function(ids) {
  tmp <- paste0("Id", sprintf("%03d", ids))
  ids <<- ids + 1
  return(tmp)
}


# Widget wrapper ----

widget_wrapper <- function(fun, args){

  # raw <- paste(
  #   capture.output(
  #     match.call(fun, do.call("call", c(deparse(substitute(fun)), args)))
  #   ),
  #   collapse = " "
  # )
  raw <- paste0(
    deparse(substitute(fun)),
    gsub(
      pattern = "^list", replacement = "",
      x = paste(deparse(substitute(args)), collapse = "")
    )
  )
  raw <- gsub(pattern = "ID\\(ids\\)", replacement = paste0("\"", args$inputId, "\""), x = raw)


  formatted <- formatR::tidy_source(
    text = raw,
    output = FALSE,
    width.cutoff = 30,
    indent = 2,
    brace.newline = FALSE
  )$text.tidy

  tagList(
    do.call(fun, args), hr(),
    tags$b("Value :"),
    verbatimTextOutput(outputId = paste0("res", args$inputId)),
    tags$b(tags$a(icon("code"), "Show code", `data-toggle`="collapse", href=paste0("#showcode", args$inputId))),
    tags$div(
      class="collapse", id=paste0("showcode", args$inputId),
      rCodeContainer(
        id=paste0("code", args$inputId),
        formatted
      )
    )
  )
}


box_wrapper <- function(title, ..., footer = NULL) {
  box(
    title = title, status = "danger", width = NULL, footer = footer,
    ...
  )
}


pb_code <- function(id, ui, server) {
  tagList(
    tags$b(tags$a(icon("code"), "Show code", `data-toggle`="collapse", href=paste0("#showcode", id))),
    tags$div(
      class="collapse", id=paste0("showcode", id),
      rCodeContainer(
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

injectHighlightHandler <- function() {

  code <- "
  Shiny.addCustomMessageHandler('highlight-code', function(message) {
  var id = message['id'];
  setTimeout(function() {
  var el = document.getElementById(id);
  hljs.highlightBlock(el);
  }, 100);
  });
  "

  tags$script(code)
}


includeHighlightJs <- function() {
  resources <- system.file("www/shared/highlight", package = "shiny")
  list(
    includeScript(file.path(resources, "highlight.pack.js")),
    includeCSS(file.path(resources, "rstudio.css")),
    injectHighlightHandler()
  )
}

highlightCode <- function(session, id) {
  session$sendCustomMessage("highlight-code", list(id = id))
}

rCodeContainer <- function(...) {
  code <- HTML(as.character(tags$code(class = "language-r", ...)))
  div(pre(code))
}

renderCode <- function(expr, env = parent.frame(), quoted = FALSE) {
  func <- NULL
  installExprFunction(expr, "func", env, quoted)
  markRenderFunction(textOutput, function() {
    paste(func(), collapse = "\n")
  })
}




# Flags for multi.js and picker ----

# Countries
countries <- list(
  "France", "United Kingdom", "Germany", "United States of America", "Belgium", "China", "Spain", "Netherlands", "Mexico",
  "Italy", "Canada", "Brazil", "Denmark", "Norway", "Switzerland", "Luxembourg", "Israel", "Russian Federation",
  "Turkey", "Saudi Arabia", "United Arab Emirates"
)
flags <- c("fr", "gb", "de", "us", "be", "cn", "es", "nl", "mx", "it", "ca", "br", "dk", "no", "ch", "lu", "il", "ru", "tr", "sa", "ae")
flags <- sprintf("https://cdn.rawgit.com/lipis/flag-icon-css/master/flags/4x3/%s.svg", flags)




# Code dropdown -----------------------------------------------------------

code_dropdownButton <- readLines(con = system.file('examples/shinyWidgets/code_dropdownButton.R', package='shinyWidgets', mustWork=TRUE))
code_dropdownButton <- paste(code_dropdownButton, collapse = "\n")

code_dropdown <- readLines(con = system.file('examples/shinyWidgets/code_dropdown.R', package='shinyWidgets', mustWork=TRUE))
code_dropdown <- paste(code_dropdown, collapse = "\n")

