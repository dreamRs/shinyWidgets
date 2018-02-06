
context("textInputAddon")


test_that("Default", {

  tagad <- textInputAddon(
    inputId = "id",
    label = "Label",
    placeholder = "Username",
    addon = shiny::icon("at")
  )
  expect_length(tagad$children, 2)
  class_addon <- tagad$children[[2]]$children[[1]]$attribs$class
  expect_identical(class_addon, "input-group-addon")
})
