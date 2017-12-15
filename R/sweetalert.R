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




#' @title Display a Sweet Alert
#'
#' @description
#' Send a message from the server and launch a sweet alert in the UI.
#'
# @param messageId The sweet alert id.
#'
#'
#' @note Use \code{receiveSweetAlert()} in the UI and \code{sendSweetAlert()} in the server.
#'
# @seealso \code{\link{sendSweetAlert}}
#'
#' @examples
#' \dontrun{
#' if (interactive()) {
#'
#' shinyApp(
#'   ui = fluidPage(
#'     tags$h1("Click the button"),
#'     actionButton(inputId = "success", label = "Launch a success sweet alert"),
#'     actionButton(inputId = "error", label = "Launch an error sweet alert"),
#'     useSweetAlert()
#'   ),
#'   server = function(input, output, session) {
#'     observeEvent(input$success, {
#'       sendSweetAlert(
#'         session = session, title = "Success !!", text = "All in order", type = "success"
#'       )
#'     })
#'     observeEvent(input$error, {
#'       sendSweetAlert(
#'         session = session, title = "Error !!", text = "It's broken...", type = "error"
#'       )
#'     })
#'   }
#' )
#'
#' }
#' }
#'
#' @export
useSweetAlert <- function() {
  # js <- "Shiny.addCustomMessageHandler('sweetalert-sw', function(data) {swal(data)});"
  # js <- paste(js, sep = "\n",
  #   "Shiny.addCustomMessageHandler('sweetalert-sw-confirm', function(data) {swal(data)});"
  # )
  # tagSweet <- htmltools::tags$script(js)
  attachShinyWidgetsDep(tags$span(), "sweetalert")
}





#' @rdname useSweetAlert
#'
#' @param session The \code{session} object passed to function given to shinyServer.
#' @param title Title of the alert.
#' @param text Text of the alert.
#' @param type Type of the alert : info, success, warning or error
#'
# @seealso \code{\link{receiveSweetAlert}}
#'
#' @importFrom jsonlite toJSON
#' @importFrom htmltools tags
#'
#' @export
sendSweetAlert <- function(session, title = "Title", text = NULL, type = NULL) {
  if (is.null(type))
    type <- jsonlite::toJSON(NULL, auto_unbox = TRUE, null = "null")
  text <- jsonlite::toJSON(text, auto_unbox = TRUE, null = "null")
  #session <- shiny::getDefaultReactiveDomain()
  session$sendCustomMessage(
    type = "sweetalert-sw",
    message = list(title = title, text = text, icon = type)
  )
}




#' @rdname useSweetAlert
#'
#' @param session The \code{session} object passed to function given to shinyServer.
#' @param title Title of the alert.
#' @param text Text of the alert.
#' @param type Type of the alert : info, success, warning or error.
#' @param btn_labels Labels for buttons.
#'
# @seealso \code{\link{receiveSweetAlert}}
#'
#' @importFrom jsonlite toJSON
#' @importFrom htmltools tags
#'
#' @export
confirmSweetAlert <- function(session, title = "Are you sure ?", text = NULL, type = NULL, btn_labels = c("Cancel", "Confirm")) {
  id <- paste0("sac", sample.int(1e6, 1))
  if (is.null(type))
    type <- jsonlite::toJSON(NULL, auto_unbox = TRUE, null = "null")
  text <- jsonlite::toJSON(text, auto_unbox = TRUE, null = "null")
  btn_labels <- jsonlite::toJSON(btn_labels)
  #session <- shiny::getDefaultReactiveDomain()
  session$sendCustomMessage(
    type = "sweetalert-sw-confirm",
    message = list(id = id, title = title, text = text, icon = type, buttons = btn_labels)
  )
  while(is.null(session$input[[id]])) {
    Sys.sleep(0.01)
  }
  return(session$input[[id]])
}

