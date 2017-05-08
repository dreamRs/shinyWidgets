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
#'  shinyApp(
#'   ui = fluidPage(
#'     tags$h1("Click the button"),
#'     actionButton(inputId = "success", label = "Launch a success sweet alert"),
#'     receiveSweetAlert(messageId = "successSw")
#'   ),
#'   server = function(input, output) {
#'     observeEvent(input$success, {
#'       sendSweetAlert(
#'         messageId = "successSw", title = "Success !!", text = "All in order", type = "success"
#'       )
#'     })
#'   }
#'  )
#' }
#' }
#'
#' @export

receiveSweetAlert <- function(messageId) {
  js <- sprintf(
    "Shiny.addCustomMessageHandler('%s', function(data) {swal({title: data.title, text: data.text, type: data.type, html: data.html})});",
    messageId
  )
  tagSweet <- tags$script(js)
  attachShinyWidgetsDep(tagSweet, "sweetalert")
}





#' @rdname receiveSweetAlert
#'
# @param session The \code{session} object passed to function given to shinyServer.
#' @param messageId The sweet alert id.
#' @param title Title of the alert
#' @param text Text of the alert
#' @param type Type of the alert : null, info, success, warning or error
#' @param html Logical. Use HTML in the text
#'
# @seealso \code{\link{receiveSweetAlert}}
#'
#' @importFrom jsonlite toJSON
#'
#' @export


sendSweetAlert <- function(messageId, title = "Title", text = "Text", type = NULL, html = FALSE) {
  if (is.null(type))
    type <- jsonlite::toJSON(NULL, auto_unbox = TRUE, null = "null")
  html <- jsonlite::toJSON(html, auto_unbox = TRUE)
  text <- jsonlite::toJSON(text, auto_unbox = TRUE, null = "null")
  session <- shiny::getDefaultReactiveDomain()
  session$sendCustomMessage(
    type = messageId,
    message = list(title = title, text = text, type = type, html = html)
  )
}
