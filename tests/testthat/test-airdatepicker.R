
context("airDatePicker")


test_that("Dependencies", {

  air <- airDatepickerInput(
    inputId = "default",
    label = "First example:"
  )

  air_deps <- htmltools::findDependencies(air)
  expect_length(object = air_deps, n = 4)
  expect_true("air-datepicker" %in% unlist(lapply(air_deps, `[[`, "name")))

})


test_that("Default", {

  air <- airDatepickerInput(
    inputId = "default",
    label = "First example:"
  )

  expect_identical(object = air$attribs$class, expected = "form-group shiny-input-container")
  expect_identical(object = air$children[[2]]$children[[2]]$attribs$id, expected = "default")
  expect_identical(object = air$children[[2]]$children[[2]]$attribs$`data-view`, expected = "days")

})



test_that("Months", {

  air <- airMonthpickerInput(
    inputId = "default",
    label = "First example:"
  )

  expect_identical(object = air$attribs$class, expected = "form-group shiny-input-container")
  expect_identical(object = air$children[[2]]$children[[2]]$attribs$id, expected = "default")
  expect_identical(object = air$children[[2]]$children[[2]]$attribs$`data-view`, expected = "months")

})



