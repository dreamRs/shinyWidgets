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
#' This function isn't necessary for \code{sendSweetAlert}, \code{confirmSweetAlert},
#'  \code{inputSweetAlert} (except if you want to use a theme other than the default one),
#'  but is still needed for \code{progressSweetAlert}.
#'
#' @param theme Theme to modify alerts appearance.
#'
#' @seealso \code{\link{sendSweetAlert}}, \code{\link{confirmSweetAlert}}, \code{\link{inputSweetAlert}}.
#'
#' @importFrom htmltools attachDependencies htmlDependency singleton tagList tags
#'
#' @export
#'
#' @example examples/useSweetAlert.R
useSweetAlert <- function(theme = c("sweetalert2", "minimal",
                                    "dark", "bootstrap-4",
                                    "borderless")) {
  theme <- match.arg(theme)
  tag_sa <- singleton(
    tagList(
      tags$head(tags$style(".swal2-popup {font-size: 1.6rem !important;}")),
      tags$span(id = "sw-sa-deps")
    )
  )
  attachDependencies(tag_sa, htmlDependency(
    name = "sweetalert2",
    version = "8.17.6",
    src = c(href="shinyWidgets/sweetalert2"),
    script = c("js/sweetalert2.min.js", "sweetalert-bindings.js"),
    stylesheet = sprintf("css/%s.min.css", theme)
  ))
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
#' in which case the alert will have two buttons. Use \code{NA} for no buttons.s
#' @param btn_colors Color(s) for the buttons.
#' @param html Does \code{text} contains HTML tags ?
#' @param closeOnClickOutside Decide whether the user should be able to dismiss
#'  the modal by clicking outside of it, or not.
#' @param showCloseButton Show close button in top right corner of the modal.
#' @param width Width of the modal (in pixel).
#'
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
sendSweetAlert <- function(session, title = "Title", text = NULL,
                           type = NULL, btn_labels = "Ok",
                           btn_colors = "#3085d6", html = FALSE,
                           closeOnClickOutside = TRUE,
                           showCloseButton = FALSE, width = NULL) {
  insertUI(
    selector = "body", where = "afterBegin",
    ui = useSweetAlert(), immediate = TRUE, session = session
  )
  if (is.null(type))
    type <- jsonlite::toJSON(NULL, auto_unbox = TRUE, null = "null")
  if ("shiny.tag" %in% class(text))
    html <- TRUE
  if (!isTRUE(html)) {
    text <- as.character(text)
    if (length(text) < 1)
      text <- NULL
    # text <- jsonlite::toJSON(text, auto_unbox = TRUE, null = "null")
    session$sendCustomMessage(
      type = "sweetalert-sw",
      message = list(
        as_html = html,
        config = dropNullsOrNA(list(
          title = title, text = text, type = type,
          confirmButtonText = btn_labels[1],
          confirmButtonColor = btn_colors[1],
          cancelButtonText = btn_labels[2],
          cancelButtonColor = btn_colors[2],
          showConfirmButton = !is.na(btn_labels[1]),
          showCancelButton = !is.na(btn_labels[2]),
          allowOutsideClick = closeOnClickOutside,
          showCloseButton = showCloseButton,
          width = width
        ))
      )
    )
  } else {
    id <- paste0("placeholder-", sample.int(1e6, 1))
    session$sendCustomMessage(
      type = "sweetalert-sw",
      message = list(
        sw_id = id,
        as_html = html,
        config = dropNullsOrNA(list(
          title = title, type = type,
          text = as.character(tags$div(id = id)),
          confirmButtonText = btn_labels[1],
          confirmButtonColor = btn_colors[1],
          showConfirmButton = !is.na(btn_labels[1]),
          cancelButtonText = btn_labels[2],
          cancelButtonColor = btn_colors[2],
          showCancelButton = !is.na(btn_labels[2]),
          allowOutsideClick = closeOnClickOutside,
          showCloseButton = showCloseButton,
          width = width
        ))
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
#'  If in a Shiny module, it use same logic than inputs : use namespace in UI, not in server.
#' @param title Title of the alert.
#' @param text Text of the alert, can contains HTML tags.
#' @param type Type of the alert : info, success, warning or error.
#' @param btn_labels Labels for buttons, cancel button (\code{FALSE}) first then confirm button (\code{TRUE}).
#' @param btn_colors Colors for buttons.
#' @param closeOnClickOutside Decide whether the user should be able to dismiss
#'  the modal by clicking outside of it, or not.
#' @param showCloseButton Show close button in top right corner of the modal.
#' @param html Does \code{text} contains HTML tags ?
#' @param ... Additional arguments (not used)
#'
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
#' if (interactive()) {
#'
#' library("shiny")
#' library("shinyWidgets")
#'
#'
#' ui <- fluidPage(
#'   tags$h1("Confirm sweet alert"),
#'   actionButton(
#'     inputId = "launch",
#'     label = "Launch confirmation dialog"
#'   ),
#'   verbatimTextOutput(outputId = "res"),
#'   uiOutput(outputId = "count")
#' )
#'
#' server <- function(input, output, session) {
#'   # Launch sweet alert confirmation
#'   observeEvent(input$launch, {
#'     confirmSweetAlert(
#'       session = session,
#'       inputId = "myconfirmation",
#'       title = "Want to confirm ?"
#'     )
#'   })
#'
#'   # raw output
#'   output$res <- renderPrint(input$myconfirmation)
#'
#'   # count click
#'   true <- reactiveVal(0)
#'   false <- reactiveVal(0)
#'   observeEvent(input$myconfirmation, {
#'     if (isTRUE(input$myconfirmation)) {
#'       x <- true() + 1
#'       true(x)
#'     } else {
#'       x <- false() + 1
#'       false(x)
#'     }
#'   }, ignoreNULL = TRUE)
#'   output$count <- renderUI({
#'     tags$span(
#'       "Confirm:", tags$b(true()),
#'       tags$br(),
#'       "Cancel:", tags$b(false())
#'     )
#'   })
#' }
#'
#' shinyApp(ui, server)
#'
#'
#'
#'
#' # other options :
#'
#' ui <- fluidPage(
#'   tags$h1("Confirm sweet alert"),
#'   actionButton(
#'     inputId = "launch1",
#'     label = "Launch confirmation dialog"
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
#'       title = "Want to confirm ?"
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
#'       btn_colors = c("#FE642E", "#04B404")
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
#'       btn_colors = c("#00BFFF", "#FE2E2E"),
#'       html = TRUE
#'     )
#'   })
#'   output$res3 <- renderPrint(input$myconfirmation3)
#'
#' }
#'
#' shinyApp(ui = ui, server = server)
#'
#' }
confirmSweetAlert <- function(session, inputId, title = NULL,
                              text = NULL, type = "question",
                              btn_labels = c("Cancel", "Confirm"),
                              btn_colors = NULL,
                              closeOnClickOutside = FALSE,
                              showCloseButton = FALSE,
                              html = FALSE, ...) {

  insertUI(
    selector = "body", where = "afterBegin",
    ui = useSweetAlert(), immediate = TRUE,
    session = session
  )
  if (is.null(type))
    type <- jsonlite::toJSON(NULL, auto_unbox = TRUE, null = "null")
  if ("shiny.tag" %in% class(text))
    html <- TRUE
  # If we are inside a module, turn the (relative) inputId (e.g. 'input') into an absolute input id (e.g. 'module-input')
  if (inherits(session, "session_proxy")) {
    # Keep old code working which externally uses session$ns() to create an absolute input id.
    if (!starts_with(inputId, session$ns("")))
      inputId <- session$ns(inputId)
  }
  if (!isTRUE(html)) {
    session$sendCustomMessage(
      type = "sweetalert-sw-confirm",
      message = list(
        id = inputId,
        as_html = html,
        swal = dropNullsOrNA(list(
          title = title, text = text, type = type,
          confirmButtonText = btn_labels[2],
          cancelButtonText = btn_labels[1],
          showConfirmButton = !is.na(btn_labels[2]),
          showCancelButton = !is.na(btn_labels[1]),
          confirmButtonColor = btn_colors[2],
          cancelButtonColor = btn_colors[1],
          showCloseButton = showCloseButton,
          allowOutsideClick = closeOnClickOutside
        ))
      )
    )
  } else {
    id <- paste0("placeholder-", sample.int(1e6, 1))
    session$sendCustomMessage(
      type = "sweetalert-sw-confirm",
      message = list(
        id = inputId,
        as_html = html,
        sw_id = id,
        swal = dropNullsOrNA(list(
          title = title, type = type,
          html = as.character(tags$div(id = id)),
          confirmButtonText = btn_labels[2],
          cancelButtonText = btn_labels[1],
          showConfirmButton = !is.na(btn_labels[2]),
          showCancelButton = !is.na(btn_labels[1]),
          confirmButtonColor = btn_colors[2],
          cancelButtonColor = btn_colors[1],
          showCloseButton = showCloseButton,
          allowOutsideClick = closeOnClickOutside
        ))
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
#'  If in a Shiny module, it use same logic than inputs : use namespace in UI, not in server.
#' @param title Title of the pop-up.
#' @param text Text of the pop-up.
#' @param type Type of the pop-up : \code{"info"}, \code{"success"},
#'  \code{"warning"}, \code{"error"} or \code{"question"}.
#' @param input Type of input, possible values are : \code{"text"},
#'  \code{"password"},\code{"textarea"}, \code{"radio"}, \code{"checkbox"} or \code{"select"}.
#' @param inputOptions Options for the input. For \code{"radio"} and \code{"select"} it will be choices.
#' @param inputPlaceholder Placeholder for the input, use it for \code{"text"} or \code{"checkbox"}.
#' @param btn_labels Label(s) for button(s).
#' @param btn_colors Color(s) for button(s).
#' @param reset_input Set the input value to \code{NULL} when alert is displayed.
#' @param ... Additional arguments (not used).
#'
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
#' if (interactive()) {
#'   library("shiny")
#'   library("shinyWidgets")
#'
#'
#'   ui <- fluidPage(
#'     tags$h1("Confirm sweet alert"),
#'     actionButton(inputId = "text", label = "Text Input"),
#'     verbatimTextOutput(outputId = "text"),
#'     actionButton(inputId = "password", label = "Password Input"),
#'     verbatimTextOutput(outputId = "password"),
#'     actionButton(inputId = "radio", label = "Radio Input"),
#'     verbatimTextOutput(outputId = "radio"),
#'     actionButton(inputId = "checkbox", label = "Checkbox Input"),
#'     verbatimTextOutput(outputId = "checkbox"),
#'     actionButton(inputId = "select", label = "Select Input"),
#'     verbatimTextOutput(outputId = "select")
#'   )
#'   server <- function(input, output, session) {
#'
#'     observeEvent(input$text, {
#'       inputSweetAlert(
#'         session = session, inputId = "mytext", input = "text",
#'         title = "What's your name ?"
#'       )
#'     })
#'     output$text <- renderPrint(input$mytext)
#'
#'     observeEvent(input$password, {
#'       inputSweetAlert(
#'         session = session, inputId = "mypassword", input = "password",
#'         title = "What's your password ?"
#'       )
#'     })
#'     output$password <- renderPrint(input$mypassword)
#'
#'     observeEvent(input$radio, {
#'       inputSweetAlert(
#'         session = session, inputId = "myradio", input = "radio",
#'         inputOptions = c("Banana" , "Orange", "Apple"),
#'         title = "What's your favorite fruit ?"
#'       )
#'     })
#'     output$radio <- renderPrint(input$myradio)
#'
#'     observeEvent(input$checkbox, {
#'       inputSweetAlert(
#'         session = session, inputId = "mycheckbox", input = "checkbox",
#'         inputPlaceholder = "Yes I agree",
#'         title = "Do you agree ?"
#'       )
#'     })
#'     output$checkbox <- renderPrint(input$mycheckbox)
#'
#'     observeEvent(input$select, {
#'       inputSweetAlert(
#'         session = session, inputId = "myselect", input = "select",
#'         inputOptions = c("Banana" , "Orange", "Apple"),
#'         title = "What's your favorite fruit ?"
#'       )
#'     })
#'     output$select <- renderPrint(input$myselect)
#'
#'   }
#'
#'   shinyApp(ui = ui, server = server)
#' }
inputSweetAlert <- function(session, inputId, title = NULL,
                            text = NULL, type = NULL,
                            input = c("text", "password", "textarea", "radio", "checkbox", "select"),
                            inputOptions = NULL, inputPlaceholder = NULL,
                            btn_labels = "Ok", btn_colors = NULL,
                            reset_input = TRUE,
                            ...) {
  input <- match.arg(input)
  shiny::insertUI(
    selector = "body", where = "afterBegin",
    ui = useSweetAlert(), immediate = TRUE,
    session = session
  )
  if (is.null(type))
    type <- jsonlite::toJSON(NULL, auto_unbox = TRUE, null = "null")
  # If we are inside a module, turn the (relative) inputId (e.g. 'input') into an absolute input id (e.g. 'module-input')
  if (inherits(session, "session_proxy")) {
    # Keep old code working which externally uses session$ns() to create an absolute input id.
    if (!starts_with(inputId, session$ns("")))
      inputId <- session$ns(inputId)
  }
  text <- jsonlite::toJSON(text, auto_unbox = TRUE, null = "null")
  if (!is.null(inputOptions)) {
    inputOptions <- choicesWithNames(inputOptions)
  }
  session$sendCustomMessage(
    type = "sweetalert-sw-input",
    message = list(
      id = inputId,
      reset_input = reset_input,
      swal = dropNullsOrNA(list(
        title = title, text = text,
        type = type, input = input, inputOptions = inputOptions,
        inputPlaceholder = inputPlaceholder,
        confirmButtonText = btn_labels[1],
        confirmButtonColor = btn_colors[1],
        cancelButtonText = btn_labels[2],
        cancelButtonColor = btn_colors[2],
        showCancelButton = !is.na(btn_labels[2])
      ))
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
progressSweetAlert <- function(session, id, value, total = NULL,
                               display_pct = FALSE, size = NULL,
                               status = NULL, striped = FALSE, title = NULL) {
  # If we are inside a module, turn the (relative) id (e.g. 'input') into an absolute id (e.g. 'module-input')
  if (inherits(session, "session_proxy")) {
    # Keep old code working which externally uses session$ns() to create an absolute id.
    if (!starts_with(id, session$ns("")))
      id <- session$ns(id)
  }
  sendSweetAlert(
    session = session,
    title = NULL, btn_labels = NA,
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





toastSweetAlert <- function(title, text, type = NULL,
                            timer = 1500, position = "bottom-end",
                            animation = TRUE, width = NULL,
                            session = shiny::getDefaultReactiveDomain()) {
  insertUI(
    selector = "body",
    where = "afterBegin",
    ui = useSweetAlert(),
    immediate = TRUE,
    session = session
  )
  session$sendCustomMessage(
    type = "sweetalert-toast",
    message = dropNullsOrNA(list(
      title = htmltools::doRenderTags(tags$div(
        style = "margin: auto;",
        title
      )),
      html = htmltools::doRenderTags(text),
      position = position,
      type = type,
      toast = TRUE,
      timer = timer,
      animation = animation,
      width = width,
      showConfirmButton = FALSE,
      showCloseButton = TRUE
    ))
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
