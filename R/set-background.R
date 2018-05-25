#' Custom background color for your shinyapp
#'
#' Allow to change the background color of your shinyapp.
#'
#' @param color Background color. Use either the fullname or the Hex code
#' (\url{https://www.w3schools.com/colors/colors_hex.asp}). If more than one color is used,
#' a gradient background is set.
#' @param gradient Type of gradient: \code{linear} or \code{radial}.
#' @param direction Direction for gradient, by default to \code{bottom}.
#' Possibles choices are \code{bottom}, \code{top}, \code{right} or
#' \code{left}, two values can be used, e.g. \code{c("bottom", "right")}.
#'
#'
#'
#' @export
#'
#' @examples
#' \dontrun{
#'
#' if (interactive()) {
#'
#' ### Uniform color background :
#'
#' library(shiny)
#' library(shinyWidgets)
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
#'
#' ### linear gradient background :
#'
#' library(shiny)
#' library(shinyWidgets)
#'
#' ui <- fluidPage(
#'
#'   # use a gradient in background
#'   setBackgroundColor(
#'     color = c("#F7FBFF", "#2171B5"),
#'     gradient = "linear",
#'     direction = "bottom"
#'   ),
#'
#'   titlePanel("Hello Shiny!"),
#'   sidebarLayout(
#'     sidebarPanel(
#'       sliderInput("obs",
#'                   "Number of observations:",
#'                   min = 0,
#'                   max = 1000,
#'                   value = 500)
#'     ),
#'     mainPanel(
#'       plotOutput("distPlot")
#'     )
#'   )
#' )
#'
#' server <- function(input, output, session) {
#'   output$distPlot <- renderPlot({
#'     hist(rnorm(input$obs))
#'   })
#' }
#'
#' shinyApp(ui, server)
#'
#'
#' ### radial gradient background :
#'
#' library(shiny)
#' library(shinyWidgets)
#'
#' ui <- fluidPage(
#'
#'   # use a gradient in background
#'   setBackgroundColor(
#'     color = c("#F7FBFF", "#2171B5"),
#'     gradient = "radial",
#'     direction = c("top", "left")
#'   ),
#'
#'   titlePanel("Hello Shiny!"),
#'   sidebarLayout(
#'     sidebarPanel(
#'       sliderInput("obs",
#'                   "Number of observations:",
#'                   min = 0,
#'                   max = 1000,
#'                   value = 500)
#'     ),
#'     mainPanel(
#'       plotOutput("distPlot")
#'     )
#'   )
#' )
#'
#' server <- function(input, output, session) {
#'   output$distPlot <- renderPlot({
#'     hist(rnorm(input$obs))
#'   })
#' }
#'
#' shinyApp(ui, server)
#'
#' }
#'
#' }
setBackgroundColor <- function(color = "ghostwhite", gradient = c("linear", "radial"),
                               direction = c("bottom", "top", "right", "left")) {
  gradient <- match.arg(gradient)
  direction <- match.arg(direction, several.ok = TRUE)
  if (length(color) == 1) {
    css <- sprintf("background-color: %s;", color)
    css <- paste0("body {", css, "}")
  } else {
    if (length(direction) > 2) {
      direction <- direction[1]
    }
    direction <- paste(direction, collapse = " ")
    if (gradient == "radial") {
      direction <- paste("circle at", direction)
    } else {
      direction <- paste("to", direction)
    }
    css <- sprintf(
      "background: %s%s-gradient(%s, %s) fixed;",
      c("-moz-", "-webkit-", "-ms-", "-o-", ""),
      gradient, direction,
      paste(color, collapse = ", ")
    )
    css <- paste(css, collapse = "")
    css <- paste(
      "min-height: 100%; width:100%; position: absolute;
      -webkit-background-size: cover;
      -moz-background-size: cover;
      -o-background-size: cover;
      background-size: cover;",
      css
    )
    css <- paste0("body {", css, "}")
  }
  htmltools::tags$head(
    htmltools::tags$style(css)
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
#' library(shinyWidgets)
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
          "body {
           background: url(", src, ") no-repeat center center fixed;
           -webkit-background-size: cover;
           -moz-background-size: cover;
           -o-background-size: cover;
           background-size: cover;
          }"
        )
      )
    )
  )
}
