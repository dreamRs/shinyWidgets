
context("dropdown")


test_that("Default", {

  tagdrop <- dropdown(
    "Content goes here",
    style = "unite", icon = shiny::icon("gear"), status = "danger", width = "300px",
    animate = animateOptions(
      enter = animations$fading_entrances$fadeInLeftBig,
      exit = animations$fading_exits$fadeOutRightBig
    )
  )

  expect_identical(tagdrop$attribs$class, "sw-dropdown")
})

test_that("inputId", {

  tagdrop <- dropdown(
    "Content goes here",
    style = "default", icon = shiny::icon("gear"), status = "danger", width = "300px",
    inputId = "MYID"
  )
  expect_identical(tagdrop$attribs$id, "sw-drop-MYID")
})



