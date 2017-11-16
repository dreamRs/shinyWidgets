
context("colorSelectorInput")


test_that("Default", {

  colorSelectorInput(
    inputId = "mycolor1", label = "Pick a color :",
    choices = c("steelblue", "cornflowerblue",
                "firebrick", "palegoldenrod",
                "forestgreen")
  )

})


test_that("Default drp", {

  colorSelectorDrop(
    inputId = "mycolor1", label = NULL,
    choices = c("steelblue", "cornflowerblue",
                "firebrick", "palegoldenrod",
                "forestgreen")
  )

})
