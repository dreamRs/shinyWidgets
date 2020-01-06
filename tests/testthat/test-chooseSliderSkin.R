context("chooseSliderSkin")


test_that("chooseSliderSkin works", {

  tag <- chooseSliderSkin()
  deps <- htmltools::findDependencies(tag)
  expect_is(tag, "shiny.tag.list")
  expect_true(length(deps) > 0)
})

test_that("chooseSliderSkin with color works", {

  tag <- chooseSliderSkin(color = "#112446")
  deps <- htmltools::findDependencies(tag)
  sing <- htmltools::takeSingletons(tag)
  expect_is(tag, "shiny.tag.list")
  expect_length(tag, 2)
expect_length(sing$singletons, 1)
  expect_true(length(deps) > 0)
})

test_that("chooseSliderSkin flat with color works", {

  tag <- chooseSliderSkin(color = "#112446", skin = "Flat")
  deps <- htmltools::findDependencies(tag)
  sing <- htmltools::takeSingletons(tag)
  expect_is(tag, "shiny.tag.list")
  expect_length(tag, 2)
  expect_length(sing$singletons, 1)
  expect_true(length(deps) > 0)
})


test_that("asb works", {

  col <- asb("#ed5565", "#112446")

  expect_is(col, "numeric")
  expect_length(col, 3)
})


