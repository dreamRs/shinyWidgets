
context("dropdownButton")


test_that("Default", {

  tagdropBtn <- dropdownButton(
    "Your contents goes here ! You can pass several elements",
    circle = TRUE, status = "danger", icon = shiny::icon("gear"), width = "300px",
    tooltip = tooltipOptions(title = "Click to see inputs !")
  )

  expect_identical(tagdropBtn$attribs$class, "dropdown")
})


test_that("InputId", {

  tagdropBtn <- dropdownButton(
    "Your contents goes here ! You can pass several elements", inputId = "MYID",
    circle = FALSE, status = "danger", icon = shiny::icon("gear"), width = "300px"
  )

  expect_identical(tagdropBtn$attribs$id, "MYID_state")
  expect_identical(tagdropBtn$children[[1]]$attribs$id, "MYID")
})
