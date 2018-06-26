
context("airDatePicker")


test_that("Default", {

  air <- airDatepickerInput(
    inputId = "default",
    label = "First example:"
  )

  expect_length(object = air[[1]]$children, n = 3)
  expect_identical(object = air[[1]]$children[[1]]$attribs$href, expected = "shinyWidgets/air-datepicker/datepicker.min.css")
  expect_identical(object = air[[1]]$children[[2]]$attribs$src, expected = "shinyWidgets/air-datepicker/datepicker.min.js")
  expect_identical(object = air[[1]]$children[[3]]$attribs$src, expected = "shinyWidgets/air-datepicker/datepicker-bindings.js")

})


test_that("Default", {

  air <- airDatepickerInput(
    inputId = "default",
    label = "First example:"
  )

  expect_identical(object = air[[3]]$attribs$class, expected = "form-group shiny-input-container")
  expect_identical(object = air[[3]]$children[[2]]$children[[2]]$attribs$id, expected = "default")
  expect_identical(object = air[[3]]$children[[2]]$children[[2]]$attribs$`data-view`, expected = "days")

})



test_that("Months", {

  air <- airMonthpickerInput(
    inputId = "default",
    label = "First example:"
  )

  expect_identical(object = air[[3]]$attribs$class, expected = "form-group shiny-input-container")
  expect_identical(object = air[[3]]$children[[2]]$children[[2]]$attribs$id, expected = "default")
  expect_identical(object = air[[3]]$children[[2]]$children[[2]]$attribs$`data-view`, expected = "months")

})



