context("drop-menu")

test_that("dropMenu works", {

  tag <- dropMenu(
    shiny::actionButton("go0", "See what"),
    shiny::tags$div(
      "Content"
    ),
    theme = "light-border",
    placement = "right",
    arrow = FALSE
  )
  deps <- htmltools::findDependencies(tag)

  expect_is(tag, "shiny.tag")
  expect_true(length(deps) > 0)
})


test_that("dropMenu errors", {

  expect_error(
    dropMenu(
      shiny::textInput("ID", "Text:"),
      "Content",
      theme = "light-border",
      placement = "right",
      arrow = FALSE
    )
  )

  expect_error(
    dropMenu(
      "Btn",
      "Content",
      theme = "light-border",
      placement = "right",
      arrow = FALSE
    )
  )

})


test_that("dropMenuOptions works", {

  opts <- dropMenuOptions(duration = 500, custom = TRUE)

  expect_is(opts, "list")
  expect_identical(opts$custom, TRUE)
})
