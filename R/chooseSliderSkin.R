#' @title Theme selector for \code{sliderInput}
#'
#' @description Customize the appearance of the original shiny's \code{sliderInput}
#'
#' @param skin The \code{skin} to apply. Choose among 5 different flavors,
#'  namely 'Shiny', 'Flat', 'Modern', 'Nice', 'Simple', 'HTML5', 'Round' and 'Square'.
#' @param color A color to apply to all sliders. Works with following skins:
#'  'Shiny', 'Flat', 'Modern', 'HTML5'. For 'Flat' a CSS filter is applied,
#'  desired color maybe a little offset.
#'
#' @note It is not currently possible to apply multiple themes at the same time.
#'
#' @seealso See \code{\link{setSliderColor}} to update the color of your sliderInput.
#'
#' @export
#'
#' @importFrom htmltools attachDependencies tagList
#' @importFrom grDevices rgb2hsv col2rgb
#'
#'
#' @examples
#' if (interactive()) {
#'
#' library(shiny)
#' library(shinyWidgets)
#'
#' # With Modern design
#'
#' ui <- fluidPage(
#'   chooseSliderSkin("Modern"),
#'   sliderInput("obs", "Customized single slider:",
#'               min = 0, max = 100, value = 50
#'   ),
#'   sliderInput("obs2", "Customized range slider:",
#'               min = 0, max = 100, value = c(40, 80)
#'   ),
#'   plotOutput("distPlot")
#' )
#'
#' server <- function(input, output) {
#'
#'   output$distPlot <- renderPlot({
#'     hist(rnorm(input$obs))
#'   })
#'
#' }
#'
#' shinyApp(ui, server)
#'
#'
#'
#' # Use Flat design & a custom color
#'
#' ui <- fluidPage(
#'   chooseSliderSkin("Flat", color = "#112446"),
#'   sliderInput("obs", "Customized single slider:",
#'               min = 0, max = 100, value = 50
#'   ),
#'   sliderInput("obs2", "Customized range slider:",
#'               min = 0, max = 100, value = c(40, 80)
#'   ),
#'   sliderInput("obs3", "An other slider:",
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
chooseSliderSkin <- function(skin = c("Shiny", "Flat", "Modern", "Nice",
                                      "Simple", "HTML5", "Round", "Square"),
                             color = NULL) {
  skin <- match.arg(arg = skin)
  cssColor <- NULL
  if (!is.null(color)) {
    stopifnot(length(color) == 1)
    if (skin %in% c("Shiny", "Modern", "HTML5")) {
      cssColor <- singleton(
        tags$head(
          tags$style(
            sprintf(
              ".irs-bar-edge, .irs-bar, .irs-single, .irs-from, .irs-to {background: %s;}",
              color
            ),
            if (skin == "Modern")
              sprintf(".irs-from:after, .irs-to:after, .irs-single:after {border-top-color: %s;}", color)
          )
        )
      )
    } else if (skin == "Flat") {
      asb_ <- asb("#ed5565", color)
      angle <- asb_[1]
      saturate <- asb_[2]
      brightness <- asb_[3]
      colImg <- paste0(
        ".irs-bar-edge, .irs-bar, .irs-single:after, .irs-from:after, .irs-to:after, .irs-slider",
        " {",
        "-webkit-filter: hue-rotate(", angle, "deg) saturate(",
        saturate, "%) brightness(", brightness, "%); ",
        "filter: hue-rotate(", angle, "deg) saturate(",
        saturate, "%) brightness(", brightness, "%);",
        "}"
      )
      cssColor <- singleton(
        tags$head(
          tags$style(
            colImg,
            sprintf(".irs-single, .irs-from, .irs-to {background: %s;}", color)
          )
        )
      )
    # } else if (skin == "Nice") {
    #   asb_ <- asb("#99a4ac", color)
    #   angle <- asb_[1]
    #   saturate <- asb_[2]
    #   brightness <- asb_[3]
    #   colImg <- paste0(
    #     ".irs-bar-edge, .irs-line-mid, .irs-single:after",
    #     " {",
    #     "-webkit-filter: hue-rotate(", angle, "deg) saturate(",
    #     saturate, "%) brightness(", brightness, "%); ",
    #     "filter: hue-rotate(", angle, "deg) saturate(",
    #     saturate, "%) brightness(", brightness, "%);",
    #     "}"
    #   )
    #   cssColor <- singleton(
    #     tags$head(
    #       tags$style(
    #         colImg,
    #         sprintf(".irs-single, .irs-from, .irs-to {background: %s;}", color)
    #       )
    #     )
    #   )
    }
  }
  tagList(
    cssColor,
    htmltools::attachDependencies(
      x = tags$div(),
      value = sliderInputDep(skin),
      append = FALSE
    )
  )
}


# https://stackoverflow.com/questions/29037023/how-to-calculate-required-hue-rotate-to-generate-specific-colour
#' @importFrom grDevices col2rgb rgb2hsv
asb <- function(original, new) {
  # original color
  original_ <- unname(col2rgb(original)/255)
  # original <- rgb_to_hsl(r = original[1, 1], g = original[2, 1], b = original[3, 1])
  original <- rgb2hsv(r = original_[1, 1], g = original_[2, 1], b = original_[3, 1], maxColorValue = 1)[, 1]
  original[1] <- original[1] * 360
  original[3] <- sqrt( 0.299*original_[1, 1]^2 + 0.587*original_[2, 1]^2 + 0.114*original_[3, 1]^2 )

  # target color
  new_ <- unname(col2rgb(new)/255)
  # new <- rgb_to_hsl(r = new[1, 1], g = new[2, 1], b = new[3, 1])
  new <- rgb2hsv(r = new_[1, 1], g = new_[2, 1], b = new_[3, 1], maxColorValue = 1)[, 1]
  new[1] <- new[1] * 360
  new[3] <- sqrt( 0.299*new_[1, 1]^2 + 0.587*new_[2, 1]^2 + 0.114*new_[3, 1]^2 )

  angle <- new[1] - original[1]
  # angle <- round(angle, 2)
  brightness <- (1 - (original[3] - new[3])) * 100
  # brightness <- round(brightness, 2)
  saturate <- (1 + (original[2] - new[2])) * 100
  # saturate <- round(saturate, 2)
  c(angle, saturate, brightness)
}



# Function needed by chooseSliderSkin
# function that extract all the
# dependencies of shiny's sliderInput
# and replace them by the skin
# provided by the user.
#' @importFrom htmltools findDependencies
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
