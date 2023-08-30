
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

