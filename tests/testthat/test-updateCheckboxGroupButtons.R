
context("updateCheckboxGroupButtons")


test_that("Send message", {

  session <- as.environment(list(
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
