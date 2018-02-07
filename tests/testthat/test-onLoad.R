context("onLoad")


test_that("attach ressources", {

  shinyWidgets:::.onLoad()

  expect_identical(
    shiny:::.globals$resources$shinyWidgets$directoryPath,
    normalizePath(system.file('www', package = 'shinyWidgets'))
  )

})
