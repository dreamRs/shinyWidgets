
context("updateAwesomeRadio")


test_that("Send message", {

  session <- as.environment(list(
    ns = identity,
    sendInputMessage = function(inputId, message) {
      session$lastInputMessage = list(id = inputId, message = message)
    }
  ))

  updateAwesomeRadio(session = session, inputId = "idarsw", choices = c("A", "B", "C"))
  resultAR <- session$lastInputMessage

  expect_equal("A", resultAR$message$value)
  expect_true(grepl('"idarsw"', resultAR$message$options))

})
