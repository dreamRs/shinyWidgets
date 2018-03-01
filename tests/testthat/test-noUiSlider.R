context("noUiSlider")


test_that("default", {

  tag <- noUiSliderInput(
    inputId = "MY_ID",
    label = "My slider:",
    min = 0, max = 100,
    value = 20
  )

  expect_is(tag, "shiny.tag")
  expect_length(htmltools::findDependencies(tag), 2)
  expect_identical(htmltools::findDependencies(tag)[[1]]$script, "shinyWidgets-bindings.min.js")
  expect_identical(htmltools::findDependencies(tag)[[2]]$script, c("nouislider.min.js", "wNumb.js"))
  expect_true(htmltools::tagHasAttribute(tag$children[[2]]$children[[2]], "id"))
  expect_identical(htmltools::tagGetAttribute(tag$children[[2]]$children[[2]], "id"), "MY_ID")
})
