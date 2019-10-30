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
          version = "1.13.12",
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
          src = c(href="shinyWidgets/bootstrap-switch/bootstrap-switch-3.3.4"),
          script = "bootstrap-switch.min.js",
          stylesheet = "bootstrap-switch.min.css"
        )
      )
    } else if (widget == "multi") {
      dep <- list(
        dep,
        htmltools::htmlDependency(
          name = "multi",
          version = "1.4.0",
          src = c(href="shinyWidgets/multi"),
          script = "multi.min.js",
          stylesheet = c("multi.min.css")
        )
      )
    } else if (widget == "jquery-knob") {
      dep <- list(
        dep,
        htmltools::htmlDependency(
          name = "jquery-knob", version = "1.2.13",
          src = c(href = "shinyWidgets/jquery-knob"),
          script = c("jquery.knob.min.js")
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
    } else if (widget == "spectrum") {
      dep <- list(
        dep,
        htmltools::htmlDependency(
          name = "spectrum",
          version = version,
          src = c(href="shinyWidgets/spectrum"),
          script = c("spectrum.min.js"),
          stylesheet = c("spectrum.min.css", "sw-spectrum.css")
        )
      )
    } else if (widget == "pretty") {
      dep <- list(
        dep,
        htmltools::htmlDependency(
          name = "pretty",
          version = "3.0.3",
          src = c(href="shinyWidgets/pretty-checkbox"),
          stylesheet = "pretty-checkbox.min.css"
        )
      )
    } else if (widget == "nouislider") {
      dep <- list(
        dep,
        htmltools::htmlDependency(
          name = "nouislider",
          version = "11.0.3",
          src = c(href="shinyWidgets/nouislider"),
          script = c("nouislider.min.js", "wNumb.js"),
          stylesheet = "nouislider.min.css"
        )
      )
    } else if (widget == "airdatepicker") {
      dep <- list(
        dep,
        htmltools::htmlDependency(
          name = "air-datepicker",
          version = "2.2.3",
          src = c(href="shinyWidgets/air-datepicker"),
          script = "datepicker.min.js",
          stylesheet = "datepicker.min.css"
        )
      )
    }
  }
  htmltools::attachDependencies(tag, dep, append = TRUE)
}

