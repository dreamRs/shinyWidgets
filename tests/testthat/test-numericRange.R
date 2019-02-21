context("numericRange")

test_that("Dependencies", {

  nr <- numericRangeInput(
    inputId = "default",
    label = "First example:",
    value = c(2,7)
  )

  nr_deps <- htmltools::findDependencies(nr)
  expect_length(object = nr_deps, n = 1)
  expect_true("shinyWidgets" %in% unlist(lapply(nr_deps, `[[`, "name")))

})


test_that("Default", {

  nr <- numericRangeInput(
    inputId = "default",
    label = "First example:",
    value = c(2,7)
  )

  expect_identical(object = nr$attribs$class, expected = "shiny-numeric-range-input form-group shiny-input-container")
  expect_identical(object = nr$attribs$id, expected = "default")

  expect_identical(object = nr$children[[1]]$attribs$class, expected = "control-label")

  expect_identical(object = nr$children[[2]]$attribs$class, expected = "input-numeric-range input-group")

  expect_identical(object = nr$children[[2]]$children[[1]]$attribs$type, expected = "number")
  expect_identical(object = nr$children[[2]]$children[[1]]$attribs$class, expected = "form-control")
  expect_identical(object = nr$children[[2]]$children[[1]]$attribs$value, expected = "2")

  expect_identical(object = nr$children[[2]]$children[[2]]$attribs$class, expected = "input-group-addon")

  expect_identical(object = nr$children[[2]]$children[[3]]$attribs$type, expected = "number")
  expect_identical(object = nr$children[[2]]$children[[3]]$attribs$class, expected = "form-control")
  expect_identical(object = nr$children[[2]]$children[[3]]$attribs$value, expected = "7")

})

test_that("Single Value", {

  nr <- numericRangeInput(
    inputId = "default",
    label = "First example:",
    value = 3
  )

  expect_identical(object = nr$attribs$class, expected = "shiny-numeric-range-input form-group shiny-input-container")
  expect_identical(object = nr$attribs$id, expected = "default")

  expect_identical(object = nr$children[[1]]$attribs$class, expected = "control-label")

  expect_identical(object = nr$children[[2]]$attribs$class, expected = "input-numeric-range input-group")

  expect_identical(object = nr$children[[2]]$children[[1]]$attribs$type, expected = "number")
  expect_identical(object = nr$children[[2]]$children[[1]]$attribs$class, expected = "form-control")
  expect_identical(object = nr$children[[2]]$children[[1]]$attribs$value, expected = "3")

  expect_identical(object = nr$children[[2]]$children[[2]]$attribs$class, expected = "input-group-addon")

  expect_identical(object = nr$children[[2]]$children[[3]]$attribs$type, expected = "number")
  expect_identical(object = nr$children[[2]]$children[[3]]$attribs$class, expected = "form-control")
  expect_identical(object = nr$children[[2]]$children[[3]]$attribs$value, expected = "3")

})
