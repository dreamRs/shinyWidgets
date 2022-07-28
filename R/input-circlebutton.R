
#' @title Circle Action button
#'
#' @description
#' Create a rounded action button.
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param icon An icon to appear on the button.
#' @param status Color of the button.
#' @param size Size of the button : default, lg, sm, xs.
#' @param ... Named attributes to be applied to the button.
#'
#'
#' @importFrom shiny restoreInput
#' @importFrom htmltools tagList
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyWidgets)
#'
#'   ui <- fluidPage(
#'     tags$h3("Rounded actionBution"),
#'     circleButton(inputId = "btn1", icon = icon("gear")),
#'     circleButton(
#'       inputId = "btn2",
#'       icon = icon("sliders"),
#'       status = "primary"
#'     ),
#'     verbatimTextOutput("res1"),
#'     verbatimTextOutput("res2")
#'   )
#'
#'   server <- function(input, output, session) {
#'
#'     output$res1 <- renderPrint({
#'       paste("value button 1:", input$btn1)
#'     })
#'     output$res2 <- renderPrint({
#'       paste("value button 2:", input$btn2)
#'     })
#'
#'   }
#'
#'   shinyApp(ui, server)
#' }
circleButton <- function (inputId, icon = NULL, status = "default", size = "default", ...) {
  value <- shiny::restoreInput(id = inputId, default = NULL)
  size <- match.arg(arg = size, choices = c("default", "lg", "sm", "xs"))
  attachShinyWidgetsDep(
    htmltools::tags$button(
      id = inputId, type = "button", style = "outline: none;", `data-val` = value,
      class = paste0("btn btn-", status, " action-button ",
                     ifelse(size == "default", "btn-circle",
                            paste0("btn-circle-", size))), tags$span(icon), ...
    )
  )
}




squareButton <- function (inputId, icon = NULL, status = "default", size = "default", ...)
{
  size <- match.arg(arg = size, choices = c("default", "lg", "sm", "xs"))
  attachShinyWidgetsDep(
    htmltools::tags$button(
      id = inputId, type = "button", style = "outline: none;",
      class = paste0("btn btn-", status, " action-button ",
                     ifelse(size == "default", "btn-square",
                            paste0("btn-square-", size))), icon, ...
    )
  )
}
