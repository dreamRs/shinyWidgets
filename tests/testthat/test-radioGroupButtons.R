

context("radioGroupButtons")

library("shiny")


test_that("Default", {

  choices <- c("A", "B", "C")
  rtag <- radioGroupButtons(
    inputId = "Id029",
    label = "Label",
    choices = choices
  )
  choicestag <- rtag$children[[3]]$children[[1]]$children[[1]]
  choicestag <- choicestag()
  expect_length(choicestag, length(choices))

  checked <- lapply(choicestag, function(x) grepl(pattern = "checked", x = as.character(x)))
  checked <- unlist(checked)
  expect_equal(which(checked), 1)
})


test_that("With choices", {

  choices <- c("A", "B", "C", "D")
  rtag <- radioGroupButtons(
    inputId = "Id030",
    label = "Label",
    choices = choices,
    selected = choices[2]
  )

  choicestag <- rtag$children[[3]]$children[[1]]$children[[1]]
  choicestag <- choicestag()
  expect_length(choicestag, length(choices))

  checked <- lapply(choicestag, function(x) grepl(pattern = "checked", x = as.character(x)))
  checked <- unlist(checked)
  expect_equal(which(checked), 2)
})


test_that("Danger status", {

  rtag <- radioGroupButtons(
    inputId = "Id031",
    label = "Label",
    choices = c("A", "B", "C", "D"),
    status = "danger"
  )

  choicestag <- rtag$children[[3]]$children[[1]]$children[[1]]
  choicestag <- choicestag()
  danger <- lapply(choicestag, function(x) grepl(pattern = "danger", x = as.character(x)))
  danger <- unlist(danger)
  expect_true(all(danger))
})


test_that("Success status", {

  rtag <- radioGroupButtons(
    inputId = "Id031",
    label = "Label",
    choices = c("A", "B", "C", "D"),
    status = "success"
  )

  choicestag <- rtag$children[[3]]$children[[1]]$children[[1]]
  choicestag <- choicestag()
  success <- lapply(choicestag, function(x) grepl(pattern = "success", x = as.character(x)))
  success <- unlist(success)
  expect_true(all(success))
})


test_that("Multiple status", {
  status <- c("success", "primary", "secondary")

  cbtag <- radioGroupButtons(
    inputId = "Id031",
    label = "Label",
    choices = c("A", "B", "C", "D"),
    status = status
  )

  status <- c("success", "primary", "secondary", "success")
  choicestag <- cbtag$children[[3]]$children[[1]]$children[[1]]
  choicestag <- choicestag()
  success <- lapply(seq_along(choicestag), function(x) grepl(pattern = status[x], x = as.character(choicestag[x])))
  success <- unlist(success)
  expect_true(all(success))
})


test_that("Justified", {

  rtag <- radioGroupButtons(
    inputId = "Id033",
    label = "Label",
    choices = c("A", "B"),
    justified = TRUE
  )
  justified <- rtag$children[[3]]$children[[1]]$attribs$class
  expect_identical(justified, "btn-group btn-group-justified d-flex")
})


test_that("Vertical", {

  rtag <- radioGroupButtons(
    inputId = "Id034",
    label = "Label",
    choices = c("A", "B", "C", "D"),
    direction = "vertical"
  )
  vertical <- rtag$children[[3]]$children[[1]]$attribs$class
  expect_identical(vertical, "btn-group-vertical")

})


test_that("Size", {

  rtag <- radioGroupButtons(
    inputId = "Id035",
    label = "Label",
    choices = c("A", "B", "C", "D"),
    size = "lg"
  )

  lg <- rtag$children[[3]]$children[[1]]$attribs$class
  expect_identical(lg, "btn-group btn-group-lg")

})


test_that("Icons button", {

  rtag <- radioGroupButtons(
    inputId = "Id036",
    label = "Choose a graph :",
    choiceNames = list(
      shiny::icon("gear"),
      shiny::icon("gears")
    ),
    choiceValues = c("A", "B"),
    justified = TRUE
  )
  rtag <- as.character(rtag)
  expect_true(grepl(pattern = as.character(shiny::icon("gear")), x = rtag))
  expect_true(grepl(pattern = as.character(shiny::icon("gears")), x = rtag))
})


test_that("Icons check", {

  rtag <- radioGroupButtons(
    inputId = "Id037",
    label = "Label",
    choices = c("A", "B", "C", "D"),
    justified = TRUE,
    checkIcon = list(yes = shiny::icon("ok", lib = "glyphicon"))
  )
  rtag <- as.character(rtag)
  expect_true(grepl(pattern = "radio-btn-icon-yes", x = rtag))
  expect_true(grepl(pattern = "radio-btn-icon-no", x = rtag))
})


test_that("Icons check / uncheck", {

  rtag <- radioGroupButtons(
    inputId = "Id038",
    label = "Label", choices = c("A", "B", "C", "D"),
    status = "primary",
    checkIcon = list(yes = shiny::icon("ok", lib = "glyphicon"),
                     no = shiny::icon("xmark", lib = "glyphicon"))
  )
  rtag <- as.character(rtag)
  expect_true(grepl(pattern = "radio-btn-icon-no", x = rtag))
})


test_that("Separated buttons", {

  rtag <- radioGroupButtons(
    inputId = "Id040",
    label = "Label",
    choices = c("Option 1",
                "Option 2", "Option 3",
                "Option 4"),
    individual = TRUE
  )
  justified <- rtag$children[[3]]$children[[1]]$attribs
  nm <- names(rtag$children[[3]]$children[[1]]$attribs)
  justified <- justified[which(nm == "class")]
  expect_true(any(grepl(pattern = "btn-group-container-sw", x = unlist(justified))))
})
