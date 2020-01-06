context("set-background")

test_that("setBackgroundColor works", {

  tag <- setBackgroundColor()

  expect_is(tag, "shiny.tag")
  expect_length(tag$children, 1)

  tag <- setBackgroundColor(
    color = c("#F7FBFF", "#2171B5"),
    gradient = "linear",
    direction = "bottom"
  )

  expect_is(tag, "shiny.tag")
  expect_length(tag$children, 1)
})


test_that("setBackgroundImage works", {

  tag <- setBackgroundImage(src = "img/myimage.png")

  expect_is(tag, "shiny.tag")
  expect_length(tag$children, 1)

})


