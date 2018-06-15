
context("updateSwitchInput")


test_that("Send message", {

  session <- as.environment(list(
    ns = identity,
    sendInputMessage = function(inputId, message) {
      session$lastInputMessage = list(id = inputId, message = message)
    }
  ))

  updateSwitchInput(session = session, inputId = "idswitchsw", value = TRUE, onLabel = "YES", onStatus = "success")
  resultSwitch <- session$lastInputMessage

  expect_true(resultSwitch$message$value)
  expect_equal("YES", resultSwitch$message$onLabel)
  expect_equal("success", resultSwitch$message$onStatus)

})
