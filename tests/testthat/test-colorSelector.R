
context("colorSelectorInput")


test_that("Default", {

  choices <- c("steelblue", "cornflowerblue",
               "firebrick", "palegoldenrod",
               "forestgreen")
  tagcs <- colorSelectorInput(
    inputId = "mycolor1", label = "Pick a color :",
    choices = choices
  )
  tagchoices <- gregexpr(pattern = "btn btn-color-sw", text = as.character(tagcs))[[1]]
  expect_length(tagchoices, length(choices))
  expect_true(grepl(pattern = "label", x = as.character(tagcs)))
})


test_that("Default drp", {

  choices <- c("steelblue", "cornflowerblue",
               "firebrick", "palegoldenrod",
               "forestgreen")
  tagcs <- colorSelectorDrop(
    inputId = "mycolor1", label = NULL,
    choices = choices
  )
  expect_identical(tagcs$attribs$class, "dropdown")
  expect_false(grepl(pattern = "label", x = as.character(tagcs)))
})
