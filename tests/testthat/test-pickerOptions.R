context("pickerOptions")

test_that("pickerOptions works", {

  opts <- pickerOptions()

  expect_is(opts, "list")
  expect_length(opts, 0)

  opts <- pickerOptions(actionsBox = TRUE)

  expect_is(opts, "list")
  expect_length(opts, 1)


  opts <- pickerOptions(actionsBox = TRUE, maxOptions = 2)

  expect_is(opts, "list")
  expect_length(opts, 2)
})
