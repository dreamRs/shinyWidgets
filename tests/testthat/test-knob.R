context("knob")


test_that("default", {

  tagkb <- knobInput(
    inputId = "myKnob",
    label = "Display previous:",
    value = 50,
    min = -100,
    displayPrevious = TRUE,
    fgColor = "#428BCA",
    inputColor = "#428BCA"
  )

  expect_is(tagkb, "shiny.tag")
  expect_length(htmltools::findDependencies(tagkb), 2)
  expect_identical(htmltools::findDependencies(tagkb)[[2]]$script, c("jquery.knob.min.js", "knob-input-binding.js"))
  expect_true(htmltools::tagHasAttribute(tagkb$children[[3]], "id"))
  expect_identical(htmltools::tagGetAttribute(tagkb$children[[3]], "id"), "myKnob")
})
