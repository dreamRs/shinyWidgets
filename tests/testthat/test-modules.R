
context("Tests modules")


test_that("pickerGroup", {

  tag <- pickerGroupUI(
    id = "my-filters",
    params = list(
      manufacturer = list(inputId = "manufacturer", title = "Manufacturer:"),
      model = list(inputId = "model", title = "Model:"),
      trans = list(inputId = "trans", title = "Trans:"),
      class = list(inputId = "class", title = "Class:")
    )
  )

  expect_true(inherits(tag, "shiny.tag.list"))
  expect_length(tag, 4)
  expect_length(tag[[3]]$children[[1]], 4)
})


test_that("pickerGroup (inline)", {

  tag <- pickerGroupUI(
    id = "my-filters",
    params = list(
      manufacturer = list(inputId = "manufacturer", title = "Manufacturer:"),
      model = list(inputId = "model", title = "Model:"),
      trans = list(inputId = "trans", title = "Trans:"),
      class = list(inputId = "class", title = "Class:")
    ),
    inline = FALSE
  )

  expect_true(inherits(tag, "shiny.tag.list"))
  expect_length(tag, 4)
  expect_length(tag[[3]], 4)
})



test_that("selectizeGroup", {

  tag <- selectizeGroupUI(
    id = "my-filters",
    params = list(
      manufacturer = list(inputId = "manufacturer", title = "Manufacturer:"),
      model = list(inputId = "model", title = "Model:"),
      trans = list(inputId = "trans", title = "Trans:"),
      class = list(inputId = "class", title = "Class:")
    )
  )

  expect_true(inherits(tag, "shiny.tag.list"))
  expect_length(tag, 2)
  expect_length(tag[[2]][[2]]$children[[1]], 4)
})


test_that("selectizeGroup (inline)", {

  tag <- selectizeGroupUI(
    id = "my-filters",
    params = list(
      manufacturer = list(inputId = "manufacturer", title = "Manufacturer:"),
      model = list(inputId = "model", title = "Model:"),
      trans = list(inputId = "trans", title = "Trans:"),
      class = list(inputId = "class", title = "Class:")
    ),
    inline = FALSE
  )

  expect_true(inherits(tag, "shiny.tag.list"))
  expect_length(tag, 2)
  expect_length(tag[[2]][[2]], 4)
})


