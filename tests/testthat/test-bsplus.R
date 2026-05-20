
context("Tests bsplus compatibility")


test_that("Material Switch", {

  tag_materialSwitch <- materialSwitch(inputId = "msh", label = "Material Switch")

  expect_true(inherits(tag_materialSwitch, "shiny.tag"))
  expect_true(isTRUE(tag_materialSwitch$name == "div"))

  classes <- unlist(strsplit(tag_materialSwitch$attribs$class, split = " "))
  expect_true("form-group" %in% classes)
  expect_true("shiny-input-container" %in% classes)

})

test_that("Picker Input", {

  tag_pickerInput <- pickerInput(inputId = "somevalue", label = "A label", choices = c("a", "b"))

  expect_true(inherits(tag_pickerInput, "shiny.tag"))
  expect_true(isTRUE(tag_pickerInput$name == "div"))
  classes <- unlist(strsplit(tag_pickerInput$attribs$class, split = " "))
  expect_true("form-group" %in% classes)
  expect_true("shiny-input-container" %in% classes)

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
  classes <- unlist(strsplit(tag_searchInput$attribs$class, split = " "))
  expect_true("form-group" %in% classes)
  expect_true("shiny-input-container" %in% classes)

})

test_that("Awesome Checkbox", {

  tag_awesomeCheckbox <- awesomeCheckbox(inputId = "somevalue",
                                     label = "A single checkbox",
                                     value = TRUE,
                                     status = "danger")

  expect_true(inherits(tag_awesomeCheckbox, "shiny.tag"))
  expect_true(isTRUE(tag_awesomeCheckbox$name == "div"))
  classes <- unlist(strsplit(tag_awesomeCheckbox$attribs$class, split = " "))
  expect_true("form-group" %in% classes)
  expect_true("shiny-input-container" %in% classes)

})

test_that("Bootstrap Switch", {

  tag_switchInput <- switchInput(inputId = "somevalue")

  expect_true(inherits(tag_switchInput, "shiny.tag"))
  expect_true(isTRUE(tag_switchInput$name == "div"))
  classes <- unlist(strsplit(tag_switchInput$attribs$class, split = " "))
  expect_true("form-group" %in% classes)
  expect_true("shiny-input-container" %in% classes)

})
