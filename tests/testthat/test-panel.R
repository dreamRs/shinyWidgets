
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
  expect_identical(tagp$children[[1]]$attribs$class, "panel-heading")
  expect_identical(tagp$children[[3]]$attribs$class, "panel-footer")
})


test_that("With status", {

  tagp <- panel(
    "Content goes here",
    shiny::checkboxInput(inputId = "id3", label = "Label"),
    heading = "My title",
    status = "primary"
  )
  expect_identical(tagp$attribs$class, "panel panel-primary")

})
