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
#'     label = "Launch a success sweet alert"
#'   ),
#'   actionButton(
#'     inputId = "error",
#'     label = "Launch an error sweet alert"
#'   ),
#'   actionButton(
#'     inputId = "sw_html",
#'     label = "Sweet alert with HTML"
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
#'       title = "Success !!",
#'       text = tags$span(
#'         "In", tags$b("bold"), "and", tags$em("italic"),
#'         tags$br(),
#'         "and",
#'         tags$br(),
#'         "line",
#'         tags$br(),
#'         "breaks"
#'       ),
#'       html = TRUE,
#'       type = "success"
#'     )
#'   })
#'
#' }
#'
#' shinyApp(ui, server)
#'
#' }
#' }
sendSweetAlert <- function(session, title = "Title", text = NULL,
                            type = NULL, btn_labels = "Ok", html = FALSE,
                           closeOnClickOutside = TRUE) {
  shiny::insertUI(selector = "body", where = "afterBegin", ui =
                    use_sweet_alert(), immediate = TRUE)
  if (is.null(type))
    type <- jsonlite::toJSON(NULL, auto_unbox = TRUE, null = "null")
  if ("shiny.tag" %in% class(text))
    html <- TRUE
  text <- as.character(text)
  if (length(text) < 0)
    text <- NULL
  text <- jsonlite::toJSON(text, auto_unbox = TRUE, null = "null")
  session$sendCustomMessage(
    type = "sweetalert-sw",
    message = list(title = title, text = text, icon = type,
                   buttons = btn_labels, as_html = html,
                   closeOnClickOutside = closeOnClickOutside)
  )
}



#' @title Launch a confirmation dialog
#'
#' @description Launch a popup to ask confirmation to the user
#'
#' @param session The \code{session} object passed to function given to shinyServer.
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param title Title of the alert.
#' @param text Text of the alert.
#' @param type Type of the alert : info, success, warning or error.
#' @param btn_labels Labels for buttons.
#' @param danger_mode Logical, activate danger mode (focus on cancel button).
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
#'     inputId = "go",
#'     label = "Launch confirmation dialog"
#'   ),
#'   verbatimTextOutput(outputId = "res")
#' )
#'
#' server <- function(input, output, session) {
#'
#'  observeEvent(input$go, {
#'    confirmSweetAlert(
#'      session = session, inputId = "myconfirmation", type = "warning",
#'      title = "Want to confirm ?", danger_mode = TRUE
#'    )
#'  })
#'
#'   output$res <- renderPrint(input$myconfirmation)
#'
#' }
#'
#' shinyApp(ui = ui, server = server)
#'
#' }
#'
#' }
confirmSweetAlert <- function(session, inputId, title = "Are you sure ?", text = NULL,
                              type = NULL, danger_mode = FALSE,
                              btn_labels = c("Cancel", "Confirm")) {
  shiny::insertUI(selector = "body", where = "afterBegin", ui =
                    use_sweet_alert(), immediate = TRUE)
  if (is.null(type))
    type <- jsonlite::toJSON(NULL, auto_unbox = TRUE, null = "null")
  text <- jsonlite::toJSON(text, auto_unbox = TRUE, null = "null")
  session$sendCustomMessage(
    type = "sweetalert-sw-confirm",
    message = list(id = inputId, title = title, text = text, icon = type,
                   buttons = btn_labels, dangerMode = danger_mode)
  )
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
  shiny::insertUI(selector = "body", where = "afterBegin", ui =
                    use_sweet_alert(), immediate = TRUE)
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
  pbui <- progressBar(
    id, value, total, display_pct, size, status, striped, title
  )
  pbui <- htmltools::tagList(
    # use_sweet_alert(),
    htmltools::singleton(
      tags$div(
        id = paste0("sa-pb", id),
        style = "display: none;",
        pbui
      )
    )
  )
  shiny::insertUI(
    selector = "body", ui = pbui,
    where = "afterBegin",
    immediate = TRUE
  )
  session$sendCustomMessage(
    type = "sweetalert-sw-progress",
    message = list(
      title = NULL, buttons = FALSE,
      closeOnClickOutside = FALSE,
      idel = paste0("sa-pb", id)
    )
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
