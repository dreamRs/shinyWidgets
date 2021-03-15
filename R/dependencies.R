
#' Attach shinyWidgets dependencies
#'
#' @param tag An object which has (or should have) HTML dependencies.
#' @param widget Name of a widget for specific dependency.
#'
#' @noRd
#' @importFrom utils packageVersion
#' @importFrom htmltools htmlDependency attachDependencies findDependencies
#' @importFrom shiny icon
#'
attachShinyWidgetsDep <- function(tag, widget = NULL) {
  dep <- html_dependency_shinyWidgets()
  if (!is.null(widget)) {
    if (widget == "picker") {
      dep <- list(
        dep,
        html_dependency_picker()
      )
    } else if (widget == "awesome") {
      dep <- list(
        dep,
        html_dependency_awesome(),
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
          version = packageVersion("shinyWidgets"),
          src = c(href = "shinyWidgets/dropdown"),
          script = "dropdown-click.js"
        )
      )
    } else if (widget == "sw-dropdown") {
      dep <- list(
        dep,
        htmltools::htmlDependency(
          name = "sw-dropdown",
          version = packageVersion("shinyWidgets"),
          src = c(href = "shinyWidgets/sw-dropdown"),
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


html_dependency_shinyWidgets <- function() {
  htmltools::htmlDependency(
    name = "shinyWidgets",
    version = packageVersion("shinyWidgets"),
    src = c(href = "shinyWidgets", file = "assets"),
    package = "shinyWidgets",
    script = "shinyWidgets-bindings.min.js",
    stylesheet = "shinyWidgets.min.css",
    all_files = FALSE
  )
}


# Exported ----------------------------------------------------------------



#' @title HTML dependencies
#'
#' @description These functions are used internally to load dependencies for widgets.
#'  Not all of them are exported. Below are the ones needed for package \href{https://github.com/dreamRs/fresh}{fresh}.
#'
#' @return an \code{\link[htmltools]{htmlDependency}}.
#' @export
#'
#' @importFrom htmltools htmlDependency
#'
#' @name html-dependencies
#'
#' @examples
#'
#' # Use in UI or tags function
#'
#' library(shiny)
#' fluidPage(
#'   html_dependency_awesome()
#' )
#'
html_dependency_awesome <- function() {
  bslib::bs_dependency_defer(awesomeDependencyCSS)
}

#' @importFrom sass sass_file
#' @importFrom bslib bs_dependency
awesomeDependencyCSS <- function(theme) {
  if (!bslib::is_bs_theme(theme)) {
    return(htmlDependency(
      name = "awesome-bootstrap",
      version = "0.3.7",
      src = c(
        href = "shinyWidgets/awesome-bootstrap-checkbox",
        file = "assets/awesome-bootstrap-checkbox"
      ),
      package = "shinyWidgets",
      stylesheet = "awesome-bootstrap-checkbox.min.css",
      all_files = FALSE
    ))
  }

  sass_input <- list(
    list(
      "fa-var-check" = "\"\\f00c\"",
      "input-bg-disabled" = "$gray-300",
      "brand-primary" = "$primary",
      "brand-info" = "$info",
      "brand-success" = "$success",
      "brand-warning" = "$warning",
      "brand-danger" = "$danger",
      "awesome-label-inline-margin-left" = "10px"
    ),
    # sass::sass_file(
    #   system.file(package = "shinyWidgets", "assets/awesome-bootstrap-checkbox/_variables.scss")
    # ),
    sass::sass_file(
      system.file(package = "shinyWidgets", "assets/awesome-bootstrap-checkbox/_mixins.scss")
    ),
    sass::sass_file(
      system.file(package = "shinyWidgets", "assets/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.scss")
    )
  )

  bslib::bs_dependency(
    input = sass_input,
    theme = theme,
    name = "awesome-bootstrap",
    version = "0.3.7",
    cache_key_extra = packageVersion("shinyWidgets")
  )
}



#' @export
#' @rdname html-dependencies
html_dependency_bttn <- function() {
  htmlDependency(
    name = "bttn",
    version = "0.2.4",
    src = c(href = "shinyWidgets/bttn", file = "assets/bttn"),
    package = "shinyWidgets",
    stylesheet = "bttn.min.css"
  )
}

#' @export
#' @rdname html-dependencies
#' @importFrom bslib bs_dependency_defer
html_dependency_pretty <- function() {
  bslib::bs_dependency_defer(prettyDependencyCSS)
}

#' @importFrom sass sass_file
#' @importFrom bslib bs_dependency
prettyDependencyCSS <- function(theme) {
  if (!bslib::is_bs_theme(theme)) {
    return(htmlDependency(
      name = "pretty",
      version = "3.0.3",
      src = c(href = "shinyWidgets/pretty-checkbox", file = "assets/pretty-checkbox"),
      package = "shinyWidgets",
      stylesheet = "pretty-checkbox.min.css"
    ))
  }

  sass_input <- list(
    list(
      "pretty--color-primary" = "$primary",
      "pretty--color-info" = "$info",
      "pretty--color-success" = "$success",
      "pretty--color-warning" = "$warning",
      "pretty--color-danger" = "$danger"
    ),
    sass::sass_file(
      system.file(package = "shinyWidgets", "assets/pretty-checkbox/pretty-checkbox.scss")
    )
  )

  bslib::bs_dependency(
    input = sass_input,
    theme = theme,
    name = "pretty",
    version = "3.0.3",
    cache_key_extra = packageVersion("shinyWidgets")
  )
}


#' @export
#' @rdname html-dependencies
html_dependency_bsswitch <- function() {
  htmlDependency(
    name = "bootstrap-switch",
    version = "3.3.4",
    package = "shinyWidgets",
    src = c(href = "shinyWidgets/bootstrap-switch", file = "assets/bootstrap-switch"),
    script = "bootstrap-switch-3.3.4/bootstrap-switch.min.js",
    stylesheet = "bootstrap-switch-3.3.4/bootstrap-switch.min.css"
  )
}


#' @param theme SweetAlert theme to use.
#' @export
#' @rdname html-dependencies
html_dependency_sweetalert2 <- function(theme = c("sweetalert2",
                                                  "minimal",
                                                  "dark",
                                                  "bootstrap-4",
                                                  "material-ui",
                                                  "bulma",
                                                  "borderless")) {
  theme <- match.arg(theme)
  if (identical(theme, "sweetalert2"))
    theme <- "default"
  htmlDependency(
    name = "sweetalert2",
    version = "9.17.1",
    src = c(href="shinyWidgets/sweetalert2", file = "assets/sweetalert2"),
    script = c("js/sweetalert2.min.js", "sweetalert-bindings.js"),
    stylesheet = sprintf("css/%s.min.css", theme)
  )
}



# Non exported ------------------------------------------------------------


html_dependency_picker <- function() {
  htmlDependency(
    name = "bootstrap-select",
    version = "1.13.18",
    package = "shinyWidgets",
    src = c(href = "shinyWidgets/bootstrap-select", file = "assets/bootstrap-select"),
    script = c("js/bootstrap-select.min.js"),
    stylesheet = c("css/bootstrap-select.min.css")
  )
}

html_dependency_airdatepicker <- function() {
  htmlDependency(
    name = "air-datepicker",
    version = "2.2.3",
    package = "shinyWidgets",
    src = c(href = "shinyWidgets/air-datepicker2", file = "assets/air-datepicker2"),
    script = "datepicker.min.js",
    stylesheet = c("datepicker.min.css", "airdatepicker-custom.css")
  )
}

html_dependency_nouislider <- function() {
  htmlDependency(
    name = "nouislider",
    version = "11.0.3",
    package = "shinyWidgets",
    src = c(href = "shinyWidgets/nouislider", file = "assets/nouislider"),
    script = c("nouislider.min.js", "wNumb.js"),
    stylesheet = "nouislider.min.css"
  )
}

html_dependency_spectrum <- function() {
  htmlDependency(
    name = "spectrum",
    version = "1.8.1",
    package = "shinyWidgets",
    src = c(href = "shinyWidgets/spectrum", file = "assets/spectrum"),
    script = c("spectrum.min.js"),
    stylesheet = c("spectrum.min.css", "sw-spectrum.css")
  )
}

html_dependency_animate <- function() {
  htmlDependency(
    name = "animate",
    version = "3.5.2",
    package = "shinyWidgets",
    src = c(href = "shinyWidgets/animate", file = "assets/animate"),
    stylesheet = "animate.min.css"
  )
}

html_dependency_knob <- function() {
  htmlDependency(
    name = "jquery-knob",
    version = "1.2.13",
    package = "shinyWidgets",
    src = c(href = "shinyWidgets/jquery-knob", file = "assets/jquery-knob"),
    script = c("jquery.knob.min.js")
  )
}

html_dependency_multi <- function() {
  htmlDependency(
    name = "multi",
    version = "1.4.0",
    package = "shinyWidgets",
    src = c(href = "shinyWidgets/multi", file = "assets/multi"),
    script = "multi.min.js",
    stylesheet = c("multi.min.css")
  )
}

html_dependency_autonumeric <- function() {
  htmlDependency(
    name = "autonumeric",
    version = "4.6.0",
    package = "shinyWidgets",
    src = c(href = "shinyWidgets/autonumeric", file = "assets/autonumeric"),
    script = "autoNumeric.min.js"
  )
}

html_dependency_polyfill_promise <- function() {
  htmlDependency(
    name = "promise-polyfill",
    version = "7.1.0",
    src = c(href="shinyWidgets/sweetalert2", file = "assets/sweetalert2"),
    script = "js/promise.min.js"
  )
}

html_dependency_bounty <- function() {
  htmlDependency(
    name = "bounty",
    version = "1.3.0",
    package = "shinyWidgets",
    src = c(href = "shinyWidgets/bounty", file = "assets/bounty"),
    script = c("bounty.js", "bounty-wrapper.js")
  )
}


html_dependency_stati <- function() {
  htmlDependency(
    name = "stati",
    version = packageVersion("shinyWidgets"),
    package = "shinyWidgets",
    src = c(href = "shinyWidgets/stati", file = "assets/stati"),
    stylesheet = "stati.css"
  )
}


html_dependency_pickr <- function() {
  htmlDependency(
    name = "pickr",
    version = "1.6.0",
    src = list(href = "shinyWidgets/pickr-1.6.0", file = "assets/pickr-1.6.0"),
    package = "shinyWidgets",
    script = "js/pickr.min.js",
    stylesheet = c(
      "css/classic.min.css",
      "css/monolith.min.css",
      "css/nano.min.css"
    ),
    head = "<style>.pickr-color.disabled{cursor:not-allowed;}</style>",
    all_files = FALSE
  )
}
