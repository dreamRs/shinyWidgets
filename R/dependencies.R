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
        html_dependency_picker()
      )
    } else if (widget == "awesome") {
      dep <- list(
        dep,
        html_dependency_awsome(),
        htmltools::findDependencies(shiny::icon("rebel"))[[1]]
      )
    } else if (widget == "bsswitch") {
      dep <- list(
        dep,
        html_dependency_bsswitch()
      )
    } else if (widget == "multi") {
      dep <- list(
        dep,
        html_dependency_multi()
      )
    } else if (widget == "jquery-knob") {
      dep <- list(
        dep,
        html_dependency_knob()
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
        html_dependency_animate()
      )
    } else if (widget == "bttn") {
      dep <- list(
        dep,
        html_dependency_bttn()
      )
    } else if (widget == "spectrum") {
      dep <- list(
        dep,
        html_dependency_spectrum()
      )
    } else if (widget == "pretty") {
      dep <- list(
        dep,
        html_dependency_pretty()
      )
    } else if (widget == "nouislider") {
      dep <- list(
        dep,
        html_dependency_nouislider()
      )
    } else if (widget == "airdatepicker") {
      dep <- list(
        dep,
        html_dependency_airdatepicker()
      )
    }
  }
  htmltools::attachDependencies(tag, dep, append = TRUE)
}



# Exported ----------------------------------------------------------------



html_dependency_awsome <- function() {
  htmltools::htmlDependency(
    name = "awesome-bootstrap",
    version = "0.3.7",
    src = c(
      href = "shinyWidgets/awesome-bootstrap-checkbox",
      file = "awesome-bootstrap-checkbox"
    ),
    package = "shinyWidgets",
    stylesheet = "awesome-bootstrap-checkbox.min.css",
    all_files = FALSE
  )
}

html_dependency_bttn <- function() {
  htmltools::htmlDependency(
    name = "bttn",
    version = "0.2.4",
    src = c(href = "shinyWidgets/bttn", file = "bttn"),
    package = "shinyWidgets",
    stylesheet = "bttn.min.css"
  )
}

html_dependency_pretty <- function() {
  htmltools::htmlDependency(
    name = "pretty",
    version = "3.0.3",
    src = c(href = "shinyWidgets/pretty-checkbox", file = "pretty-checkbox"),
    package = "shinyWidgets",
    stylesheet = "pretty-checkbox.min.css"
  )
}



# Non exported ------------------------------------------------------------


html_dependency_bsswitch <- function() {
  htmltools::htmlDependency(
    name = "bootstrap-switch",
    version = "3.3.4",
    package = "shinyWidgets",
    src = c(href = "shinyWidgets/bootstrap-switch/", file = "bootstrap-switch"),
    script = "bootstrap-switch-3.3.4/bootstrap-switch.min.js",
    stylesheet = "bootstrap-switch-3.3.4/bootstrap-switch.min.css"
  )
}


html_dependency_picker <- function() {
  htmltools::htmlDependency(
    name = "selectPicker",
    version = "1.13.12",
    package = "shinyWidgets",
    src = c(href = "shinyWidgets/selectPicker", file = "assets"),
    script = "js/bootstrap-select.min.js",
    stylesheet = "css/bootstrap-select.min.css"
  )
}

html_dependency_airdatepicker <- function() {
  htmltools::htmlDependency(
    name = "air-datepicker",
    version = "2.2.3",
    package = "shinyWidgets",
    src = c(href = "shinyWidgets/air-datepicker2", file = "air-datepicker2"),
    script = "datepicker.min.js",
    stylesheet = "datepicker.min.css"
  )
}

html_dependency_nouislider <- function() {
  htmltools::htmlDependency(
    name = "nouislider",
    version = "11.0.3",
    package = "shinyWidgets",
    src = c(href = "shinyWidgets/nouislider", file = "nouislider"),
    script = c("nouislider.min.js", "wNumb.js"),
    stylesheet = "nouislider.min.css"
  )
}

html_dependency_spectrum <- function() {
  htmltools::htmlDependency(
    name = "spectrum",
    version = "1.8.0",
    package = "shinyWidgets",
    src = c(href = "shinyWidgets/spectrum", file = "spectrum"),
    script = c("spectrum.min.js"),
    stylesheet = c("spectrum.min.css", "sw-spectrum.css")
  )
}

html_dependency_animate <- function() {
  htmltools::htmlDependency(
    name = "animate",
    version = "3.5.2",
    package = "shinyWidgets",
    src = c(href = "shinyWidgets/animate", file = "animate"),
    stylesheet = "animate.min.css"
  )
}

html_dependency_knob <- function() {
  htmltools::htmlDependency(
    name = "jquery-knob",
    version = "1.2.13",
    package = "shinyWidgets",
    src = c(href = "shinyWidgets/jquery-knob", file = "jquery-knob"),
    script = c("jquery.knob.min.js")
  )
}

html_dependency_multi <- function() {
  htmltools::htmlDependency(
    name = "multi",
    version = "1.4.0",
    package = "shinyWidgets",
    src = c(href = "shinyWidgets/multi", file = "multi"),
    script = "multi.min.js",
    stylesheet = c("multi.min.css")
  )
}


