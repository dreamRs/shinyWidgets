#' @title Theme selector for sliderInput
#'
#' @description Customize the appearance of the original shiny's sliderInputs
#'
#' @param skin The \code{skin} to apply. Choose among 5 different flavors, namely 'Shiny', 'Flat', 'Modern', 'Nice', 'Simple", 'HTML5', 'Round' and 'Square'.
#'
#' @note It is not currently possible to apply multiple themes at the same time.
#'
#' @seealso See \code{\link{setSliderColor}} to update the color of your sliderInput.
#'
#' @export
#'
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
#'
#'   # use the Modern design
#'   chooseSliderSkin("Modern"),
#'   sliderInput("obs", "Customized slider1:",
#'               min = 0, max = 100, value = 50
#'   ),
#'   sliderInput("obs2", "Customized slider1:",
#'               min = 0, max = 100, value = 50
#'   ),
#'   sliderInput("obs3", "Customized slider1:",
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
#'
#'
#' }



chooseSliderSkin <- function(skin = c("Shiny", "Flat", "Modern", "Nice",
                                      "Simple", "HTML5", "Round", "Square")) {
  skin <- match.arg(arg = skin)
  tagList(
    htmltools::attachDependencies(
      x = tags$div(),
      value = sliderInputDep(skin),
      append = FALSE
    )
  )
}


# Function needed by chooseSliderSkin
# function that extract all the
# dependencies of shiny's sliderInput
# and replace them by the skin
# provided by the user.
sliderInputDep <- function(skin) {
  # recovers the dependencies
  # of a normal sliderInput
  deps <- htmltools::findDependencies(
    sliderInput(
      inputId = "test",
      label = "",
      min = 0, max = 1,
      value = 0
    )
  )
  # replace the css skin by what the user want
  # in chooseSliderSkin()
  deps[[1]]$stylesheet[[2]] <- paste0("css/ion.rangeSlider.skin", skin, ".css")
  return (deps)
}
