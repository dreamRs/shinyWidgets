
context("panel")


test_that("Default", {

  tagp <- panel(
    "Content goes here",
    shiny::checkboxInput(inputId = "id1", label = "Label")
  )
  expect_is(tagp, "shiny.tag")
  expect_identical(tagp$attribs$class, "panel panel-default")
})


test_that("With header and footer", {

  tagp <- panel(
    "Content goes here",
    shiny::checkboxInput(inputId = "id2", label = "Label"),
    heading = "My title",
    footer = "Something"
  )
  expect_true(grepl(pattern = "panel-heading", x = as.character(tagp)))
  expect_true(grepl(pattern = "panel-footer", x = as.character(tagp)))
})


test_that("With status", {

  tagp <- panel(
    "Content goes here",
    shiny::checkboxInput(inputId = "id3", label = "Label"),
    heading = "My title",
    status = "primary"
  )
  expect_true(grepl(pattern = "panel panel-primary", x = as.character(tagp)))
})
