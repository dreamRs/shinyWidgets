#
# #' @title Load sweetAlert libs in a shiny apps
# #'
# #' @description
# #' Load sweetAlert libs in a shiny apps.
# #'
# #' @importFrom htmltools htmlDependency attachDependencies
# #'
# #' @export
#
# useSweetAlert <- function() {
#   tagSweet <- tags$div()
#   dep <- htmltools::htmlDependency(
#     "sweetAlert", "0.1.0", c(href="shinyWidgets"),
#     script = "sweetAlert/js/sweetalert.min.js",
#     stylesheet = "sweetAlert/css/sweetalert.css"
#   )
#   htmltools::attachDependencies(tagSweet, dep)
# }




#' @title Load Sweet Alert dependencies
#'
#' @description
#' This function is useless for \code{sendSweetAlert}, \code{confirmSweetAlert},
#'  \code{inputSweetAlert}, but is still needed for \code{progressSweetAlert}.
#'
# @param messageId The sweet alert id.
#'
#'
#' @note Use \code{receiveSweetAlert()} in the UI and \code{sendSweetAlert()} in the server.
#'
#' @seealso \code{\link{sendSweetAlert}}, \code{\link{confirmSweetAlert}}, \code{\link{inputSweetAlert}}
#'
#'
#' @export
useSweetAlert <- function() {
  # js <- "Shiny.addCustomMessageHandler('sweetalert-sw', function(data) {swal(data)});"
  # tagSweet <- htmltools::tags$script(js)
  # message("You don't need useSweetAlert() anymore, SweetAlert function works directly from the server.")
  attachShinyWidgetsDep(tags$span(id = "sw-sa-deps"), "sweetalert")
}

#' @importFrom htmltools singleton
use_sweet_alert <- function() {
  tag_sa <- htmltools::singleton(tags$span(id = "sw-sa-deps"))
  attachShinyWidgetsDep(tag_sa, "sweetalert")
}



#' @title Display a Sweet Alert to the user
#'
#' @description
#' Send a message from the server and launch a sweet alert in the UI.
#'
#' @param session The \code{session} object passed to function given to shinyServer.
#' @param title Title of the alert.
#' @param text Text of the alert.
#' @param type Type of the alert : info, success, warning or error.
#' @param btn_labels Label(s) for button(s), can be of length 2,
#' in which case the alert will have two buttons.
#' @param html Does \code{text} contains HTML tags ?
#' @param closeOnClickOutside Decide whether the user should be able to dismiss
#'  the modal by clicking outside of it, or not.
#'
# @seealso \code{\link{receiveSweetAlert}}
#'
#' @importFrom jsonlite toJSON
#' @importFrom htmltools tags
#' @importFrom shiny insertUI
#'
#' @export
#'
#' @seealso \code{\link{confirmSweetAlert}}, \code{\link{inputSweetAlert}}
#'
#' @examples
#' \dontrun{
#' if (interactive()) {
#'
#' library(shiny)
#' library(shinyWidgets)
#'
#' ui <- fluidPage(
#'   tags$h2("Sweet Alert examples"),
#'   actionButton(
#'     inputId = "success",
#'     label = "Launch a success sweet alert",
#'     icon = icon("check")
#'   ),
#'   actionButton(
#'     inputId = "error",
#'     label = "Launch an error sweet alert",
#'     icon = icon("remove")
#'   ),
#'   actionButton(
#'     inputId = "sw_html",
#'     label = "Sweet alert with HTML",
#'     icon = icon("thumbs-up")
#'   )
#' )
#'
#' server <- function(input, output, session) {
#'
#'   observeEvent(input$success, {
#'     sendSweetAlert(
#'       session = session,
#'       title = "Success !!",
#'       text = "All in order",
#'       type = "success"
#'     )
#'   })
#'
#'   observeEvent(input$error, {
#'     sendSweetAlert(
#'       session = session,
#'       title = "Error !!",
#'       text = "It's broken...",
#'       type = "error"
#'     )
#'   })
#'
#'   observeEvent(input$sw_html, {
#'     sendSweetAlert(
#'       session = session,
#'       title = NULL,
#'       text = tags$span(
#'         tags$h3("With HTML tags",
#'                 style = "color: steelblue;"),
#'         "In", tags$b("bold"), "and", tags$em("italic"),
#'         tags$br(),
#'         "and",
#'         tags$br(),
#'         "line",
#'         tags$br(),
#'         "breaks",
#'         tags$br(),
#'         "and an icon", icon("thumbs-up")
#'       ),
#'       html = TRUE
#'     )
#'   })
#'
#' }
#'
#' shinyApp(ui, server)
#'
#'
#' # output in Sweet Alert #
#'
#' library("shiny")
#' library("shinyWidgets")
#'
#' shinyApp(
#'   ui = fluidPage(
#'     tags$h1("Click the button"),
#'     actionButton(
#'       inputId = "sw_html",
#'       label = "Sweet alert with plot"
#'     ),
#'     # SweetAlert width
#'     tags$style(".swal-modal {width: 80%;}")
#'   ),
#'   server = function(input, output, session) {
#'     observeEvent(input$sw_html, {
#'       sendSweetAlert(
#'         session = session,
#'         title = "Yay a plot!",
#'         text = tags$div(
#'           plotOutput(outputId = "plot"),
#'           sliderInput(
#'             inputId = "clusters",
#'             label = "Number of clusters",
#'             min = 2, max = 6, value = 3, width = "100%"
#'           )
#'         ),
#'         html = TRUE
#'       )
#'     })
#'     output$plot <- renderPlot({
#'       plot(Sepal.Width ~ Sepal.Length,
#'            data = iris, col = Species,
#'            pch = 20, cex = 2)
#'       points(kmeans(iris[, 1:2], input$clusters)$centers,
#'              pch = 4, cex = 4, lwd = 4)
#'     })
#'   }
#' )
#'
#' }
#' }
sendSweetAlert <- function(session, title = "Title", text = NULL,
                            type = NULL, btn_labels = "Ok", html = FALSE,
                           closeOnClickOutside = TRUE) {
  insertUI(
    selector = "body", where = "afterBegin",
    ui = use_sweet_alert(), immediate = TRUE, session = session
  )
  if (is.null(type))
    type <- jsonlite::toJSON(NULL, auto_unbox = TRUE, null = "null")
  if ("shiny.tag" %in% class(text))
    html <- TRUE
  if (!html) {
    text <- as.character(text)
    if (length(text) < 1)
      text <- NULL
    text <- jsonlite::toJSON(text, auto_unbox = TRUE, null = "null")
    session$sendCustomMessage(
      type = "sweetalert-sw",
      message = list(title = title, text = text, icon = type,
                     buttons = btn_labels, as_html = html,
                     closeOnClickOutside = closeOnClickOutside)
    )
  } else {
    id <- paste0("placeholder-", sample.int(1e6, 1))
    session$sendCustomMessage(
      type = "sweetalert-sw",
      message = list(
        title = title, icon = type, sw_id = id,
        text = as.character(tags$div(id = id)),
        buttons = btn_labels, as_html = html,
        closeOnClickOutside = closeOnClickOutside
      )
    )
    insertUI(
      session = session, selector = paste0("#", id),
      ui = text, immediate = TRUE
    )
  }
}



#' @title Launch a confirmation dialog
#'
#' @description Launch a popup to ask confirmation to the user
#'
#' @param session The \code{session} object passed to function given to shinyServer.
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param title Title of the alert.
#' @param text Text of the alert, can contains HTML tags.
#' @param type Type of the alert : info, success, warning or error.
#' @param btn_labels Labels for buttons.
#' @param danger_mode Logical, activate danger mode (focus on cancel button).
#' @param closeOnClickOutside Decide whether the user should be able to dismiss
#'  the modal by clicking outside of it, or not.
#' @param html Does \code{text} contains HTML tags ?
#'
# @seealso \code{\link{receiveSweetAlert}}
#'
#' @importFrom jsonlite toJSON
#' @importFrom htmltools tags
#' @importFrom shiny insertUI
#'
#' @export
#'
#' @seealso \code{\link{sendSweetAlert}}, \code{\link{inputSweetAlert}}
#'
#' @examples
#'
#' \dontrun{
#'
#' if (interactive()) {
#'
#' library("shiny")
#' library("shinyWidgets")
#'
#'
#' ui <- fluidPage(
#'   tags$h1("Confirm sweet alert"),
#'   actionButton(
#'     inputId = "launch1",
#'     label = "Launch confirmation dialog (with danger mode)"
#'   ),
#'   verbatimTextOutput(outputId = "res1"),
#'   tags$br(),
#'   actionButton(
#'     inputId = "launch2",
#'     label = "Launch confirmation dialog (with normal mode)"
#'   ),
#'   verbatimTextOutput(outputId = "res2"),
#'   tags$br(),
#'   actionButton(
#'     inputId = "launch3",
#'     label = "Launch confirmation dialog (with HTML)"
#'   ),
#'   verbatimTextOutput(outputId = "res3")
#' )
#'
#' server <- function(input, output, session) {
#'
#'   observeEvent(input$launch1, {
#'     confirmSweetAlert(
#'       session = session,
#'       inputId = "myconfirmation1",
#'       type = "warning",
#'       title = "Want to confirm ?",
#'       danger_mode = TRUE
#'     )
#'   })
#'   output$res1 <- renderPrint(input$myconfirmation1)
#'
#'   observeEvent(input$launch2, {
#'     confirmSweetAlert(
#'       session = session,
#'       inputId = "myconfirmation2",
#'       type = "warning",
#'       title = "Are you sure ??",
#'       btn_labels = c("Nope", "Yep"),
#'       danger_mode = FALSE
#'     )
#'   })
#'   output$res2 <- renderPrint(input$myconfirmation2)
#'
#'   observeEvent(input$launch3, {
#'     confirmSweetAlert(
#'       session = session,
#'       inputId = "myconfirmation3",
#'       title = NULL,
#'       text = tags$b(
#'         icon("file"),
#'         "Do you really want to delete this file ?",
#'         style = "color: #FA5858;"
#'       ),
#'       btn_labels = c("Cancel", "Delete file"),
#'       danger_mode = TRUE, html = TRUE
#'     )
#'   })
#'   output$res3 <- renderPrint(input$myconfirmation3)
#'
#' }
#'
#' shinyApp(ui = ui, server = server)
#'
#' }
#'
#' }
confirmSweetAlert <- function(session, inputId, title = NULL, text = NULL,
                              type = NULL, danger_mode = FALSE,
                              btn_labels = c("Cancel", "Confirm"),
                              closeOnClickOutside = FALSE, html = FALSE) {
  insertUI(
    selector = "body", where = "afterBegin",
    ui = use_sweet_alert(), immediate = TRUE,
    session = session
  )
  if (is.null(type))
    type <- jsonlite::toJSON(NULL, auto_unbox = TRUE, null = "null")
  if ("shiny.tag" %in% class(text))
    html <- TRUE
  if (!html) {
    text <- jsonlite::toJSON(text, auto_unbox = TRUE, null = "null")
    session$sendCustomMessage(
      type = "sweetalert-sw-confirm",
      message = list(
        id = inputId, title = title, text = text, icon = type,
        buttons = btn_labels, dangerMode = danger_mode,
        closeOnClickOutside = closeOnClickOutside
      )
    )
  } else {
    id <- paste0("placeholder-", sample.int(1e6, 1))
    session$sendCustomMessage(
      type = "sweetalert-sw-confirm",
      message = list(
        id = inputId,
        title = title, icon = type, sw_id = id,
        text = as.character(tags$div(id = id)),
        buttons = btn_labels, as_html = html,
        dangerMode = danger_mode,
        closeOnClickOutside = closeOnClickOutside
      )
    )
    insertUI(
      session = session,
      selector = paste0("#", id),
      ui = text, immediate = TRUE
    )
  }
}



#' @title Launch an input text dialog
#'
#' @description Launch a popup with a text input
#'
#' @param session The \code{session} object passed to function given to shinyServer.
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param title Title of the alert.
#' @param text Text of the alert.
#' @param type Type of the alert : info, success, warning or error.
#' @param btn_labels Labels for button(s).
#' @param placeholder A character string giving the user a hint as to
#' what can be entered into the control.
#'
# @seealso \code{\link{receiveSweetAlert}}
#'
#' @importFrom jsonlite toJSON
#' @importFrom htmltools tags
#' @importFrom shiny insertUI
#'
#' @export
#'
#' @seealso \code{\link{sendSweetAlert}}, \code{\link{confirmSweetAlert}}
#'
#' @examples
#' \dontrun{
#'
#' if (interactive()) {
#'
#' library("shiny")
#' library("shinyWidgets")
#'
#'
#' ui <- fluidPage(
#'   tags$h1("Confirm sweet alert"),
#'   actionButton(inputId = "go", label = "Launch input text dialog"),
#'   verbatimTextOutput(outputId = "res")
#' )
#' server <- function(input, output, session) {
#'
#'   observeEvent(input$go, {
#'     inputSweetAlert(
#'       session = session, inputId = "mytext",
#'       title = "What's your name ?"
#'     )
#'   })
#'
#'   output$res <- renderPrint(input$mytext)
#'
#' }
#'
#' shinyApp(ui = ui, server = server)
#'
#' }
#'
#' }
inputSweetAlert <- function(session, inputId, title = NULL, text = NULL,
                            type = NULL, btn_labels = "Ok",
                            placeholder = NULL) {
  shiny::insertUI(
    selector = "body", where = "afterBegin",
    ui = use_sweet_alert(), immediate = TRUE,
    session = session
  )
  if (is.null(type))
    type <- jsonlite::toJSON(NULL, auto_unbox = TRUE, null = "null")
  text <- jsonlite::toJSON(text, auto_unbox = TRUE, null = "null")
  content <- list(element = "input")
  if (!is.null(placeholder))
    content$attributes$placeholder <- placeholder
  session$sendCustomMessage(
    type = "sweetalert-sw-input",
    message = list(
      id = inputId, title = title, text = text,
      icon = type, buttons = btn_labels,
      content = content
    )
  )
}



#' Progress bar in a sweet alert
#'
#' @param session The \code{session} object passed to function given to shinyServer.
#' @param id An id used to update the progress bar.
#' @param value Value of the progress bar between 0 and 100, if >100 you must provide total.
#' @param total Used to calculate percentage if value > 100, force an indicator to appear on top right of the progress bar.
#' @param display_pct logical, display percentage on the progress bar.
#' @param size Size, `NULL` by default or a value in 'xxs', 'xs', 'sm', only work with package `shinydashboard`.
#' @param status Color, must be a valid Bootstrap status : primary, info, success, warning, danger.
#' @param striped logical, add a striped effect.
#' @param title character, optional title.
#'
#' @export
#'
#' @examples
#' \dontrun{
#'
#' if (interactive()) {
#'
#' library("shiny")
#' library("shinyWidgets")
#'
#'
#' ui <- fluidPage(
#'   tags$h1("Progress bar in Sweet Alert"),
#'   useSweetAlert(), # /!\ needed with 'progressSweetAlert'
#'   actionButton(
#'     inputId = "go",
#'     label = "Launch long calculation !"
#'   )
#' )
#'
#' server <- function(input, output, session) {
#'
#'   observeEvent(input$go, {
#'     progressSweetAlert(
#'       session = session, id = "myprogress",
#'       title = "Work in progress",
#'       display_pct = TRUE, value = 0
#'     )
#'     for (i in seq_len(50)) {
#'       Sys.sleep(0.1)
#'       updateProgressBar(
#'         session = session,
#'         id = "myprogress",
#'          value = i*2
#'       )
#'     }
#'     closeSweetAlert(session = session)
#'     sendSweetAlert(
#'       session = session,
#'       title =" Calculation completed !",
#'       type = "success"
#'     )
#'   })
#'
#' }
#'
#' shinyApp(ui = ui, server = server)
#'
#' }
#'
#' }
progressSweetAlert <- function(session, id, value, total = NULL,
                               display_pct = FALSE, size = NULL,
                               status = NULL, striped = FALSE, title = NULL) {
  sendSweetAlert(
    session = session,
    title = NULL, btn_labels = FALSE,
    text = tags$div(id = "sweet-alert-progress-sw"),
    closeOnClickOutside = FALSE
  )
  shiny::insertUI(
    selector = "#sweet-alert-progress-sw",
    ui = progressBar(
      id, value, total, display_pct, size, status, striped, title
    ),
    immediate = TRUE, session = session
  )
}







#' Close Sweet Alert
#'
#' @param session The \code{session} object passed to function given
#' to shinyServer.
#'
#' @export
#'
closeSweetAlert <- function(session) {
  session$sendCustomMessage(
    type = "sweetalert-sw-close",
    message = list()
  )
}
