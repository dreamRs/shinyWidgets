
context("updateRadioGroupButtons")


test_that("Send message", {

  session <- as.environment(list(
    ns = identity,
    sendInputMessage = function(inputId, message) {
      session$lastInputMessage = list(id = inputId, message = message)
    }
  ))

  updateRadioGroupButtons(session = session, inputId = "idawcbsw", choices = c("A", "B", "C"), status = "primary")
  resultRGB <- session$lastInputMessage

  expect_equal("A", resultRGB$message$selected)
  expect_true(grepl('"idawcbsw"', resultRGB$message$options))
  expect_true(grepl('primary', resultRGB$message$options))

})
