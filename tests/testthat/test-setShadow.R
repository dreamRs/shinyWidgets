context("setShadow")

test_that("setBackgroundColor works", {

  tag <- setShadow(class = "box")

  expect_is(tag, "shiny.tag")
  expect_length(tag$children, 1)

  tag <- setShadow(id = "my-progress")

  expect_is(tag, "shiny.tag")
  expect_length(tag$children, 1)
})

