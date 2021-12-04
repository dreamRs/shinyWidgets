
context("updateCheckboxGroupButtons")


test_that("Send message", {

  session <- as.environment(list(
    ns = identity,
    getCurrentTheme = function() NULL,
    sendInputMessage = function(inputId, message) {
      session$lastInputMessage = list(id = inputId, message = message)
    }
  ))

  updateCheckboxGroupButtons(session = session, inputId = "idawcbsw", choices = c("A", "B", "C"), status = "primary")
  resultCBGB <- session$lastInputMessage

  expect_null(resultCBGB$message$selected)
  expect_true(grepl('"idawcbsw"', resultCBGB$message$options))
  expect_true(grepl('primary', resultCBGB$message$options))

})


test_that("Works in modules", {
  createModuleSession <- function(moduleId) {
    session <- as.environment(list(
      ns = shiny::NS(moduleId),
      getCurrentTheme = function() NULL,
      sendInputMessage = function(inputId, message) {
        session$lastInputMessage = list(id = inputId, message = message)
      }
    ))
    session
  }

  session <- createModuleSession("modA")

  updateCheckboxGroupButtons(session = session, inputId = "idawcbsw", choices = c("A", "B", "C"), status = "primary")
  resultCBGB <- session$lastInputMessage

  expect_equal(object = resultCBGB$id, expected = "idawcbsw")
  expect_true(grepl('"modA-idawcbsw"', resultCBGB$message$options))
})

