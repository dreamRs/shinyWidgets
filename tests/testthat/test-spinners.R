
context("addSpinner")


test_that("Dependencies", {

  default <- addSpinner(output = shiny::plotOutput(outputId = "plot"))

  expect_identical(object = default[[1]]$name, expected = "head")
  expect_identical(object = default[[1]]$children[[1]]$attribs$href, expected = "shinyWidgets/spinner/spin.css")

})

test_that("Circle", {

  circle <- addSpinner(output = shiny::plotOutput(outputId = "plot"), spin = "circle")

  expect_true(grepl(pattern = "sk-circle", x = circle[[2]]$children[[1]]$children[[2]]$attribs$class))
  expect_true(grepl(pattern = "loading-spinner", x = circle[[2]]$children[[1]]$children[[2]]$attribs$class))

})

test_that("Bounce", {

  bounce <- addSpinner(output = shiny::plotOutput(outputId = "plot"), spin = "bounce")

  expect_true(grepl(pattern = "spinner-bounce", x = bounce[[2]]$children[[1]]$attribs$class))
  expect_true(grepl(pattern = "loading-spinner", x = bounce[[2]]$children[[1]]$attribs$class))

})

test_that("Folding-cube", {

  folding_cube <- addSpinner(output = shiny::plotOutput(outputId = "plot"), spin = "folding-cube")

  expect_true(grepl(pattern = "sk-folding-cube", x = folding_cube[[2]]$children[[1]]$children[[2]]$attribs$class))
  expect_true(grepl(pattern = "loading-spinner", x = folding_cube[[2]]$children[[1]]$attribs$class))

})

test_that("Rotating-plane", {

  rotating_plane <- addSpinner(output = shiny::plotOutput(outputId = "plot"), spin = "rotating-plane")

  expect_true(grepl(pattern = "rotating-plane", x = rotating_plane[[2]]$children[[1]]$children[[1]]$attribs$class))
  expect_true(grepl(pattern = "loading-spinner", x = rotating_plane[[2]]$children[[1]]$attribs$class))

})

test_that("Cube-grid", {

  cube_grid <- addSpinner(output = shiny::plotOutput(outputId = "plot"), spin = "cube-grid")

  expect_true(grepl(pattern = "sk-cube-grid", x = cube_grid[[2]]$children[[1]]$attribs$class))
  expect_true(grepl(pattern = "loading-spinner", x = cube_grid[[2]]$children[[1]]$attribs$class))

})

test_that("Fading-circle", {

  fading_circle <- addSpinner(output = shiny::plotOutput(outputId = "plot"), spin = "fading-circle")

  expect_true(grepl(pattern = "loading-spinner", x = fading_circle[[2]]$children[[1]]$attribs$class))
  expect_true(grepl(pattern = "sk-fading-circle", x = fading_circle[[2]]$children[[1]]$children[[2]]$attribs$class))

})

test_that("Double-bounce", {

  double_bounce <- addSpinner(output = shiny::plotOutput(outputId = "plot"), spin = "double-bounce")

  expect_true(grepl(pattern = "loading-spinner", x = double_bounce[[2]]$children[[1]]$attribs$class))
  expect_true(grepl(pattern = "double-bounce2", x = double_bounce[[2]]$children[[1]]$children[[2]]$attribs$class))

})

test_that("Dots", {

  dots <- addSpinner(output = shiny::plotOutput(outputId = "plot"), spin = "dots")

  expect_true(grepl(pattern = "loading-spinner", x = dots[[2]]$children[[1]]$attribs$class))
  expect_true(grepl(pattern = "spinner-dots", x = dots[[2]]$children[[1]]$attribs$class))

})

test_that("Cube", {

  cube <- addSpinner(output = shiny::plotOutput(outputId = "plot"), spin = "cube")

  expect_true(grepl(pattern = "loading-spinner", x = cube[[2]]$children[[1]]$attribs$class))
  expect_true(grepl(pattern = "spinner-cube", x = cube[[2]]$children[[1]]$attribs$class))

})

