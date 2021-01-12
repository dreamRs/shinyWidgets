
context("shinyWidgetsGallery")


test_that("Default", {

  library("shiny")
  expect_message(
    source(file = system.file('examples/shinyWidgets/global.R', package='shinyWidgets'))
  )

  expect_silent(
    ui <- source(file = system.file('examples/shinyWidgets/ui.R', package='shinyWidgets'))
  )
  expect_is(ui$value, "shiny.tag")

})
