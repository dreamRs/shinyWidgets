
context("airDatePicker")


test_that("Dependencies", {

  air <- airDatepickerInput(
    inputId = "default",
    label = "First example:"
  )

  expect_is(air, "shiny.tag")

  air_deps <- htmltools::findDependencies(air)
  expect_true(length(air_deps) > 0)
  expect_true("air-datepicker" %in% unlist(lapply(air_deps, `[[`, "name")))
})


test_that("Default", {

  air <- airDatepickerInput(
    inputId = "default",
    label = "First example:",
    value = Sys.Date()
  )

  json <- tail(air$children, 1)[[1]]$children[[1]]
  options <- jsonlite::fromJSON(json)

  expect_is(air, "shiny.tag")

  expect_identical(object = air$attribs$class, expected = "form-group shiny-input-container")
  expect_identical(object = air$children[[2]]$children[[2]]$attribs$id, expected = "default")
  expect_identical(object = air$children[[2]]$children[[2]]$attribs$class, expected = "sw-air-picker")

  expect_identical(object = options$value, expected = as.character(Sys.Date()))

})



test_that("Months", {

  air <- airMonthpickerInput(
    inputId = "month",
    label = "First example:"
  )

  json <- tail(air$children, 1)[[1]]$children[[1]]
  options <- jsonlite::fromJSON(json)

  expect_is(air, "shiny.tag")

  expect_identical(object = air$attribs$class, expected = "form-group shiny-input-container")
  expect_identical(object = air$children[[2]]$children[[2]]$attribs$id, expected = "month")
  expect_identical(object = air$children[[2]]$children[[2]]$attribs$class, expected = "sw-air-picker")

  expect_identical(object = options$options$view, expected = "months")

})



test_that("Years", {

  air <- airYearpickerInput(
    inputId = "year",
    label = "First example:"
  )

  json <- tail(air$children, 1)[[1]]$children[[1]]
  options <- jsonlite::fromJSON(json)

  expect_is(air, "shiny.tag")

  expect_identical(object = air$attribs$class, expected = "form-group shiny-input-container")
  expect_identical(object = air$children[[2]]$children[[2]]$attribs$id, expected = "year")
  expect_identical(object = air$children[[2]]$children[[2]]$attribs$class, expected = "sw-air-picker")

  expect_identical(object = options$options$view, expected = "years")

})




