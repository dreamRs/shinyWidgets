
#' Deprecated function
#'
#' Those functions are deprecated and will be removed in a futur release of shinyWidgets
#'
#' @name deprecated
#'
NULL


#'
#' @export
#' @rdname deprecated
#'
useShinydashboard <- function() {
  .Deprecated(
    msg = paste(
      "useShinydashboard has been deprecated and will be removed in a future release of shinyWidgets.",
      "If you want to create value box in shiny, see package bslib.",
      "If you absolutely need to use this function, copy the source code into your project",
      "https://github.com/dreamRs/shinyWidgets/blob/26838f9e9ccdc90a47178b45318d110f5812d6e1/R/useShinydashboard.R"
    )
  )
  if (!requireNamespace(package = "shinydashboard"))
    message("Package 'shinydashboard' is required to run this function")
  deps <- findDependencies(shinydashboard::dashboardPage(
    header = shinydashboard::dashboardHeader(),
    sidebar = shinydashboard::dashboardSidebar(),
    body = shinydashboard::dashboardBody()
  ))
  attachDependencies(tags$div(class = "main-sidebar", style = "display: none;"), value = deps)
}


#' @export
#' @rdname deprecated
#'
useShinydashboardPlus <- function() {
  .Deprecated(
    msg = paste(
      "useShinydashboardPlus has been deprecated and will be removed in a future release of shinyWidgets.",
      "If you want to create value box in shiny, see package bslib.",
      "If you absolutely need to use this function, copy the source code into your project",
      "https://github.com/dreamRs/shinyWidgets/blob/26838f9e9ccdc90a47178b45318d110f5812d6e1/R/useShinydashboardPlus.R"
    )
  )
  if (!requireNamespace(package = "shinydashboardPlus"))
    message("Package 'shinydashboardPlus' is required to run this function")
  deps <- findDependencies(shinydashboardPlus::dashboardPage(
    header = shinydashboardPlus::dashboardHeader(),
    sidebar = shinydashboard::dashboardSidebar(),
    body = shinydashboard::dashboardBody()
  ))
  attachDependencies(tags$div(class = "main-sidebar", style = "display: none;"), value = deps)
}


#'
#' @export
#' @rdname deprecated
#'
useTablerDash <- function() {
  .Deprecated(
    msg = paste(
      "useTablerDash has been deprecated and will be removed in a future release of shinyWidgets.",
      "If you absolutely need to use this function, copy the source code into your project",
      "https://github.com/dreamRs/shinyWidgets/blob/26838f9e9ccdc90a47178b45318d110f5812d6e1/R/useTablerDash.R"
    )
  )
}

#'
#' @export
#' @rdname deprecated
#'
useArgonDash <- function() {
  .Deprecated(
    msg = paste(
      "useArgonDash has been deprecated and will be removed in a future release of shinyWidgets.",
      "If you absolutely need to use this function, copy the source code into your project",
      "https://github.com/dreamRs/shinyWidgets/blob/26838f9e9ccdc90a47178b45318d110f5812d6e1/R/useArgonDash.R"
    )
  )
}

#' @param ... Deprecated arguments
#'
#' @export
#' @rdname deprecated
#'
useBs4Dash <- function(...) {
  .Deprecated(
    msg = paste(
      "useBs4Dash has been deprecated and will be removed in a future release of shinyWidgets.",
      "If you absolutely need to use this function, copy the source code into your project",
      "https://github.com/dreamRs/shinyWidgets/blob/26838f9e9ccdc90a47178b45318d110f5812d6e1/R/useBs4Dash.R"
    )
  )
}

#' @param id,class Deprecated arguments
#'
#' @export
#' @rdname deprecated
#'
setShadow <- function(id = NULL, class = NULL) {
  .Deprecated(
    msg = paste(
      "setShadow has been deprecated and will be removed in a future release of shinyWidgets.",
      "If you absolutely need to use this function, copy the source code into your project",
      "https://github.com/dreamRs/shinyWidgets/blob/26838f9e9ccdc90a47178b45318d110f5812d6e1/R/setShadow.R"
    )
  )
}


#' @param color,sliderId Deprecated arguments
#'
#' @export
#' @rdname deprecated
#'
setSliderColor <- function(color, sliderId) {
  .Deprecated(
    msg = paste(
      "setSliderColor has been deprecated and will be removed in a future release of shinyWidgets.",
      "If you absolutely need to use this function, copy the source code into your project",
      "https://github.com/dreamRs/shinyWidgets/blob/26838f9e9ccdc90a47178b45318d110f5812d6e1/R/setSliderColor.R"
    )
  )
}
