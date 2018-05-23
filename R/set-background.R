#' Custom background color for your shinyapp
#'
#' Allow to change the background color of your shinyapp.
#'
#' @param color Background color. Use either the fullname or the Hex code
#' (\url{https://www.w3schools.com/colors/colors_hex.asp}).
#'
#' @export
#'
#' @examples
#' \dontrun{
#'
#' if (interactive()) {
#'
#' library(shiny)
#'
#' ui <- fluidPage(
#'   tags$h2("Change shiny app background"),
#'   setBackgroundColor("ghostwhite")
#' )
#'
#' server <- function(input, output, session) {
#'
#' }
#'
#' shinyApp(ui, server)
#'
#' }
#'
#' }
setBackgroundColor <- function(color = "ghostwhite") {
  htmltools::tags$head(
    htmltools::tags$style(
      htmltools::HTML(
        paste0(
          'body {
            background-color:
          ', color, ';}'
        )
      )
    )
  )
}


#' Custom background image for your shinyapp
#'
#' Allow to change the background image of your shinyapp.
#'
#' @param src Background url or path.
#'
#' @note Use with moderation. The image while cover the entire screen (no repeat, cover).
#'
#' @export
#'
#' @examples
#' \dontrun{
#'
#' if (interactive()) {
#'
#' library(shiny)
#'
#' ui <- fluidPage(
#'   tags$h2("Add a shiny app background image"),
#'   setBackgroundImage(src = "http://wallpics4k.com/wp-content/uploads/2014/07/470318.jpg")
#' )
#'
#' server <- function(input, output, session) {
#'
#' }
#'
#' shinyApp(ui, server)
#'
#' }
#'
#' }
setBackgroundImage <- function(src = NULL) {
  htmltools::tags$head(
    htmltools::tags$style(
      htmltools::HTML(
        paste0(
          'body {
           background-image: url(', src, ');
           background-repeat: no-repeat;
           background-size: cover;
          }'
        )
      )
    )
  )
}
