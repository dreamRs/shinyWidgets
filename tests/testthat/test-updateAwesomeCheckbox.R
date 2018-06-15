
context("updateAwesomeCheckbox")


test_that("Send message", {

  session <- as.environment(list(
    ns = identity,
    sendInputMessage = function(inputId, message) {
      session$lastInputMessage = list(id = inputId, message = message)
    }
  ))

  updateAwesomeCheckbox(session = session, inputId = "idawcheckw", value = TRUE, label = "NEWLABEL")
  resultACB <- session$lastInputMessage

  expect_true(resultACB$message$value)
  expect_equal("NEWLABEL", resultACB$message$label)

})
