#' @title Color editor for sliderInput
#'
#' @description Edit the color of the original shiny's sliderInputs
#'
#' @param color The \code{color} to apply. This can also be a vector of colors if you want to customize more than 1 slider. Either
#' pass the name of the color such as 'Chartreuse ' and 'Chocolate 'or the HEX notation such as \code{'#7FFF00'} and \code{'#D2691E'}.
#' @param sliderId The \code{id} of the customized slider(s). This can be a vector like \code{c(1, 2)}, if you want to modify the 2 first sliders.
#' However, if you only want to modify the second slider, just use the value 2.
#'
#' @note See also \url{https://www.w3schools.com/colors/colors_names.asp} to have an overview of all colors.
#'
#' @seealso See \code{\link{chooseSliderSkin}} to update the global skin of your sliders.
#'
#' @export
#'
#'
#' @examples
#' if (interactive()) {
#'
#' library(shiny)
#' library(shinyWidgets)
#'
#' ui <- fluidPage(
#'
#'   # only customize the 2 first sliders and the last one
#'   # the color of the third one is empty
#'   setSliderColor(c("DeepPink ", "#FF4500", "", "Teal"), c(1, 2, 4)),
#'   sliderInput("obs", "My pink slider:",
#'               min = 0, max = 100, value = 50
#'   ),
#'   sliderInput("obs2", "My orange slider:",
#'               min = 0, max = 100, value = 50
#'   ),
#'   sliderInput("obs3", "My basic slider:",
#'               min = 0, max = 100, value = 50
#'   ),
#'   sliderInput("obs3", "My teal slider:",
#'               min = 0, max = 100, value = 50
#'   ),
#'   plotOutput("distPlot")
#' )
#'
#' server <- function(input, output) {
#'
#'   output$distPlot <- renderPlot({
#'     hist(rnorm(input$obs))
#'   })
#' }
#'
#' shinyApp(ui, server)
#'
#' }
setSliderColor <- function(color, sliderId) {

  # some tests to control inputs
  stopifnot(!is.null(color))
  stopifnot(is.character(color))
  stopifnot(is.numeric(sliderId))
  stopifnot(!is.null(sliderId))

  # the css class for ionrangeslider starts from 0
  # therefore need to remove 1 from sliderId
  sliderId <- sliderId - 1

  # create custom css background for each slider
  # selected by the user
  sliderCol <- lapply(sliderId, FUN = function(i) {
    paste0(
      ".js-irs-", i, " .irs-single,",
      " .js-irs-", i, " .irs-from,",
      " .js-irs-", i, " .irs-to,",
      " .js-irs-", i, " .irs-bar-edge,",
      " .js-irs-", i,
      " .irs-bar{  border-color: transparent;background: ", color[i+1],
      "; border-top: 1px solid ", color[i+1],
      "; border-bottom: 1px solid ", color[i+1],
      ";}"
    )
  })

  # insert this custom css code in the head
  # of the shiy app
  custom_head <- tags$head(tags$style(HTML(as.character(sliderCol))))
  return(custom_head)
}
