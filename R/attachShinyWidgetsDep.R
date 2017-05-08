#' Attach shinyWidgets dependancies
#'
#' @param tag An object which has (or should have) HTML dependencies.
#' @param widget NAme of a widget for particular dependancies
#'
#' @noRd
#'
attachShinyWidgetsDep <- function(tag, widget = NULL) {
  dep <- htmltools::htmlDependency(
    "shinyWidgets", "0.2.0", c(href = "shinyWidgets"),
    script = "shinyWidgets-bindings.min.js",
    stylesheet = "shinyWidgets.css"
  )
  if (!is.null(widget)) {
    if (widget == "picker") {
      dep <- list(
        dep,
        htmltools::htmlDependency(
          "selectPicker", "1.11.0", c(href="shinyWidgets/selectPicker"),
          script = "js/bootstrap-select.min.js",
          stylesheet = "css/bootstrap-select.min.css"
        )
      )
    } else if (widget == "awesome") {
      dep <- list(
        dep,
        htmltools::htmlDependency(
          "awesome-bootstrap",
          "0.2.0", c(href = "shinyWidgets/awesomeRadioCheckbox"), stylesheet = "css/awesome-bootstrap-checkbox-shiny.css"
        ),
        htmltools::htmlDependency(
          "font-awesome",
          "4.6.3", c(href = "shared/font-awesome"), stylesheet = "css/font-awesome.min.css"
        )
      )
    } else if (widget == "bsswitch") {
      dep <- list(
        dep,
        htmltools::htmlDependency(
          "bootstrap-switch", "3.3.2", c(href="shinyWidgets/switchInput"),
          script = "js/bootstrap-switch.min.js",
          stylesheet = "css/bootstrap-switch.min.css"
        )
      )
    } else if (widget == "sweetalert") {
      dep <- list(
        dep,
        htmltools::htmlDependency(
          "sweetAlert", "0.1.0", c(href="shinyWidgets/sweetAlert"),
          script = "js/sweetalert.min.js",
          stylesheet = "css/sweetalert.css"
        )
      )
    }
  }
  htmltools::attachDependencies(tag, dep)
}

