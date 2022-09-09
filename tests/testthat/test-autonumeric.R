context("autonumeric")


test_that("default", {

  tagauto <- autonumericInput(
    inputId = "id1",
    label = "Display previous:",
    value = 1234,
    width = NULL,
    align = "center",
    currencySymbol = "$",
    currencySymbolPlacement = "s",
    decimalCharacter = ".",
    digitGroupSeparator = ",",
    allowDecimalPadding = TRUE,
    decimalPlaces = 2,
    digitalGroupSpacing = 3,
    modifyValueOnWheel = FALSE
  )

  expect_is(tagauto, "shiny.tag")
  expect_length(htmltools::findDependencies(tagauto), 1)
  expect_true(htmltools::tagHasAttribute(tagauto$children[[2]], "id"))
  expect_identical(htmltools::tagGetAttribute(tagauto$children[[2]], "id"), "id1")
})


test_that("updateAutonumericInput", {

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

  updateAutonumericInput(
    session = session,
    inputId = "MY_ID",
    value = 10
  )

  msgki <- session$lastInputMessage
  expect_length(msgki, 2)
  expect_identical(msgki$id, "MY_ID")
  expect_equal(msgki$message$value, 10)
})


context("currency")


test_that("default", {

  tagauto <- currencyInput(
    inputId = "id1",
    label = "Display previous:",
    value = 1234,
    width = NULL,
    align = "center",
    format = "euro"
  )

  expect_is(tagauto, "shiny.tag")
  expect_length(htmltools::findDependencies(tagauto), 1)
  expect_true(htmltools::tagHasAttribute(tagauto$children[[2]], "id"))
  expect_identical(htmltools::tagGetAttribute(tagauto$children[[2]], "id"), "id1")
})


test_that("updateCurrencyInput", {

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

  updateCurrencyInput(
    session = session,
    inputId = "MY_ID",
    value = 10,
    format = "dollar"
  )

  msgki <- session$lastInputMessage
  expect_length(msgki, 2)
  expect_identical(msgki$id, "MY_ID")
  expect_equal(msgki$message$value, 10)
  expect_equal(msgki$message$format, "dollar")
})
