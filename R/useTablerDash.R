
#' @title Use 'tablerDash' in 'shiny'
#'
#' @description Allow to use functions from 'tablerDash'
#'  (\url{https://github.com/RinteRface/tablerDash})
#'  into a classic 'shiny' app.
#'
#' @export
#'
#' @importFrom htmltools findDependencies attachDependencies
#'
#' @example examples/useTablerDash.R
useTablerDash <- function() {
  if (!requireNamespace(package = "tablerDash"))
    message("Package 'tablerDash' is required to run this function")
  deps <- findDependencies(
    tablerDash::tablerDashPage(
      navbar = tablerDash::tablerDashNav(),
      footer = tablerDash::tablerDashFooter(),
      title = "tablerDash",
      body = tablerDash::tablerDashBody()
    )
  )
  attachDependencies(tags$div(), value = deps)
}
