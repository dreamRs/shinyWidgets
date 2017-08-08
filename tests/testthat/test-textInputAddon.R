
context("textInputAddon")


test_that("Default", {

  library("shiny")
  textInputAddon(inputId = "id", label = "Label", placeholder = "Username", addon = icon("at"))

})
