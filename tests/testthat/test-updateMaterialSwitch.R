
context("updateMaterialSwitch")


test_that("Send message", {

  session <- as.environment(list(
    ns = identity,
    sendInputMessage = function(inputId, message) {
      session$lastInputMessage = list(id = inputId, message = message)
    }
  ))

  updateMaterialSwitch(session = session, inputId = "idmaterialsw", value = TRUE)
  resultSwitch <- session$lastInputMessage

  expect_true(resultSwitch$message$value)

})
