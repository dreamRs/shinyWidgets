
context("dropdown")


test_that("Default", {

  library(shiny)

  dropdown(
    "Content goes here",
    style = "unite", icon = icon("gear"), status = "danger", width = "300px",
    animate = animateOptions(
      enter = animations$fading_entrances$fadeInLeftBig,
      exit = animations$fading_exits$fadeOutRightBig
    )
  )


  dropdown(
    "Content goes here",
    style = "default", icon = icon("gear"), status = "danger", width = "300px",
    tooltip = tooltipOptions(title = "Click to see inputs !")
  )


})
