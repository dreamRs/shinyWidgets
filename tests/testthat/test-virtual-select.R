test_that("virtualSelectInput initializes", {
  skip_on_cran()
  skip_if_not_installed("shinytest2")
  app <- AppDriver$new(
    test_path("apps", "virtualSelectInput"),
    name = "virtualSelectInput",
    width = 800,
    height = 600
  )
  app$wait_for_value(input = "single", timeout = 2000)
  app$expect_values(input = TRUE, name = "init")
  app$stop()
})

test_that("virtualSelectInput updates reactives on change", {
  skip_on_cran()
  skip_if_not_installed("shinytest2")
  app <- AppDriver$new(
    test_path("apps", "virtualSelectInput"),
    name = "virtualSelectInput-change",
    width = 800,
    height = 600
  )
  app$wait_for_value(input = "single", timeout = 2000)
  app$set_inputs(single = "March")
  app$expect_values(
    input = "single",
    output = "res_single",
    name = "single"
  )
  app$set_inputs(multiple = c("Jan", "Feb"))
  app$expect_values(
    input = "multiple",
    output = "res_multiple",
    name = "multiple"
  )
  app$stop()
})
