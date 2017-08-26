#' @title Awesome action button
#'
#' @description Like actionButton but awesome, via \url{https://bttn.surge.sh/}
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label The contents of the button, usually a text label.
#' @param icon An optional icon to appear on the button.
#' @param style Style of the button, to choose between \code{simple}, \code{bordered},
#' \code{minimal}, \code{stretch}, \code{jelly}, \code{gradient}, \code{fill},
#' \code{material-circle}, \code{material-flat}, \code{pill}, \code{float}, \code{unite}.
#' @param color Color of the button : \code{default}, \code{primary}, \code{warning},
#'  \code{danger}, \code{success}, \code{royal}.
#' @param size Size of the button : \code{xs},\code{sm}, \code{md}, \code{lg}.
#' @param block Logical, full width button.
#' @param no_outline Logical, don't show outline when navigating with
#'  keyboard/interact using mouse or touch.
#'
#' @export
#'
#' @importFrom shiny restoreInput
#' @importFrom htmltools tags
#'
#' @examples
#' \dontrun{
#' if (interactive()) {
#'
#'  ui <- fluidPage(
#'   actionBttn(inputId = "id1", label = "Go!", style = "unite")
#'  )
#'
#'  server <- function(input, output, session) {
#'
#'  }
#'
#'  shinyApp(ui = ui, server = server)
#'
#' }
#' }
actionBttn <- function(inputId, label = NULL, icon = NULL, style = "unite",
                       color = "default", size = "md", block = FALSE,
                       no_outline = TRUE) {
  value <- shiny::restoreInput(id = inputId, default = NULL)
  style <- match.arg(
    arg = style,
    choices = c("simple", "bordered", "minimal", "stretch", "jelly",
                "gradient", "fill", "material-circle", "material-flat",
                "pill", "float", "unite")
  )
  color <- match.arg(
    arg = color,
    choices = c("default", "primary", "warning", "danger", "success", "royal")
  )
  size <- match.arg(arg = size, choices = c("xs", "sm", "md", "lg"))

  tagBttn <- htmltools::tags$button(
    id = inputId, type = "button", class = "action-button", `data-val` = value,
    class = paste0("bttn-", style), class = paste0("bttn-", size),
    class = paste0("bttn-", color), list(icon, label),
    class = if (block) "bttn-block",
    class = if (no_outline) "bttn-no-outline"
  )
  attachShinyWidgetsDep(tagBttn, "bttn")
}
