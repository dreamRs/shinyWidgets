#' @title Awesome action button
#'
#' @description Like [shiny::actionButton()] but awesome, via \url{https://bttn.surge.sh/}
#'
#' @param inputId The `input` slot that will be used to access the value.
#' @param label The contents of the button, usually a text label.
#' @param icon An optional icon to appear on the button.
#' @param style Style of the button, to choose between `simple`, `bordered`,
#'   `minimal`, `stretch`, `jelly`, `gradient`, `fill`,
#'   `material-circle`, `material-flat`, `pill`, `float`, `unite`.
#' @param color Color of the button : `default`, `primary`, `warning`,
#'   `danger`, `success`, `royal`.
#' @param size Size of the button : `xs`,`sm`, `md`, `lg`.
#' @param block Logical, full width button.
#' @param no_outline Logical, don't show outline when navigating with
#'  keyboard/interact using mouse or touch.
#' @param ... Other arguments to pass to the container tag function.
#'
#' @export
#'
#' @seealso [downloadBttn()]
#'
#' @importFrom shiny restoreInput
#' @importFrom htmltools tags
#'
#' @examples
#' if (interactive()) {
#'
#' library(shiny)
#' library(shinyWidgets)
#'
#' ui <- fluidPage(
#'   tags$h2("Awesome action button"),
#'   tags$br(),
#'   actionBttn(
#'     inputId = "bttn1",
#'     label = "Go!",
#'     color = "primary",
#'     style = "bordered"
#'   ),
#'   tags$br(),
#'   verbatimTextOutput(outputId = "res_bttn1"),
#'   tags$br(),
#'   actionBttn(
#'     inputId = "bttn2",
#'     label = "Go!",
#'     color = "success",
#'     style = "material-flat",
#'     icon = icon("sliders"),
#'     block = TRUE
#'   ),
#'   tags$br(),
#'   verbatimTextOutput(outputId = "res_bttn2")
#' )
#'
#' server <- function(input, output, session) {
#'   output$res_bttn1 <- renderPrint(input$bttn1)
#'   output$res_bttn2 <- renderPrint(input$bttn2)
#' }
#'
#' shinyApp(ui = ui, server = server)
#'
#' }
actionBttn <- function(inputId,
                       label = NULL,
                       icon = NULL,
                       style = "unite",
                       color = "default",
                       size = "md",
                       block = FALSE,
                       no_outline = TRUE,
                       ...) {
  value <- shiny::restoreInput(id = inputId, default = NULL)
  style <- match.arg(
    arg = style,
    choices = c(
      "simple", "bordered", "minimal", "stretch", "jelly",
      "gradient", "fill", "material-circle", "material-flat",
      "pill", "float", "unite"
    )
  )
  color <- match.arg(
    arg = color,
    choices = c("default", "primary", "warning", "danger", "success", "royal")
  )
  size <- match.arg(arg = size, choices = c("xs", "sm", "md", "lg"))

  tagBttn <- tags$button(
    id = inputId,
    type = "button",
    class = "action-button bttn",
    `data-val` = value,
    class = paste0("bttn-", style),
    class = paste0("bttn-", size),
    class = paste0("bttn-", color),
    class = if (block) "bttn-block",
    class = if (no_outline) "bttn-no-outline",
    icon, label, ...
  )
  attachShinyWidgetsDep(tagBttn, "bttn")
}



#' Create a download `actionBttn`
#'
#' Create a download button with [actionBttn()].
#'
#' @param outputId The name of the output slot that the [shiny::downloadHandler()] is assigned to.
#' @inheritParams actionBttn
#'
#' @seealso [actionBttn()]
#'
#' @export
#'
#' @importFrom htmltools tags tagAppendAttributes
#' @importFrom shiny icon
#'
#' @examples
#' if (interactive()) {
#'
#' library(shiny)
#' library(shinyWidgets)
#'
#' ui <- fluidPage(
#'   tags$h2("Download bttn"),
#'   downloadBttn(
#'     outputId = "downloadData",
#'     style = "bordered",
#'     color = "primary"
#'   )
#' )
#'
#' server <- function(input, output, session) {
#'
#'   output$downloadData <- downloadHandler(
#'     filename = function() {
#'       paste('data-', Sys.Date(), '.csv', sep='')
#'     },
#'     content = function(con) {
#'       write.csv(mtcars, con)
#'     }
#'   )
#'
#' }
#'
#' shinyApp(ui, server)
#'
#' }
downloadBttn <- function(outputId,
                         label = "Download",
                         style = "unite",
                         color = "primary",
                         size = "md",
                         block = FALSE,
                         no_outline = TRUE,
                         icon = shiny::icon("download")) {
  bttn <- actionBttn(
    inputId = paste0(outputId, "_bttn"),
    label = tagList(
      tags$a(
        id = outputId,
        class = "shiny-download-link",
        href = "",
        target = "_blank",
        download = NA
      ),
      label
    ),
    color = color,
    style = style,
    size = size,
    block = block,
    no_outline = no_outline,
    icon = icon
  )
  htmltools::tagAppendAttributes(
    bttn,
    onclick = sprintf("getElementById('%s').click()", outputId)
  )
}
