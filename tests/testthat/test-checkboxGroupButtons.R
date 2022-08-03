

context("checkboxGroupButtons")

library("shiny")


test_that("Default", {

  choices <- c("A", "B", "C")
  cbtag <- checkboxGroupButtons(
    inputId = "Id029",
    label = "Label",
    choices = choices
  )
  choicestag <- cbtag$children[[3]]$children[[1]]$children[[1]]
  choicestag <- choicestag()
  expect_length(choicestag, length(choices))

  checked <- lapply(choicestag, function(x) grepl(pattern = "checked", x = as.character(x)))
  checked <- unlist(checked)
  expect_true(all(!checked))
})


test_that("With choices", {

  choices <- c("A", "B", "C", "D")
  cbtag <- checkboxGroupButtons(
    inputId = "Id030",
    label = "Label",
    choices = choices,
    selected = choices[2]
  )

  choicestag <- cbtag$children[[3]]$children[[1]]$children[[1]]
  choicestag <- choicestag()
  expect_length(choicestag, length(choices))

  checked <- lapply(choicestag, function(x) grepl(pattern = "checked", x = as.character(x)))
  checked <- unlist(checked)
  expect_equal(which(checked), 2)
})


test_that("Danger status", {

  cbtag <- checkboxGroupButtons(
    inputId = "Id031",
    label = "Label",
    choices = c("A", "B", "C", "D"),
    status = "danger"
  )

  choicestag <- cbtag$children[[3]]$children[[1]]$children[[1]]
  choicestag <- choicestag()
  danger <- lapply(choicestag, function(x) grepl(pattern = "danger", x = as.character(x)))
  danger <- unlist(danger)
  expect_true(all(danger))
})


test_that("Success status", {

  cbtag <- checkboxGroupButtons(
    inputId = "Id031",
    label = "Label",
    choices = c("A", "B", "C", "D"),
    status = "success"
  )

  choicestag <- cbtag$children[[3]]$children[[1]]$children[[1]]
  choicestag <- choicestag()
  success <- lapply(choicestag, function(x) grepl(pattern = "success", x = as.character(x)))
  success <- unlist(success)
  expect_true(all(success))
})


test_that("Multiple status", {
  status <- c("success", "primary", "secondary")

  cbtag <- checkboxGroupButtons(
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

  cbtag <- checkboxGroupButtons(
    inputId = "Id033",
    label = "Label",
    choices = c("A", "B"),
    justified = TRUE
  )
  justified <- cbtag$children[[3]]$children[[1]]$attribs$class
  expect_identical(justified, "btn-group btn-group-justified d-flex")
})


test_that("Vertical", {

  cbtag <- checkboxGroupButtons(
    inputId = "Id034",
    label = "Label",
    choices = c("A", "B", "C", "D"),
    direction = "vertical"
  )
  vertical <- cbtag$children[[3]]$children[[1]]$attribs$class
  expect_identical(vertical, "btn-group-vertical")

})


test_that("Size", {

  cbtag <- checkboxGroupButtons(
    inputId = "Id035",
    label = "Label",
    choices = c("A", "B", "C", "D"),
    size = "lg"
  )

  lg <- cbtag$children[[3]]$children[[1]]$attribs$class
  expect_identical(lg, "btn-group btn-group-lg")

})


test_that("Icons button", {

  cbtag <- checkboxGroupButtons(
    inputId = "Id036",
    label = "Choose a graph :",
    choiceNames = list(
      shiny::icon("gear"),
      shiny::icon("gears")
    ),
    choiceValues = c("A", "B"),
    justified = TRUE
  )
  cbtag <- as.character(cbtag)
  expect_true(grepl(pattern = as.character(shiny::icon("gear")), x = cbtag))
  expect_true(grepl(pattern = as.character(shiny::icon("gears")), x = cbtag))
})


test_that("Icons check", {

  cbtag <- checkboxGroupButtons(
    inputId = "Id037",
    label = "Label",
    choices = c("A", "B", "C", "D"),
    justified = TRUE,
    checkIcon = list(yes = shiny::icon("ok", lib = "glyphicon"))
  )
  cbtag <- as.character(cbtag)
  expect_true(grepl(pattern = "check-btn-icon-yes", x = cbtag))
  expect_true(grepl(pattern = "check-btn-icon-no", x = cbtag))
})


test_that("Icons check / uncheck", {

  cbtag <- checkboxGroupButtons(
    inputId = "Id038",
    label = "Label", choices = c("A", "B", "C", "D"),
    status = "primary",
    checkIcon = list(yes = shiny::icon("ok", lib = "glyphicon"),
                     no = shiny::icon("xmark", lib = "glyphicon"))
  )
  cbtag <- as.character(cbtag)
  expect_true(grepl(pattern = "check-btn-icon-no", x = cbtag))
})


test_that("Separated buttons", {

  cbtag <- checkboxGroupButtons(
    inputId = "Id040",
    label = "Label",
    choices = c("Option 1",
                "Option 2", "Option 3",
                "Option 4"),
    individual = TRUE
  )
  justified <- cbtag$children[[3]]$children[[1]]$attribs
  nm <- names(cbtag$children[[3]]$children[[1]]$attribs)
  justified <- justified[which(nm == "class")]
  expect_true(any(grepl(pattern = "btn-group-container-sw", x = unlist(justified))))
})
