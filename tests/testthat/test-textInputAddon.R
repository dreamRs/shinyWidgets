
context("textInputAddon")

library("shiny")

test_that("Default", {

  library("shiny")
  textInputAddon(inputId = "id", label = "Label", placeholder = "Username", addon = icon("at"))

})
