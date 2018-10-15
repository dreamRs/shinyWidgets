
context("utility inputs")


test_that("circleButton & squareButton", {

  tagsqbtn <- shinyWidgets:::squareButton(
    inputId = "id01",
    icon = shiny::icon("sliders")
  )
  expect_true(grepl(pattern = "btn-square", x = tagsqbtn$attribs$class))

  tagclbtn <- circleButton(
    inputId = "id01", icon = shiny::icon("sliders")
  )
  expect_true(grepl(pattern = "btn-circle", x = tagclbtn$attribs$class))
})


test_that("actionGroupButtons", {

  tagbtn1 <- actionGroupButtons(
    inputIds = c("id01", "id02", "id03"),
    labels = c("A", "B", "C")
  )
  expect_length(tagbtn1$children[[1]], 3)

  tagbtn2 <- actionGroupButtons(
    inputIds = c("id01", "id02", "id03"),
    labels = c("A", "B", "C"),
    status = "primary",
    size = "lg"
  )
  expect_true(grepl(pattern = "btn-primary", as.character(tagbtn2)))

  tagbtn3 <- actionGroupButtons(
    inputIds = c("id01", "id02", "id03"),
    labels = c("A", "B", "C"),
    direction = "vertical"
  )
  expect_true("btn-group-vertical" %in% unlist(tagbtn3$attribs, use.names = FALSE))

  tagbtn4 <- actionGroupButtons(
    inputIds = c("id01", "id02", "id03"),
    labels = c("A", "B", "C"),
    fullwidth = TRUE
  )
  expect_true("btn-group-justified" %in% unlist(tagbtn4$attribs, use.names = FALSE))

})
