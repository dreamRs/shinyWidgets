context("multi")


test_that("default", {

  tagmu <- multiInput(
    inputId = "MY_ID", label = "Fruits :",
    choices = c("Banana", "Blueberry", "Cherry",
                "Coconut", "Grapefruit", "Kiwi",
                "Lemon", "Lime", "Mango", "Orange",
                "Papaya"),
    selected = "Banana", width = "350px"
  )

  expect_is(tagmu, "shiny.tag")
  expect_length(htmltools::findDependencies(tagmu), 2)
  expect_true(htmltools::tagHasAttribute(tagmu$children[[2]], "id"))
  expect_identical(htmltools::tagGetAttribute(tagmu$children[[2]], "id"), "MY_ID")
})



test_that("updateMultiInput", {


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

  shinyWidgets:::updateMultiInput(session = session, inputId = "MY_ID", choices = letters)

  msgmu <- session$lastInputMessage

  expect_length(msgmu, 2)
  expect_identical(msgmu$id, "MY_ID")
  expect_is(msgmu$message$options, "character")
})


