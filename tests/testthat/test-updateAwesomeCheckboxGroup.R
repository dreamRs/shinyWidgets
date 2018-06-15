
context("updateAwesomeCheckboxGroup")


test_that("Send message", {

  session <- as.environment(list(
    ns = identity,
    sendInputMessage = function(inputId, message) {
      session$lastInputMessage = list(id = inputId, message = message)
    }
  ))

  updateAwesomeCheckboxGroup(session = session, inputId = "idawcbsw", choices = c("A", "B", "C"))
  resultACB <- session$lastInputMessage

  # expect_equal("A", resultACB$message$value)
  expect_true(grepl('"idawcbsw"', resultACB$message$options))

})
