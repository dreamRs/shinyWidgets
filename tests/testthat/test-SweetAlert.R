context("Sweet Alert")


test_that("insertUI Sweet Alert", {

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

  sendSweetAlert(session = session, title = "TITLE", text = "TEXT", type = "success")
  tag_sw <- as.character(session$lastInsertUI$content$html)
  dep_sw <- session$lastInsertUI$content$deps

  expect_true(grepl(pattern = "sw-sa-deps", x = tag_sw))
  expect_length(dep_sw, 1)
})


test_that("sendSweetAlert", {

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

  sendSweetAlert(session = session, title = "TITLE", text = "TEXT", type = "success")
  sendSA <- session$lastCustomMessage

  expect_length(sendSA, 2)
  expect_identical(sendSA$type, "sweetalert-sw")

  sendSA_msg <- session$lastCustomMessage$message

  expect_length(sendSA_msg, 2)
  expect_identical(sendSA_msg$config$title, "TITLE")
  expect_is(sendSA_msg$config$text, "character")
  expect_identical(sendSA_msg$config$type, "success")
  expect_false(sendSA_msg$as_html)
  expect_true(sendSA_msg$config$allowOutsideClick)
})


test_that("confirmSweetAlert", {

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

  confirmSweetAlert(session = session, inputId = "MY_CONFIRMATION", title = "TITLE", text = "TEXT", type = "success")
  sendCA <- session$lastCustomMessage

  expect_length(sendCA, 2)
  expect_identical(sendCA$type, "sweetalert-sw-confirm")

  sendCA_msg <- session$lastCustomMessage$message

  expect_identical(sendCA_msg$id, "MY_CONFIRMATION")
  expect_length(sendCA_msg, 3)
  expect_identical(sendCA_msg$swal$title, "TITLE")
  expect_is(sendCA_msg$swal$text, "character")
  expect_identical(sendCA_msg$swal$type, "success")
})



test_that("inputSweetAlert", {

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

  inputSweetAlert(session = session, inputId = "MY_INPUT", title = "TITLE", text = "TEXT")
  sendIA <- session$lastCustomMessage

  expect_length(sendIA, 2)
  expect_identical(sendIA$type, "sweetalert-sw-input")

  sendIA_msg <- session$lastCustomMessage$message

  expect_identical(sendIA_msg$id, "MY_INPUT")
  expect_length(sendIA_msg, 3)
  expect_identical(sendIA_msg$swal$title, "TITLE")
  expect_is(sendIA_msg$swal$text, "json")
})




test_that("progressSweetAlert", {

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

  progressSweetAlert(session = session, id = "MY_PROGRESS", value = 0, total = 100, title = "TITLE")
  sendPA <- session$lastCustomMessage

  expect_length(sendPA, 2)
  expect_identical(sendPA$type, "sweetalert-sw")

  sendPA_msg <- session$lastCustomMessage$message

  expect_length(sendPA_msg, 3)
  expect_null(sendPA_msg$config$title)
  expect_false(sendPA_msg$config$allowOutsideClick)
})
