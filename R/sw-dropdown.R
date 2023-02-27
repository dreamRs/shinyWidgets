#' @title Dropdown
#'
#' @description
#' Create a dropdown menu
#'
#' @param ... List of tag to be displayed into the dropdown menu.
#' @inheritParams actionBttn
#' @param status Color of the button, see [actionBttn()].
#' @param tooltip Put a tooltip on the button, you can customize tooltip with [tooltipOptions()].
#' @param right Logical. The dropdown menu starts on the right.
#' @param up Logical. Display the dropdown menu above.
#' @param width Width of the dropdown menu content.
#' @param animate Add animation on the dropdown, can be logical or result of [animateOptions()].
#' @param inputId Optional, id for the button, the button act like an \code{actionButton},
#' and you can use the id to toggle the dropdown menu server-side.
#'
#' @details
#' This function is similar to [dropdownButton()] but don't use Bootstrap, so you can use [pickerInput()] in it.
#' Moreover you can add animations on the appearance / disappearance of the dropdown with animate.css.
#'
#' @seealso [dropMenu()] for a more robust alternative.
#'
#' @importFrom htmltools validateCssUnit tagList singleton tags tagAppendChild
#'
#' @export
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'
#' library("shiny")
#' library("shinyWidgets")
#'
#' ui <- fluidPage(
#'   tags$h2("pickerInput in dropdown"),
#'   br(),
#'   dropdown(
#'
#'     tags$h3("List of Input"),
#'
#'     pickerInput(inputId = 'xcol2',
#'                 label = 'X Variable',
#'                 choices = names(iris),
#'                 options = list(`style` = "btn-info")),
#'
#'     pickerInput(inputId = 'ycol2',
#'                 label = 'Y Variable',
#'                 choices = names(iris),
#'                 selected = names(iris)[[2]],
#'                 options = list(`style` = "btn-warning")),
#'
#'     sliderInput(inputId = 'clusters2',
#'                 label = 'Cluster count',
#'                 value = 3,
#'                 min = 1, max = 9),
#'
#'     style = "unite", icon = icon("gear"),
#'     status = "danger", width = "300px",
#'     animate = animateOptions(
#'       enter = animations$fading_entrances$fadeInLeftBig,
#'       exit = animations$fading_exits$fadeOutRightBig
#'     )
#'   ),
#'
#'   plotOutput(outputId = 'plot2')
#' )
#'
#' server <- function(input, output, session) {
#'
#'   selectedData2 <- reactive({
#'     iris[, c(input$xcol2, input$ycol2)]
#'   })
#'
#'   clusters2 <- reactive({
#'     kmeans(selectedData2(), input$clusters2)
#'   })
#'
#'   output$plot2 <- renderPlot({
#'     palette(c("#E41A1C", "#377EB8", "#4DAF4A",
#'               "#984EA3", "#FF7F00", "#FFFF33",
#'               "#A65628", "#F781BF", "#999999"))
#'
#'     par(mar = c(5.1, 4.1, 0, 1))
#'     plot(selectedData2(),
#'          col = clusters2()$cluster,
#'          pch = 20, cex = 3)
#'     points(clusters2()$centers, pch = 4, cex = 4, lwd = 4)
#'   })
#'
#' }
#'
#' shinyApp(ui = ui, server = server)
#'
#' }
dropdown <- function(...,
                     style = "default",
                     status = "default",
                     size = "md",
                     icon = NULL,
                     label = NULL,
                     tooltip = FALSE,
                     right = FALSE,
                     up = FALSE,
                     width = NULL,
                     animate = FALSE,
                     inputId = NULL,
                     block = FALSE,
                     no_outline = TRUE) {


  if (is.null(inputId)) {
    inputId <- paste0("btn-", sample.int(1e9, 1))
  }
  dropId <- paste0("sw-drop-", inputId)
  contentId <- paste0("sw-content-", inputId)

  # Tooltip
  if (identical(tooltip, TRUE))
    tooltip <- tooltipOptions(title = label)
  has_tooltip <- !is.null(tooltip) && !identical(tooltip, FALSE)

  # Dropdown content
  dropcontent <- htmltools::tags$div(
    id = contentId,
    class = "sw-dropdown-content animated",
    class = if (up) "sw-dropup-content",
    class = if (right) "sw-dropright-content",
    style = htmltools::css(width = htmltools::validateCssUnit(width)),
    htmltools::tags$div(class = "sw-dropdown-in", ...)
  )
  # Button
  if (style == "default") {
    btn <- tags$button(
      class = paste0(
        "btn btn-", status," ",
        ifelse(size == "default" | size == "md", "", paste0("btn-", size))
      ),
      class = "action-button",
      type = "button", id = inputId, list(icon, label),
      htmltools::tags$span(
        class = ifelse(
          test = up,
          yes = "glyphicon glyphicon-triangle-top",
          no = "glyphicon glyphicon-triangle-bottom"
        )
      )
    )
  } else {
    btn <- actionBttn(
      inputId = inputId,
      label = label,
      icon = icon,
      style = style,
      color = status,
      size = size,
      block = block,
      no_outline = no_outline
    )
  }

  if (has_tooltip) {
    btn <- htmltools::tagAppendAttributes(
      btn,
      `data-bs-toggle` = "tooltip",
      `data-bs-title` = tooltip$title,
      `data-bs-placement` = tooltip$placement,
      `data-bs-html` = tolower(tooltip$html)
    )
  }

  # Final tag
  dropdownTag <- htmltools::tags$div(class = "sw-dropdown", id = dropId, btn, dropcontent)

  if (has_tooltip) {
    tooltip <- lapply(tooltip, function(x) {
      if (identical(x, TRUE))
        "true"
      else if (identical(x, FALSE))
        "false"
      else x
    })
    tooltipJs <- htmltools::tagFunction(function() {
      theme <- shiny::getCurrentTheme()
      if (!bslib::is_bs_theme(theme)) {
        return(dropdown_tooltip_bs3(inputId, tooltip))
      }
      if (bslib::theme_version(theme) %in% c("5")) {
        return(dropdown_tooltip_bs5(inputId, tooltip))
      }
      dropdown_tooltip_bs3(inputId, tooltip)
    })
    dropdownTag <- htmltools::tagAppendChild(dropdownTag, tooltipJs)
  }

  # Animate
  if (identical(animate, TRUE))
    animate <- animateOptions()

  if (!is.null(animate) && !identical(animate, FALSE)) {
    dropdownTag <- htmltools::tagAppendChild(
      dropdownTag, htmltools::tags$script(
        sprintf(
          "$(function() {swDrop('%s', '%s', '%s', '%s', '%s', '%s');});",
          inputId, contentId, dropId,
          animate$enter, animate$exit, as.character(animate$duration)
        )
      )
    )
    dropdownTag <- attachShinyWidgetsDep(dropdownTag, "animate")
  } else {
    dropdownTag <- htmltools::tagAppendChild(
      dropdownTag, htmltools::tags$script(
        sprintf(
          "$(function() {swDrop('%s', '%s', '%s', '%s', '%s', '%s');});",
          inputId, contentId, dropId, "sw-none", "sw-none", "1"
        )
      )
    )
  }

  attachShinyWidgetsDep(dropdownTag, "sw-dropdown")
}



dropdown_tooltip_bs3 <- function(inputId, tooltip) {
  htmltools::tags$script(
    sprintf(
      "$('#%s').tooltip({ placement: '%s', title: '%s', html: %s });",
      inputId, tooltip$placement, tooltip$title, tooltip$html
    )
  )
}

dropdown_tooltip_bs5 <- function(inputId, tooltip) {
  htmltools::tags$script(
    sprintf("const el = document.getElementById('%s');", inputId),
    "new bootstrap.Tooltip(el);"
  )
}




#' Animate options
#'
#' @param enter Animation name on appearance
#' @param exit Animation name on disappearance
#' @param duration Duration of the animation
#'
#' @return a list
#' @export
#'
#' @seealso \code{\link{animations}}
#'
#'
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'
#' dropdown(
#'  "Your contents goes here ! You can pass several elements",
#'  circle = TRUE, status = "danger", icon = icon("gear"), width = "300px",
#'  animate = animateOptions(enter = "fadeInDown", exit = "fadeOutUp", duration = 3)
#' )
#'
#' }
animateOptions <- function(enter = "fadeInDown", exit = "fadeOutUp", duration = 1) {
  list(enter = enter, exit = exit, duration = duration)
}





#' @title Animation names
#'
#' @description List of all animations by categories
#'
#' @format A list of lists
#' @source \url{https://github.com/animate-css/animate.css}
"animations"





