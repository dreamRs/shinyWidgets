

context("checkboxGroupButtons")

library("shiny")


test_that("Default", {

  checkboxGroupButtons(inputId = "Id029",
                       label = "Label", choices = c("A",
                                                    "B", "C"))

})


test_that("With choices", {

  checkboxGroupButtons(inputId = "Id030",
                       label = "Label", choices = c("A",
                                                    "B", "C", "D"), selected = c("B",
                                                                                 "D"))

})


test_that("Danger status", {

  checkboxGroupButtons(inputId = "Id031",
                       label = "Label", choices = c("A",
                                                    "B", "C", "D"), status = "danger")

})


test_that("Success status", {

  checkboxGroupButtons(inputId = "Id032",
                       label = "Label", choices = c("A",
                                                    "B", "C", "D"), status = "success")
})


test_that("Justified", {

  checkboxGroupButtons(inputId = "Id033",
                       label = "Label", choices = c("A",
                                                    "B"), justified = TRUE)

})


test_that("Vertical", {

  checkboxGroupButtons(inputId = "Id034",
                       label = "Label", choices = c("A",
                                                    "B", "C", "D"), direction = "vertical")

})


test_that("Size", {

  checkboxGroupButtons(inputId = "Id035",
                       label = "Label", choices = c("A",
                                                    "B", "C", "D"), size = "lg")

})


test_that("Icons button", {

  checkboxGroupButtons(inputId = "Id036",
                       label = "Choose a graph :",
                       choices = c(`<i class='fa fa-bar-chart'></i>` = "bar",
                                   `<i class='fa fa-line-chart'></i>` = "line",
                                   `<i class='fa fa-pie-chart'></i>` = "pie"),
                       justified = TRUE)

})


test_that("Icons check", {

  checkboxGroupButtons(inputId = "Id037",
                       label = "Label", choices = c("A",
                                                    "B", "C", "D"), justified = TRUE,
                       checkIcon = list(yes = icon("ok",
                                                   lib = "glyphicon")))

})


test_that("Icons check / uncheck", {

  checkboxGroupButtons(inputId = "Id038",
                       label = "Label", choices = c("A",
                                                    "B", "C", "D"), status = "primary",
                       checkIcon = list(yes = icon("ok",
                                                   lib = "glyphicon"), no = icon("remove",
                                                                                 lib = "glyphicon")))

})


test_that("Colored icons", {

  checkboxGroupButtons(inputId = "Id039",
                       label = "Label", choices = c("Option 1",
                                                    "Option 2", "Option 3",
                                                    "Option 4"), checkIcon = list(yes = tags$i(class = "fa fa-check-square",
                                                                                               style = "color: steelblue"),
                                                                                  no = tags$i(class = "fa fa-square-o",
                                                                                              style = "color: steelblue")))

})


test_that("Separated buttons", {

  checkboxGroupButtons(inputId = "Id040",
                       label = "Label", choices = c("Option 1",
                                                    "Option 2", "Option 3",
                                                    "Option 4"), individual = TRUE,
                       checkIcon = list(yes = tags$i(class = "fa fa-circle",
                                                     style = "color: steelblue"),
                                        no = tags$i(class = "fa fa-circle-o",
                                                    style = "color: steelblue")))

})
