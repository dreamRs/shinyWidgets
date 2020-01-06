
context("input-icon")


test_that("textInputIcon works", {

  tag <- textInputIcon(
    inputId = "ID",
    label = "With an icon",
    icon = shiny::icon("user-circle-o")
  )

  expect_is(tag, "shiny.tag")

})


test_that("textInputIcon works with list", {

  tag <- textInputIcon(
    inputId = "ID",
    label = "With an icon",
    icon = list(shiny::icon("envelope"), "@mail.com"),
    size = "lg"
  )

  expect_is(tag, "shiny.tag")

})



test_that("textInputIcon works", {

  tag <- numericInputIcon(
    inputId = "ID",
    label = "With an icon",
    value = 0,
    icon = shiny::icon("user-circle-o")
  )

  expect_is(tag, "shiny.tag")

})


test_that("textInputIcon works with list", {

  tag <- numericInputIcon(
    inputId = "ID",
    label = "With an icon",
    value = 0,
    icon = list(shiny::icon("envelope"), "@mail.com"),
    size = "lg"
  )

  expect_is(tag, "shiny.tag")

})


