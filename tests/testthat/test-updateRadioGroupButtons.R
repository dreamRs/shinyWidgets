
context("updateRadioGroupButtons")


test_that("Send message", {

  session <- as.environment(list(
    ns = identity,
    getCurrentTheme = function() NULL,
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

  updateRadioGroupButtons(session = session, inputId = "idrgbsw", choices = c("A", "B", "C"), status = "primary")
  resultRGB <- session$lastInputMessage

  expect_equal(object = resultRGB$id, expected = "idrgbsw")
  expect_true(grepl('"modA-idrgbsw"', resultRGB$message$options))
})

