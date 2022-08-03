context("vertical-tab")


test_that("verticalTabPanel works", {

  tag <- verticalTabsetPanel(
    verticalTabPanel(
      title = "Title 1", icon = shiny::icon("house", "fa-2x"),
      "Content panel 1"
    ),
    verticalTabPanel(
      title = "Title 2", icon = shiny::icon("map", "fa-2x"),
      "Content panel 2"
    ),
    verticalTabPanel(
      title = "Title 3", icon = shiny::icon("rocket", "fa-2x"),
      "Content panel 3"
    )
  )

  expect_is(tag, "shiny.tag.list")

})



test_that("verticalTabPanel (with args) works", {

  tag <- verticalTabsetPanel(
    menuSide = "right",
    selected = "Title 2",
    verticalTabPanel(
      title = "Title 1", icon = shiny::icon("house", "fa-2x"),
      "Content panel 1"
    ),
    verticalTabPanel(
      title = "Title 2", icon = shiny::icon("map", "fa-2x"),
      "Content panel 2"
    ),
    verticalTabPanel(
      title = "Title 3", icon = shiny::icon("rocket", "fa-2x"),
      "Content panel 3"
    )
  )

  expect_is(tag, "shiny.tag.list")

})


