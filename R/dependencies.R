
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
attachShinyWidgetsDep <- function(tag, widget = NULL, extra_deps = NULL) {
  dependencies <- html_dependency_shinyWidgets()
  if (!is.null(widget)) {
    if (widget == "picker") {
      dependencies <- list(
        dependencies,
        # htmltools::htmlDependencies(shiny::fluidPage())[[1]],
        html_dependency_picker()
      )
    } else if (widget == "awesome") {
      dependencies <- list(
        dependencies,
        html_dependency_awesome(),
        htmltools::findDependencies(shiny::icon("rebel"))[[1]]
      )
    } else if (widget == "bsswitch") {
      dependencies <- c(
        list(dependencies),
        html_dependency_bsswitch()
      )
    } else if (widget == "multi") {
      dependencies <- list(
        dependencies,
        html_dependency_multi()
      )
    } else if (widget == "jquery-knob") {
      dependencies <- list(
        dependencies,
        html_dependency_knob()
      )
    } else if (widget == "dropdown") {
      dependencies <- list(
        dependencies,
        htmltools::htmlDependency(
          name = "dropdown-patch",
          version = packageVersion("shinyWidgets"),
          src = c(href = "shinyWidgets/dropdown"),
          script = "dropdown-click.js"
        )
      )
    } else if (widget == "sw-dropdown") {
      dependencies <- list(
        dependencies,
        htmltools::htmlDependency(
          name = "sw-dropdown",
          version = packageVersion("shinyWidgets"),
          src = c(href = "shinyWidgets/sw-dropdown"),
          script = "sw-dropdown.js",
          stylesheet = "sw-dropdown.css"
        )
      )
    } else if (widget == "animate") {
      dependencies <- list(
        dependencies,
        html_dependency_animate()
      )
    } else if (widget == "bttn") {
      dependencies <- list(
        dependencies,
        html_dependency_bttn()
      )
    } else if (widget == "spectrum") {
      dependencies <- list(
        dependencies,
        html_dependency_spectrum()
      )
    } else if (widget == "pretty") {
      dependencies <- list(
        dependencies,
        html_dependency_pretty()
      )
    } else if (widget == "nouislider") {
      dependencies <- list(
        dependencies,
        html_dependency_nouislider()
      )
    } else if (widget == "airdatepicker") {
      dependencies <- list(
        dependencies,
        html_dependency_airdatepicker()
      )
    }
    dependencies <- c(dependencies, extra_deps)
  } else {
    dependencies <- c(list(dependencies), extra_deps)
  }
  htmltools::attachDependencies(
    x = tag,
    value = dependencies,
    append = TRUE
  )
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
#' @importFrom bslib bs_dependency is_bs_theme theme_version
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
  if (identical(bslib::theme_version(theme), "3")) {
    sass_vars <- list(
      "fa-var-check" = "\"\\f00c\"",
      "input-bg-disabled" = "$gray",
      "brand-primary" = "$brand-primary",
      "brand-info" = "$brand-info",
      "brand-success" = "$brand-success",
      "brand-warning" = "$brand-warning",
      "brand-danger" = "$brand-danger",
      "awesome-label-inline-margin-left" = "10px"
    )
  } else {
    sass_vars <- list(
      "fa-var-check" = "\"\\f00c\"",
      "input-bg-disabled" = "$gray-300",
      "brand-primary" = "$primary",
      "brand-info" = "$info",
      "brand-success" = "$success",
      "brand-warning" = "$warning",
      "brand-danger" = "$danger",
      "awesome-label-inline-margin-left" = "10px"
    )
  }
  sass_input <- list(
    sass_vars,
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
#' @importFrom bslib bs_dependency is_bs_theme theme_version
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

  if (identical(bslib::theme_version(theme), "3")) {
    sass_vars <- list(
      "pretty--color-primary" = "$brand-primary",
      "pretty--color-info" = "$brand-info",
      "pretty--color-success" = "$brand-success",
      "pretty--color-warning" = "$brand-warning",
      "pretty--color-danger" = "$brand-danger"
    )
  } else {
    sass_vars <- list(
      "pretty--color-primary" = "$primary",
      "pretty--color-info" = "$info",
      "pretty--color-success" = "$success",
      "pretty--color-warning" = "$warning",
      "pretty--color-danger" = "$danger"
    )
  }
  sass_input <- list(
    sass_vars,
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
  list(
    bslib::bs_dependency_defer(bsswitchDependencyCSS),
    htmlDependency(
      name = "bootstrap-switch-js",
      version = "3.3.4",
      package = "shinyWidgets",
      src = c(href = "shinyWidgets/bootstrap-switch", file = "assets/bootstrap-switch"),
      script = "bootstrap-switch-3.3.4/bootstrap-switch.min.js"
    )
  )
}

bsswitchDependencyCSS <- function(theme) {
  if (!bslib::is_bs_theme(theme)) {
    return(htmlDependency(
      name = "bootstrap-switch-css",
      version = "3.3.4",
      package = "shinyWidgets",
      src = c(href = "shinyWidgets/bootstrap-switch", file = "assets/bootstrap-switch"),
      script = "bootstrap-switch-3.3.4/bootstrap-switch.min.js",
      stylesheet = "bootstrap-switch-3.4/bootstrap-switch.min.css"
    ))
  }

  if (identical(bslib::theme_version(theme), "3")) {
    sass_vars <- list(
      "primary" = "$brand-primary",
      "info" = "$brand-info",
      "success" = "$brand-success",
      "warning" = "$brand-warning",
      "danger" = "$brand-danger",
      "secondary" = "$gray-base"
    )
  } else {
    sass_vars <- list()
  }
  sass_input <- list(
    sass_vars,
    sass::sass_file(
      system.file(package = "shinyWidgets", "assets/bootstrap-switch/bootstrap-switch-3.4/bootstrap-switch.scss")
    )
  )

  bslib::bs_dependency(
    input = sass_input,
    theme = theme,
    name = "bootstrap-switch-css",
    version = "3.4",
    cache_key_extra = packageVersion("shinyWidgets")
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
  htmlDependency(
    name = "sweetalert2",
    version = "11.7.11",
    src = c(href="shinyWidgets/sweetalert2", file = "assets/sweetalert2"),
    script = c("js/sweetalert2.min.js", "sweetalert-bindings.js"),
    stylesheet = sprintf("css/%s.min.css", theme)
  )
}



# Non exported ------------------------------------------------------------

html_dependency_picker_bs <- function(theme) {
  if (identical(bslib::theme_version(theme), "5")) {
    htmlDependency(
      name = "bootstrap-select",
      version = "1.14.0-3",
      package = "shinyWidgets",
      src = c(href = "shinyWidgets/bootstrap-select-1.14.0-beta2", file = "assets/bootstrap-select-1.14.0-beta2"),
      script = c("js/bootstrap-select.min.js"),
      stylesheet = c("css/bootstrap-select.min.css")
    )
  } else {
    htmlDependency(
      name = "bootstrap-select",
      version = "1.13.8",
      package = "shinyWidgets",
      src = c(href = "shinyWidgets/bootstrap-select", file = "assets/bootstrap-select"),
      script = c("js/bootstrap-select.min.js"),
      stylesheet = c("css/bootstrap-select.min.css")
    )
  }
}
html_dependency_picker <- function() {
  bslib::bs_dependency_defer(html_dependency_picker_bs)
}

html_dependency_airdatepicker <- function() {
  version <- getOption("air-datepicker", default = 3)
  if (version < 3) {
    htmlDependency(
      name = "air-datepicker",
      version = "2.2.3",
      package = "shinyWidgets",
      src = c(href = "shinyWidgets/air-datepicker2", file = "assets/air-datepicker2"),
      script = c("datepicker.min.js", "datepicker-bindings.js"),
      stylesheet = c("datepicker.min.css", "airdatepicker-custom.css")
    )
  } else {
    htmlDependency(
      name = "air-datepicker",
      version = "3.2.0",
      src = c(file = system.file("packer", package = "shinyWidgets")),
      script = "air-datepicker.js"
    )
  }
}

html_dependency_nouislider <- function() {
  htmlDependency(
    name = "nouislider",
    version = "15.6.1",
    src = c(file = system.file("packer", package = "shinyWidgets")),
    script = "nouislider.js"
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
  # htmlDependency(
  #   name = "multi",
  #   version = "0.5.0",
  #   src = c(file = system.file("packer", package = "shinyWidgets")),
  #   script = "multi.js"
  # )
  htmlDependency(
    name = "multi",
    version = "0.5.0",
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
    src = c(file = system.file("packer", package = "shinyWidgets")),
    script = "autonumeric.js"
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


html_dependency_stati <- function() {
  htmlDependency(
    name = "stati",
    version = packageVersion("shinyWidgets"),
    package = "shinyWidgets",
    src = c(href = "shinyWidgets/stati", file = "assets/stati"),
    script = c("bounty.js", "stati.js"),
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
