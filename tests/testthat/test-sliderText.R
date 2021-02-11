context("sliderText")


test_that("default", {

  tagst <- sliderTextInput(
    inputId = "MY_ID",
    label = "Month range slider:",
    choices = month.name,
    selected = month.name[c(4, 7)]
  )

  deps <- htmltools::findDependencies(tagst)
  nmdeps <- vapply(deps, `[[`, "name", FUN.VALUE = character(1))
  expect_is(tagst, "shiny.tag.list")
  expect_true(length(deps) >= 3)
  expect_true(any(grepl("^ionrangeslider", nmdeps)))
  expect_true("shinyWidgets" %in% nmdeps)
  expect_true(htmltools::tagHasAttribute(tagst[[1]]$children[[2]], "id"))
  expect_identical(htmltools::tagGetAttribute(tagst[[1]]$children[[2]], "id"), "MY_ID")
})


test_that("animation", {

  tagst <- sliderTextInput(
    inputId = "MY_ID",
    label = "Month range slider:",
    choices = month.name,
    selected = month.name[c(4, 7)],
    animate = TRUE
  )

  expect_is(tagst, "shiny.tag.list")
  expect_true(htmltools::tagHasAttribute(tagst[[1]]$children[[3]], "class"))
  expect_identical(htmltools::tagGetAttribute(tagst[[1]]$children[[3]], "class"), "slider-animate-container")
})



test_that("updateSliderTextInput", {

  session <- as.environment(list(
    sendInputMessage = function(inputId, message) {
      session$lastInputMessage = list(id = inputId, message = message)
    },
    sendCustomMessage = function(type, message) {
      session$lastCustomMessage <- list(type = type, message = message)
    },
    sendInsertUI = function(selector, multiple,
                            where, content) {
      session$lastInsertUI <- list(selector = selector, multiple = multiple,
                                   where = where, content = content)
    },
    onFlushed = function(callback, once) {
      list(callback = callback, once = once)
    }
  ))

  updateSliderTextInput(
    session = session,
    inputId = "mySlider",
    choices = month.name,
    selected = month.name[9]
  )

  msgst <- session$lastInputMessage
  expect_length(msgst, 2)
  expect_identical(msgst$id, "mySlider")
  expect_identical(msgst$message$selected, "September")
  expect_length(msgst$message$choices, 12)
})
