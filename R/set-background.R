
#' @title Custom background color for your shinyapp
#'
#' @description Allow to change the background color of your shiny application.
#'
#' @param color Background color. Use either the fullname or the Hex code
#'  (\url{https://www.w3schools.com/colors/colors_hex.asp}). If more than one color is used,
#'  a gradient background is set.
#' @param gradient Type of gradient: \code{linear} or \code{radial}.
#' @param direction Direction for gradient, by default to \code{bottom}.
#'  Possibles choices are \code{bottom}, \code{top}, \code{right} or
#'  \code{left}, two values can be used, e.g. \code{c("bottom", "right")}.
#' @param shinydashboard Set to \code{TRUE} if in a shinydasboard application.
#'
#'
#' @export
#'
#' @examples
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
setBackgroundColor <- function(color = "ghostwhite",
                               gradient = c("linear", "radial"),
                               direction = c("bottom", "top", "right", "left"),
                               shinydashboard = FALSE) {
  gradient <- match.arg(gradient)
  direction <- match.arg(direction, several.ok = TRUE)
  if (length(color) == 1) {
    css <- sprintf("background-color: %s;", color)
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
    if (!isTRUE(shinydashboard)) {
      css <- paste("position: absolute;", css)
    }
    css <- paste(
      "min-height: 100%; width:100%;
      -webkit-background-size: cover;
      -moz-background-size: cover;
      -o-background-size: cover;
      background-size: cover;",
      css
    )
  }
  if (isTRUE(shinydashboard)) {
    css <- paste0(".content-wrapper {", css, "}")
  } else {
    css <- paste0("body {", css, "}")
  }
  htmltools::tags$head(
    htmltools::tags$style(css)
  )
}


#' @title Custom background image for your shinyapp
#'
#' @description Allow to change the background image of your shinyapp.
#'
#' @param src Url or path to the image, if using local image,
#'  the file must be in \code{www/} directory and the path not contain \code{www/}.
#' @param shinydashboard Set to \code{TRUE} if in a shinydasboard application.
#'
#'
#' @export
#'
#' @importFrom htmltools tags
#'
#' @examples
#' if (interactive()) {
#'
#' library(shiny)
#' library(shinyWidgets)
#'
#' ui <- fluidPage(
#'   tags$h2("Add a shiny app background image"),
#'   setBackgroundImage(
#'     src = "https://www.fillmurray.com/1920/1080"
#'   )
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
setBackgroundImage <- function(src = NULL, shinydashboard = FALSE) {
  if (isTRUE(shinydashboard)) {
    el <- ".content-wrapper"
  } else {
    el <- "body"
  }
  css <- paste0(
    el, " {background: url(", src, ") no-repeat center center fixed;
           -webkit-background-size: cover;
           -moz-background-size: cover;
           -o-background-size: cover;
           background-size: cover;}"
  )
  tags$head(tags$style(HTML(css)))
}
