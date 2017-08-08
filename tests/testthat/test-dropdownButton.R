
context("dropdownButton")


test_that("Default", {

  library(shiny)

  dropdownButton(
    "Your contents goes here ! You can pass several elements",
    circle = TRUE, status = "danger", icon = icon("gear"), width = "300px",
    tooltip = tooltipOptions(title = "Click to see inputs !")
  )


  dropdownButton(
    "Your contents goes here ! You can pass several elements",
    circle = FALSE, status = "danger", icon = icon("gear"), width = "300px"
  )


})
