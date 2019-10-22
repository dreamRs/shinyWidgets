context("spectrum")


test_that("example", {

  tagsp <- spectrumInput(
    inputId = "myColor",
    label = "Pick a color:",
    choices = list(
      list('black', 'white', 'blanchedalmond', 'steelblue', 'forestgreen'),
      as.list(scales::brewer_pal(palette = "Blues")(9)),
      as.list(scales::brewer_pal(palette = "Greens")(9)),
      as.list(scales::brewer_pal(palette = "Spectral")(11)),
      as.list(scales::brewer_pal(palette = "Dark2")(8))
    ),
    options = list(`toggle-palette-more-text` = "Show more")
  )

  expect_is(tagsp, "shiny.tag")
  expect_length(htmltools::findDependencies(tagsp), 2)
  expect_identical(htmltools::findDependencies(tagsp)[[2]]$script, "spectrum.min.js")
  expect_true(htmltools::tagHasAttribute(tagsp$children[[3]], "id"))
  expect_identical(htmltools::tagGetAttribute(tagsp$children[[3]], "id"), "myColor")
})
