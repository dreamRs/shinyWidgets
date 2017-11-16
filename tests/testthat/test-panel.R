
context("panel")


test_that("Default", {

  panel(
    "Content goes here",
    checkboxInput(inputId = "id1", label = "Label")
  )

})


test_that("With header and footer", {

  panel(
    "Content goes here",
    checkboxInput(inputId = "id2", label = "Label"),
    heading = "My title",
    footer = "Something"
  )

})


test_that("With status", {

  panel(
    "Content goes here",
    checkboxInput(inputId = "id3", label = "Label"),
    heading = "My title",
    status = "primary"
  )

})
