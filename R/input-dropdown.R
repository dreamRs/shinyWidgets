#' @title Dropdown Button
#'
#' @description
#' Create a dropdown menu with Bootstrap where you can put input elements.
#'
#' @param ... List of tag to be displayed into the dropdown menu.
#' @param circle Logical. Use a circle button
#' @param icon An icon to appear on the button.
#' @param status Add a class to the buttons, you can use Bootstrap status like 'info', 'primary', 'danger', 'warning' or 'success'.
#'  Or use an arbitrary strings to add a custom class, e.g. : with \code{status = 'myClass'}, buttons will have class \code{btn-myClass}.
#' @param size Size of the button : default, lg, sm, xs.
#' @param label Label to appear on the button. If circle = TRUE and tooltip = TRUE, label is used in tooltip.
#' @param tooltip Put a tooltip on the button, you can customize tooltip with \code{tooltipOptions}.
#' @param right Logical. The dropdown menu starts on the right.
#' @param up Logical. Display the dropdown menu above.
#' @param width Width of the dropdown menu content.
#' @param margin Value of the dropdown margin-right and margin-left menu content.
#' @param inline use an inline (\code{span()}) or block container (\code{div()}) for the output.
#' @param inputId Optional, id for the button, the button act like an \code{actionButton},
#' and you can use the id to toggle the dropdown menu server-side with \code{\link{toggleDropdownButton}}.
#'
#'
#' @details It is possible to know if a dropdown is open or closed server-side with \code{input$<inputId>_state}.
#'
#'
#' @note \code{pickerInput} doesn't work inside \code{dropdownButton} because that's also a
#' dropdown and you can't nest them. Instead use \code{\link{dropdown}},
#' it has similar features but is built differently so it works.
#'
#'
#' @importFrom htmltools validateCssUnit tags tagList
#'
#' @export
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'
#' library(shiny)
#' library(shinyWidgets)
#'
#' ui <- fluidPage(
#'   dropdownButton(
#'     inputId = "mydropdown",
#'     label = "Controls",
#'     icon = icon("sliders"),
#'     status = "primary",
#'     circle = FALSE,
#'     sliderInput(
#'       inputId = "n",
#'       label = "Number of observations",
#'       min = 10, max = 100, value = 30
#'     ),
#'     prettyToggle(
#'       inputId = "na",
#'       label_on = "NAs keeped",
#'       label_off = "NAs removed",
#'       icon_on = icon("check"),
#'       icon_off = icon("xmark")
#'     )
#'   ),
#'   tags$div(style = "height: 140px;"), # spacing
#'   verbatimTextOutput(outputId = "out"),
#'   verbatimTextOutput(outputId = "state")
#' )
#'
#' server <- function(input, output, session) {
#'
#'   output$out <- renderPrint({
#'     cat(
#'       " # n\n", input$n, "\n",
#'       "# na\n", input$na
#'     )
#'   })
#'
#'   output$state <- renderPrint({
#'     cat("Open:", input$mydropdown_state)
#'   })
#'
#' }
#'
#' shinyApp(ui, server)
#'
#' }
dropdownButton <- function(...,
                           circle = TRUE,
                           status = "default",
                           size = "default",
                           icon = NULL,
                           label = NULL,
                           tooltip = FALSE,
                           right = FALSE,
                           up = FALSE,
                           width = NULL,
                           margin = "10px",
                           inline = FALSE,
                           inputId = NULL) {
  size <- match.arg(arg = size, choices = c("default", "lg", "sm", "xs"))
  if (is.null(inputId)) {
    inputId <- paste0("drop", sample.int(1e9, 1))
  }

  # dropdown content
  html_ul <- list(
    class = paste("dropdown-menu", ifelse(right, "dropdown-menu-right", "")),
    class = "dropdown-shinyWidgets",
    id = paste("dropdown-menu", inputId, sep = "-"),
    style = if (!is.null(width))
      paste0("width: ", htmltools::validateCssUnit(width), ";"),
    `aria-labelledby` = inputId,
    lapply(
      X = list(...),
      FUN = htmltools::tags$li,
      style = paste0("margin-left: ", htmltools::validateCssUnit(margin),
                     "; margin-right: ", htmltools::validateCssUnit(margin), ";")
    )
  )

  # button
  if (circle) {
    html_button <- circleButton(
      inputId = inputId,
      icon = icon,
      status = status,
      size = size,
      class = "dropdown-toggle",
      `data-toggle` = "dropdown",
      `data-bs-toggle` = "dropdown"
    )
  } else {
    html_button <- list(
      class = paste0("btn btn-", status," action-button dropdown-toggle "),
      class = if (size != "default") paste0("btn-", size),
      type = "button",
      id = inputId,
      `data-toggle` = "dropdown",
      `data-bs-toggle` = "dropdown",
      `aria-haspopup` = "true",
      `aria-expanded` = "true",
      list(icon, label),
      tags$span(class = "caret")
    )
    html_button <- do.call(htmltools::tags$button, html_button)
  }

  # tooltip
  if (identical(tooltip, TRUE))
    tooltip <- tooltipOptions(title = label)

  if (!is.null(tooltip) && !identical(tooltip, FALSE)) {
    tooltip <- lapply(tooltip, function(x) {
      if (identical(x, TRUE))
        "true"
      else if (identical(x, FALSE))
        "false"
      else x
    })
    tooltipJs <- htmltools::tags$script(
      sprintf(
        "$('#%s').tooltip({ placement: '%s', title: '%s', html: %s, trigger: 'hover' });",
        inputId, tooltip$placement, tooltip$title, tooltip$html
      )
    )
  } else {
    tooltipJs <- ""
  }

  if( inline ) container <- htmltools::tags$span
  else container <- htmltools::tags$div
  dropdownTag <- container(
    class = ifelse(up, "dropup", "dropdown"),
    class = "btn-dropdown-input",
    html_button,
    id = paste0(inputId, "_state"),
    do.call(htmltools::tags$ul, html_ul),
    tooltipJs
  )
  attachShinyWidgetsDep(dropdownTag, "dropdown")
}


#' @title Tooltip options
#'
#' @description
#' List of options for tooltip for a dropdown menu button.
#'
#' @param placement Placement of tooltip : right, top, bottom, left.
#' @param title Text of the tooltip
#' @param html Logical, allow HTML tags inside tooltip
#'
#'
#' @export
tooltipOptions <- function(placement = "right",
                           title = "Params",
                           html = FALSE) {
  list(placement = placement, title = title, html = html)
}




#' Toggle a dropdown menu
#'
#' Open or close a dropdown menu server-side.
#'
#' @param inputId Id for the dropdown to toggle.
#' @param session Standard shiny \code{session}.
#'
#' @export
#' @importFrom shiny getDefaultReactiveDomain
#'
#' @examples
#' if (interactive()) {
#'
#' library("shiny")
#' library("shinyWidgets")
#'
#' ui <- fluidPage(
#'   tags$h2("Toggle Dropdown Button"),
#'   br(),
#'   fluidRow(
#'     column(
#'       width = 6,
#'       dropdownButton(
#'         tags$h3("List of Inputs"),
#'         selectInput(inputId = 'xcol',
#'                     label = 'X Variable',
#'                     choices = names(iris)),
#'         sliderInput(inputId = 'clusters',
#'                     label = 'Cluster count',
#'                     value = 3,
#'                     min = 1,
#'                     max = 9),
#'         actionButton(inputId = "toggle2",
#'                      label = "Close dropdown"),
#'         circle = TRUE, status = "danger",
#'         inputId = "mydropdown",
#'         icon = icon("gear"), width = "300px"
#'       )
#'     ),
#'     column(
#'       width = 6,
#'       actionButton(inputId = "toggle1",
#'                    label = "Open dropdown")
#'     )
#'   )
#' )
#'
#' server <- function(input, output, session) {
#'
#'   observeEvent(list(input$toggle1, input$toggle2), {
#'     toggleDropdownButton(inputId = "mydropdown")
#'   }, ignoreInit = TRUE)
#'
#' }
#'
#' shinyApp(ui = ui, server = server)
#'
#' }
toggleDropdownButton <- function(inputId, session = getDefaultReactiveDomain()) {
  session$sendInputMessage(paste0(inputId, "_state"), list(id = inputId))
}
