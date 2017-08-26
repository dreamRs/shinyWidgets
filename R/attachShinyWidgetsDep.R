#' Attach shinyWidgets dependancies
#'
#' @param tag An object which has (or should have) HTML dependencies.
#' @param widget Name of a widget for particular dependancies
#'
#' @noRd
#' @importFrom utils packageVersion
#' @importFrom htmltools htmlDependency attachDependencies findDependencies
#' @importFrom shiny icon
#'
attachShinyWidgetsDep <- function(tag, widget = NULL) {
  version <- as.character(packageVersion("shinyWidgets")[[1]])
  dep <- htmltools::htmlDependency(
    name = "shinyWidgets", version = version,
    src = c(href = "shinyWidgets"),
    script = "shinyWidgets-bindings.min.js",
    stylesheet = "shinyWidgets.css"
  )
  if (!is.null(widget)) {
    if (widget == "picker") {
      dep <- list(
        dep,
        htmltools::htmlDependency(
          name = "selectPicker",
          version = "1.12.4",
          src = c(href="shinyWidgets/selectPicker"),
          script = "js/bootstrap-select.min.js",
          stylesheet = "css/bootstrap-select.min.css"
        )
      )
    } else if (widget == "awesome") {
      dep <- list(
        dep,
        htmltools::htmlDependency(
          name = "awesome-bootstrap",
          version = "0.2.0",
          src = c(href = "shinyWidgets/awesomeRadioCheckbox"),
          stylesheet = "css/awesome-bootstrap-checkbox-shiny.css"
        ),
        htmltools::findDependencies(shiny::icon("rebel"))[[1]]
      )
    } else if (widget == "bsswitch") {
      dep <- list(
        dep,
        htmltools::htmlDependency(
          name = "bootstrap-switch",
          version = "3.3.4",
          src = c(href="shinyWidgets/switchInput"),
          script = "js/bootstrap-switch.min.js",
          stylesheet = "css/bootstrap-switch.min.css"
        )
      )
    } else if (widget == "sweetalert") {
      dep <- list(
        dep,
        htmltools::htmlDependency(
          name = "sweetAlert",
          version = "0.1.0",
          src = c(href="shinyWidgets/sweetAlert"),
          script = "js/sweetalert.min.js",
          stylesheet = "css/sweetalert.min.css"
        )
      )
    } else if (widget == "multi") {
      dep <- list(
        dep,
        htmltools::htmlDependency(
          name = "multi",
          version = "0.2.3",
          src = c(href="shinyWidgets/multi"),
          script = "multi.min.js",
          stylesheet = c("multi.min.css", "multi-shiny.css")
        )
      )
    } else if (widget == "dropdown") {
      dep <- list(
        dep,
        htmltools::htmlDependency(
          name = "dropdown-patch",
          version = version,
          src = c(href="shinyWidgets/dropdown"),
          script = "dropdown-click.js"
        )
      )
    } else if (widget == "sw-dropdown") {
      dep <- list(
        dep,
        htmltools::htmlDependency(
          name = "sw-dropdown",
          version = version,
          src = c(href="shinyWidgets/sw-dropdown"),
          script = "sw-dropdown.js",
          stylesheet = "sw-dropdown.css"
        )
      )
    } else if (widget == "animate") {
      dep <- list(
        dep,
        htmltools::htmlDependency(
          name = "animate",
          version = version,
          src = c(href="shinyWidgets/animate"),
          stylesheet = "animate.min.css"
        )
      )
    } else if (widget == "bttn") {
      dep <- list(
        dep,
        htmltools::htmlDependency(
          name = "bttn",
          version = version,
          src = c(href="shinyWidgets/bttn"),
          stylesheet = "bttn.min.css"
        )
      )
    }
  }
  htmltools::attachDependencies(tag, dep, append = TRUE)
}

