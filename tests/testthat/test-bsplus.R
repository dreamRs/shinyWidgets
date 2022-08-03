
context("Tests bsplus compatibility")


test_that("Material Switch", {

  tag_materialSwitch <- materialSwitch(inputId = "msh", label = "Material Switch")

  expect_true(inherits(tag_materialSwitch, "shiny.tag"))
  expect_true(isTRUE(tag_materialSwitch$name == "div"))
  expect_true(
    identical(htmltools::tagGetAttribute(tag_materialSwitch, "class"), "form-group shiny-input-container")
  )

})

test_that("Picker Input", {

  tag_pickerInput <- pickerInput(inputId = "somevalue", label = "A label", choices = c("a", "b"))

  expect_true(inherits(tag_pickerInput, "shiny.tag"))
  expect_true(isTRUE(tag_pickerInput$name == "div"))
  expect_true(
    identical(htmltools::tagGetAttribute(tag_pickerInput, "class"), "form-group shiny-input-container")
  )

})

test_that("Search Input", {

  tag_searchInput <- searchInput(
    inputId = "search", label = "Enter your text",
    placeholder = "A placeholder",
    btnSearch = shiny::icon("magnifying-glass"),
    btnReset = shiny::icon("xmark"),
    width = "450px"
  )

  expect_true(inherits(tag_searchInput, "shiny.tag"))
  expect_true(isTRUE(tag_searchInput$name == "div"))
  expect_true(
    identical(htmltools::tagGetAttribute(tag_searchInput, "class"), "form-group shiny-input-container")
  )

})

test_that("Awesome Checkbox", {

  tag_awesomeCheckbox <- awesomeCheckbox(inputId = "somevalue",
                                     label = "A single checkbox",
                                     value = TRUE,
                                     status = "danger")

  expect_true(inherits(tag_awesomeCheckbox, "shiny.tag"))
  expect_true(isTRUE(tag_awesomeCheckbox$name == "div"))
  expect_true(
    identical(htmltools::tagGetAttribute(tag_awesomeCheckbox, "class"), "form-group shiny-input-container")
  )

})

test_that("Bootstrap Switch", {

  tag_switchInput <- switchInput(inputId = "somevalue")

  expect_true(inherits(tag_switchInput, "shiny.tag"))
  expect_true(isTRUE(tag_switchInput$name == "div"))
  expect_true(
    identical(htmltools::tagGetAttribute(tag_switchInput, "class"), "form-group shiny-input-container")
  )

})
