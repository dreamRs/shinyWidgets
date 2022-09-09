context("noUiSlider")


test_that("default", {

  tag <- noUiSliderInput(
    inputId = "MY_ID",
    label = "My slider:",
    min = 0, max = 100,
    value = 20
  )

  expect_is(tag, "shiny.tag")
  expect_length(htmltools::findDependencies(tag), 1)
  expect_true(htmltools::tagHasAttribute(tag$children[[2]]$children[[2]], "id"))
  expect_identical(htmltools::tagGetAttribute(tag$children[[2]]$children[[2]], "id"), "MY_ID")
})
