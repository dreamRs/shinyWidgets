#' @title Color Selector Input
#'
#' @description Choose between a restrictive set of colors.
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label Display label for the control, or \code{NULL} for no label.
#' @param choices A list of colors, can be a list of named list, see example.
#' @param selected Default selected color, if \code{NULL} the first color for \code{mode = 'radio'}
#'  and none for \code{mode = 'checkbox'}
#' @param mode \code{'radio'} for only one choice, \code{'checkbox'} for
#'  selecting multiple values.
#' @param display_label Display list's names after palette of color.
#' @param ncol If choices is not a list but a vector, go to line after n elements.
#'
#' @importFrom htmltools tags tagList
#' @export
#'
#' @examples
#' if (interactive()) {
#'
#' # Full example
#' colorSelectorExample()
#'
#' # Simple example
#' ui <- fluidPage(
#'   colorSelectorInput(
#'     inputId = "mycolor1", label = "Pick a color :",
#'     choices = c("steelblue", "cornflowerblue",
#'                 "firebrick", "palegoldenrod",
#'                 "forestgreen")
#'   ),
#'   verbatimTextOutput("result1")
#' )
#'
#' server <- function(input, output, session) {
#'   output$result1 <- renderPrint({
#'     input$mycolor1
#'   })
#' }
#'
#' shinyApp(ui = ui, server = server)
#'
#' }
colorSelectorInput <- function(inputId,
                               label,
                               choices,
                               selected = NULL,
                               mode = c("radio", "checkbox"),
                               display_label = FALSE,
                               ncol = 10) {
  selected <- shiny::restoreInput(id = inputId, default = selected)
  mode <- match.arg(arg = mode)
  if (!is.list(choices))
    choices <- split(x = choices, f = (seq_along(choices) - 1) %/% ncol)
  choices <- choicesWithNames(choices)
  if (!is.null(selected) && length(selected) > 1)
    stop("selected must be length 1")
  if (is.null(selected) & mode == "radio")
    selected <- firstChoice(choices)
  tagCS <- htmltools::tags$div(
    class = "shiny-input-container-inline form-group",
    class = paste0(mode, "-group-buttons"),
    `data-toggle`="buttons",
    id = inputId,
    style = "margin-top: 3px; margin-bottom: 10px; ",
    if (!is.null(label)) htmltools::tagList(htmltools::tags$label(class="control-label", label), htmltools::tags$br()),
    colorOptions(
      inputId = inputId,
      choices = choices,
      selected = selected,
      mode = mode,
      display_label = display_label
    )
  )
  attachShinyWidgetsDep(tagCS)
}




colorOptions <- function(inputId, choices, selected = NULL, mode = "radio", display_label = FALSE) {
  html <- lapply(seq_along(choices), FUN = function(i) {
    label <- names(choices)[i]
    choice <- choices[[i]]
    if (is.list(choice)) {
      htmltools::tagList(
        htmltools::tags$div(
          class="btn-group",
          colorOptions(inputId, choice, selected, mode, display_label)
        ), if (display_label) htmltools::tags$em(htmltools::HTML(names(choices)[i])),
        htmltools::tags$br()
      )
    }
    else {
      htmltools::tagList(
        htmltools::tags$span(
          class = "btn btn-color-sw", type="button",
          style = paste("background-color:", choice),
          htmltools::tags$input(
            type=mode, name=inputId, value=choice, id=choice,
            checked = if (choice %in% selected) "checked"
          )
        )
      )
    }
  })
  return(htmltools::tagList(html))
}





#' @title Color Selector Example
#'
#' @export
#' @importFrom shiny shinyAppFile
#'
#' @describeIn colorSelectorInput Examples of use for colorSelectorInput
colorSelectorExample <- function() {

  if (!requireNamespace(package = "grDevices"))
    message("Package 'grDevices' is required to run this function")

  shiny::shinyAppFile(
    appFile = system.file("examples/colorSelector/example.R", package = "shinyWidgets"),
    options = list("display.mode" = "showcase")
  )
}








#' @title Color Selector In A Dropdown
#'
#' @param circle Logical, use a circle or a square button
#' @param size Size of the button : default, lg, sm, xs.
#' @param up Logical. Display the dropdown menu above.
#' @param width Width of the dropdown menu content.
#'
#' @export
#' @describeIn colorSelectorInput Display a colorSelector in a dropdown button
#' @importFrom htmltools tags validateCssUnit
colorSelectorDrop <- function(inputId,
                              label,
                              choices,
                              selected = NULL,
                              display_label = FALSE,
                              ncol = 10,
                              circle = TRUE,
                              size = "sm",
                              up = FALSE,
                              width = NULL) {
  size <- match.arg(arg = size, choices = c("default", "lg", "sm", "xs"))
  btnId <- paste("btn", inputId, sep = "-")
  funButton <- if (circle) circleButton else squareButton
  btn <- funButton(
    inputId = btnId, icon = NULL, status = "default", size = size,
    class = "dropdown-toggle", `data-toggle` = "dropdown"
  )
  dropTag <- htmltools::tags$ul(
    class = "dropdown-menu",
    style = if (!is.null(width))
      paste0("width: ", htmltools::validateCssUnit(width), ";"),
    colorSelectorInput(
      inputId = inputId,
      label = label,
      choices = choices,
      selected = selected,
      mode = "radio",
      display_label = display_label,
      ncol = ncol
    )
  )
  js <- paste0(
    '$(document).on("change","input[name=\'', inputId, '\']",function(){
      var v = $("input[name=\'', inputId, '\']:checked").val();
      $("#', btnId, '").css("background-color", v);
    });'
  )
  htmltools::tags$div(
    class = ifelse(up, "dropup", "dropdown"),
    btn, dropTag, htmltools::tags$script(HTML(js))
  )
}






