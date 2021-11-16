#' @title Palette Color Picker with Spectrum Library
#'
#' @description A widget to select a color within palettes, and with more options if needed.
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label Display label for the control, or \code{NULL} for no label.
#' @param choices List of colors to display in the menu.
#' @param selected The initially selected value.
#' @param flat Display the menu inline.
#' @param options Additional options to pass to spectrum,
#'  possible values are described here : \url{https://bgrins.github.io/spectrum/#options}.
#' @param update_on When to update value server-side: \code{"move"} (default, each time a new color is selected),
#'  \code{"dragstop"} (when use user stop dragging cursor), \code{"change"} (when the input is closed).
#' @param width The width of the input, e.g. `400px`, or `100%`.
#'
#'
#' @return The selected color in Hex format server-side
#' @export
#'
#' @importFrom htmltools validateCssUnit tagAppendChild findDependencies tags
#' @importFrom shiny restoreInput
#' @importFrom jsonlite toJSON
#' @importFrom utils modifyList
#'
#' @examples
#' if (interactive()) {
#'
#' library("shiny")
#' library("shinyWidgets")
#' library("scales")
#'
#' ui <- fluidPage(
#'   tags$h1("Spectrum color picker"),
#'
#'   br(),
#'
#'   spectrumInput(
#'     inputId = "myColor",
#'     label = "Pick a color:",
#'     choices = list(
#'       list('black', 'white', 'blanchedalmond', 'steelblue', 'forestgreen'),
#'       as.list(brewer_pal(palette = "Blues")(9)),
#'       as.list(brewer_pal(palette = "Greens")(9)),
#'       as.list(brewer_pal(palette = "Spectral")(11)),
#'       as.list(brewer_pal(palette = "Dark2")(8))
#'     ),
#'     options = list(`toggle-palette-more-text` = "Show more")
#'   ),
#'   verbatimTextOutput(outputId = "res")
#'
#' )
#'
#' server <- function(input, output, session) {
#'
#'   output$res <- renderPrint(input$myColor)
#'
#' }
#'
#' shinyApp(ui, server)
#'
#' }
spectrumInput <- function(inputId, label, choices = NULL, selected = NULL,
                          flat = FALSE, options = list(),
                          update_on = c("move", "dragstop", "change"),
                          width = NULL) {
  selected <- shiny::restoreInput(id = inputId, default = selected)
  update_on <- match.arg(update_on)
  selected <- if (is.null(selected)) {
    unlist(choices, recursive = TRUE)[1]
  } else {
    as.character(selected)
  }
  if (length(options) > 0) {
    if (any(names(options) %in% "")) {
      stop("All 'options' must be named", call. = FALSE)
    }
    names(options) <- paste0("data-", names(options))
  }
  spectrumProps <- dropNulls(list(
    type = "text",
    id = inputId,
    class = "form-control sw-spectrum",
    `data-flat` = flat,
    `data-color` = selected,
    `data-palette` = if (!is.null(choices)) jsonlite::toJSON(choices, auto_unbox = TRUE),
    `data-toggle-palette-only` = !is.null(choices),
    `data-show-palette-only` = !is.null(choices),
    `data-show-palette` = !is.null(choices),
    `data-replacer-class-name` = "sw-spectrum btn-spectrum",
    `data-container-class-name` = "sw-spectrum",
    `data-update-on` = update_on
  ))
  spectrumProps <- utils::modifyList(x = spectrumProps, val = options)
  spectrumProps <- lapply(spectrumProps, function(x) {
    if (identical(x, TRUE))
      "true"
    else if (identical(x, FALSE))
      "false"
    else x
  })
  spectrumTag <- htmltools::tags$div(
    class = "form-group shiny-input-container",
    class = if (flat) "shiny-input-container-inline",
    style = if (!is.null(width))
      paste0("width: ", htmltools::validateCssUnit(width), ";"),
    htmltools::tags$label(label, `for` = inputId),
    if (flat) htmltools::tags$br(),
    do.call(htmltools::tags$input, spectrumProps)
  )
  attachShinyWidgetsDep(spectrumTag, "spectrum")
}



#' Change the value of a spectrum input on the client
#'
#' @param session The session object passed to function given to shinyServer.
#' @param inputId The id of the input object.
#' @param selected The value to select.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'
#' library("shiny")
#' library("shinyWidgets")
#'
#' ui <- fluidPage(
#'   tags$h1("Spectrum color picker"),
#'
#'   br(),
#'
#'   spectrumInput(
#'     inputId = "myColor",
#'     label = "Pick a color:",
#'     choices = list(
#'       list('black', 'white', 'blanchedalmond', 'steelblue', 'forestgreen')
#'     )
#'   ),
#'   verbatimTextOutput(outputId = "res"),
#'   radioButtons(
#'     inputId = "update", label = "Update:",
#'     choices = c(
#'       'black', 'white', 'blanchedalmond', 'steelblue', 'forestgreen'
#'     )
#'
#'   )
#'
#' )
#'
#' server <- function(input, output, session) {
#'
#'   output$res <- renderPrint(input$myColor)
#'
#'   observeEvent(input$update, {
#'     updateSpectrumInput(session = session, inputId = "myColor", selected = input$update)
#'   }, ignoreInit = TRUE)
#'
#' }
#'
#' shinyApp(ui, server)
#'
#' }
updateSpectrumInput <- function(session = getDefaultReactiveDomain(),
                                inputId,
                                selected) {
  session$sendInputMessage(inputId, list(value = selected))
}



