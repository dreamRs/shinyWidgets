
context("utility inputs")


test_that("circleButton & squareButton", {

  library("shiny")
  shinyWidgets:::squareButton(inputId = "id01", icon = icon("sliders"))
  circleButton(inputId = "id01", icon = icon("sliders"))

})


test_that("actionGroupButtons", {

  library("shiny")
  actionGroupButtons(inputIds = c("id01", "id02", "id03"), labels = c("A", "B", "C"))

  actionGroupButtons(inputIds = c("id01", "id02", "id03"), labels = c("A", "B", "C"), status = "primary", size = "lg")

  actionGroupButtons(inputIds = c("id01", "id02", "id03"), labels = c("A", "B", "C"), direction = "vertical")

  actionGroupButtons(inputIds = c("id01", "id02", "id03"), labels = c("A", "B", "C"), fullwidth = TRUE)

})
