context("knob")


test_that("default", {

  tagkb <- knobInput(
    inputId = "myKnob",
    label = "Display previous:",
    value = 50,
    min = -100,
    displayPrevious = TRUE,
    fgColor = "#428BCA",
    inputColor = "#428BCA"
  )

  expect_is(tagkb, "shiny.tag")
  expect_length(htmltools::findDependencies(tagkb), 2)
  expect_identical(htmltools::findDependencies(tagkb)[[2]]$script, c("jquery.knob.min.js"))
  expect_true(htmltools::tagHasAttribute(tagkb$children[[3]], "id"))
  expect_identical(htmltools::tagGetAttribute(tagkb$children[[3]], "id"), "myKnob")
})


test_that("updateKnobInput", {

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

  updateKnobInput(
    session = session,
    inputId = "MY_ID",
    value = 10
  )

  msgki <- session$lastInputMessage
  expect_length(msgki, 2)
  expect_identical(msgki$id, "MY_ID")
  expect_equal(msgki$message$value, 10)
})
