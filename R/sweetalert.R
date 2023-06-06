
#' @title Load Sweet Alert dependencies
#'
#' @description
#' This function isn't necessary for `sendSweetAlert`, `confirmSweetAlert`,
#'  `inputSweetAlert` (except if you want to use a theme other than the default one),
#'  but is still needed for `progressSweetAlert`.
#'
#' @param theme Theme to modify alerts appearance.
#' @param ie Add a polyfill to work in Internet Explorer.
#'
#' @seealso [sendSweetAlert()], [confirmSweetAlert()],
#'  [inputSweetAlert()], [closeSweetAlert()].
#'
#' @importFrom htmltools attachDependencies singleton tagList tags tagFunction
#'
#' @export
#'
#' @example examples/useSweetAlert.R
useSweetAlert <- function(theme = c("sweetalert2",
                                    "minimal",
                                    "dark",
                                    "bootstrap-4",
                                    "material-ui",
                                    "bulma",
                                    "borderless"),
                          ie = FALSE) {
  tagFunction(function() {
    shinytheme <- shiny::getCurrentTheme()
    tag <- tags$div()
    if (
      !bslib::is_bs_theme(shinytheme) |
      (bslib::is_bs_theme(shinytheme) && bslib::theme_version(shinytheme) == "3")
    ) {
      tag <- tagList(
        singleton(
          tags$head(tags$style(".swal2-popup {font-size: 1.6rem !important;}"))
        )
      )
    }
    deps <- list(
      html_dependency_sweetalert2(theme)
    )
    if (isTRUE(ie)) {
      deps <- append(
        deps, list(html_dependency_polyfill_promise()), 0
      )
    }
    attachDependencies(tag, deps)
  })
}




#' @title Display a Sweet Alert to the user
#'
#' @description Show an alert message to the user to provide some feedback.
#'
#' @param session The `session` object passed to function given to shinyServer.
#' @param title Title of the alert.
#' @param text Text of the alert.
#' @param type Type of the alert : info, success, warning or error.
#' @param btn_labels Label(s) for button(s), can be of length 2,
#' in which case the alert will have two buttons. Use `NA` for no buttons.s
#' @param btn_colors Color(s) for the buttons.
#' @param html Does `text` contains HTML tags ?
#' @param closeOnClickOutside Decide whether the user should be able to dismiss
#'  the modal by clicking outside of it, or not.
#' @param showCloseButton Show close button in top right corner of the modal.
#' @param width Width of the modal (in pixel).
#' @param ... Other arguments passed to JavaScript method.
#'
#' @note This function use the JavaScript sweetalert2 library, see the official
#'  documentation for more [https://sweetalert2.github.io/](https://sweetalert2.github.io/).
#'
#' @importFrom jsonlite toJSON
#' @importFrom htmltools tags
#' @importFrom shiny insertUI
#'
#' @export
#' @name sweetalert
#'
#' @seealso [confirmSweetAlert()], [inputSweetAlert()], [closeSweetAlert()].
#'
#' @example examples/show_alert.R
#' @example examples/show_alert-ouput.R
sendSweetAlert <- function(session = getDefaultReactiveDomain(),
                           title = "Title",
                           text = NULL,
                           type = NULL,
                           btn_labels = "Ok",
                           btn_colors = "#3085d6",
                           html = FALSE,
                           closeOnClickOutside = TRUE,
                           showCloseButton = FALSE,
                           width = NULL,
                           ...) {
  args <- list(...)
  insertUI(
    selector = "body",
    where = "afterBegin",
    ui = useSweetAlert(),
    immediate = TRUE,
    session = session
  )
  id <- paste0("placeholder-", sample.int(1e6, 1))
  if (is.null(type))
    type <- jsonlite::toJSON(NULL, auto_unbox = TRUE, null = "null")
  if (inherits(text, c("shiny.tag", "shiny.tag.list")))
    html <- TRUE
  if (isTRUE(html)) {
    text_ <- as.character(tags$div(id = id))
  } else {
    text_ <- as.character(text)
  }
  if (length(text_) < 1)
    text_ <- NULL
  session$sendCustomMessage(
    type = "sweetalert-sw",
    message = list(
      sw_id = id,
      as_html = html,
      config = dropNullsOrNA(list(
        title = title,
        icon = type,
        text =  text_,
        confirmButtonText = btn_labels[1],
        confirmButtonColor = btn_colors[1],
        showConfirmButton = !is.na(btn_labels[1]),
        cancelButtonText = btn_labels[2],
        cancelButtonColor = btn_colors[2],
        showCancelButton = !is.na(btn_labels[2]),
        allowOutsideClick = closeOnClickOutside,
        backdrop = args$backdrop %||% closeOnClickOutside,
        showCloseButton = showCloseButton,
        width = width,
        ...
      ))
    )
  )
  if (isTRUE(html)) {
    insertUI(
      session = session,
      selector = paste0("#", id),
      ui = text,
      immediate = TRUE
    )
  }
}

#' @rdname sweetalert
#' @export
show_alert <- function(title = "Title",
                       text = NULL,
                       type = NULL,
                       btn_labels = "Ok",
                       btn_colors = "#3085d6",
                       html = FALSE,
                       closeOnClickOutside = TRUE,
                       showCloseButton = FALSE,
                       width = NULL,
                       ...,
                       session = shiny::getDefaultReactiveDomain()) {
  sendSweetAlert(
    session = session,
    title = title,
    text = text,
    type = type,
    btn_labels = btn_labels,
    btn_colors = btn_colors,
    html = html,
    closeOnClickOutside = closeOnClickOutside,
    showCloseButton = showCloseButton,
    width = width,
    ...
  )
}


#' @title Launch a confirmation dialog
#'
#' @description Launch a popup to ask the user for confirmation.
#'
#' @param session The `session` object passed to function given to shinyServer.
#' @param inputId The `input` slot that will be used to access the value.
#'  If in a Shiny module, it use same logic than inputs : use namespace in UI, not in server.
#' @param title Title of the alert.
#' @param text Text of the alert, can contains HTML tags.
#' @param type Type of the alert : info, success, warning or error.
#' @param btn_labels Labels for buttons, cancel button (`FALSE`) first then confirm button (`TRUE`).
#' @param btn_colors Colors for buttons.
#' @param closeOnClickOutside Decide whether the user should be able to dismiss
#'  the modal by clicking outside of it, or not.
#' @param showCloseButton Show close button in top right corner of the modal.
#' @param allowEscapeKey If set to `FALSE`, the user can't dismiss the popup by pressing the `Esc` key.
#' @param cancelOnDismiss If `TRUE`, when dialog is dismissed (click outside, close button or Esc key)
#'  it will be equivalent to canceling (input value will be `FALSE`), if `FALSE` nothing happen (input value remain `NULL`).
#' @param html Does `text` contains HTML tags ?
#' @param ... Additional arguments (not used)
#'
#'
#' @importFrom jsonlite toJSON
#' @importFrom htmltools tags
#' @importFrom shiny insertUI
#'
#' @export
#'
#' @name sweetalert-confirmation
#'
#' @seealso [sendSweetAlert()], [inputSweetAlert()], [closeSweetAlert()].
#'
#' @example examples/ask_confirmation.R
#' @examples
#' # ------------------------------------
#' @example examples/ask_confirmation-options.R
confirmSweetAlert <- function(session = getDefaultReactiveDomain(),
                              inputId,
                              title = NULL,
                              text = NULL,
                              type = "question",
                              btn_labels = c("Cancel", "Confirm"),
                              btn_colors = NULL,
                              closeOnClickOutside = FALSE,
                              showCloseButton = FALSE,
                              allowEscapeKey = FALSE,
                              cancelOnDismiss = TRUE,
                              html = FALSE,
                              ...) {

  insertUI(
    selector = "body",
    where = "afterBegin",
    ui = useSweetAlert(),
    immediate = TRUE,
    session = session
  )
  if (is.null(type))
    type <- jsonlite::toJSON(NULL, auto_unbox = TRUE, null = "null")
  if (inherits(text, c("shiny.tag", "shiny.tag.list")))
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
        cancelOnDismiss = cancelOnDismiss,
        swal = dropNullsOrNA(list(
          title = title,
          text = text,
          icon = type,
          confirmButtonText = btn_labels[2],
          cancelButtonText = btn_labels[1],
          showConfirmButton = !is.na(btn_labels[2]),
          showCancelButton = !is.na(btn_labels[1]),
          confirmButtonColor = btn_colors[2],
          cancelButtonColor = btn_colors[1],
          showCloseButton = showCloseButton,
          allowOutsideClick = closeOnClickOutside,
          allowEscapeKey = allowEscapeKey,
          ...
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
        cancelOnDismiss = cancelOnDismiss,
        swal = dropNullsOrNA(list(
          title = title,
          icon = type,
          html = as.character(tags$div(id = id)),
          confirmButtonText = btn_labels[2],
          cancelButtonText = btn_labels[1],
          showConfirmButton = !is.na(btn_labels[2]),
          showCancelButton = !is.na(btn_labels[1]),
          confirmButtonColor = btn_colors[2],
          cancelButtonColor = btn_colors[1],
          showCloseButton = showCloseButton,
          allowOutsideClick = closeOnClickOutside,
          allowEscapeKey = allowEscapeKey,
          ...
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

#' @rdname sweetalert-confirmation
#' @export
ask_confirmation <- function(inputId,
                             title = NULL,
                             text = NULL,
                             type = "question",
                             btn_labels = c("Cancel", "Confirm"),
                             btn_colors = NULL,
                             closeOnClickOutside = FALSE,
                             showCloseButton = FALSE,
                             allowEscapeKey = FALSE,
                             cancelOnDismiss = TRUE,
                             html = FALSE,
                             ...,
                             session = shiny::getDefaultReactiveDomain()) {
  confirmSweetAlert(
    session = session,
    inputId = inputId,
    title = title,
    text = text,
    type = type,
    btn_labels = btn_labels,
    btn_colors = btn_colors,
    closeOnClickOutside = closeOnClickOutside,
    showCloseButton = showCloseButton,
    allowEscapeKey = allowEscapeKey,
    cancelOnDismiss = cancelOnDismiss,
    html = html, ...
  )
}


#' @title Launch an input text dialog
#'
#' @description Launch a popup with a text input
#'
#' @param session The `session` object passed to function given to shinyServer.
#' @param inputId The `input` slot that will be used to access the value.
#'  If in a Shiny module, it use same logic than inputs : use namespace in UI, not in server.
#' @param title Title of the pop-up.
#' @param text Text of the pop-up.
#' @param type Type of the pop-up : `"info"`, `"success"`,
#'  `"warning"`, `"error"` or `"question"`.
#' @param input Type of input, possible values are : `"text"`,
#'  `"password"`,`"textarea"`, `"radio"`, `"checkbox"` or `"select"`.
#' @param inputOptions Options for the input. For `"radio"` and `"select"` it will be choices.
#' @param inputPlaceholder Placeholder for the input, use it for `"text"` or `"checkbox"`.
#' @param inputValidator JavaScript function to validate input. Must be a character wrapped in `I()`.
#' @param btn_labels Label(s) for button(s).
#' @param btn_colors Color(s) for button(s).
#' @param reset_input Set the input value to `NULL` when alert is displayed.
#' @param ... Other arguments passed to JavaScript method.
#'
#' @note This function use the JavaScript sweetalert2 library, see the official documentation for more https://sweetalert2.github.io/.
#'
#' @importFrom jsonlite toJSON
#' @importFrom htmltools tags
#' @importFrom shiny insertUI
#'
#' @export
#'
#' @seealso [sendSweetAlert()], [confirmSweetAlert()],
#'  [closeSweetAlert()].
#'
#' @example examples/sweetalert-input.R
inputSweetAlert <- function(session = getDefaultReactiveDomain(),
                            inputId,
                            title = NULL,
                            text = NULL,
                            type = NULL,
                            input = c("text", "password", "textarea",
                                      "radio", "checkbox", "select",
                                      "email", "url"),
                            inputOptions = NULL,
                            inputPlaceholder = NULL,
                            inputValidator = NULL,
                            btn_labels = "Ok",
                            btn_colors = NULL,
                            reset_input = TRUE,
                            ...) {
  input <- match.arg(input)
  shiny::insertUI(
    selector = "body",
    where = "afterBegin",
    ui = useSweetAlert(),
    immediate = TRUE,
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
  swal <- dropNullsOrNA(list(
    title = title,
    text = text,
    icon = type,
    input = input,
    inputOptions = inputOptions,
    inputPlaceholder = inputPlaceholder,
    inputValidator = inputValidator,
    confirmButtonText = btn_labels[1],
    confirmButtonColor = btn_colors[1],
    cancelButtonText = btn_labels[2],
    cancelButtonColor = btn_colors[2],
    showCancelButton = !is.na(btn_labels[2]),
    ...
  ))
  toeval <- unlist(lapply(swal, function(x) {
    inherits(x, "AsIs")
  }))
  session$sendCustomMessage(
    type = "sweetalert-sw-input",
    message = list(
      id = inputId,
      reset_input = reset_input,
      eval = list1(names(swal)[toeval]),
      swal = swal
    )
  )
}



#' Progress bar in a sweet alert
#'
#' @param session The `session` object passed to function given to shinyServer.
#' @param id An id used to update the progress bar.
#' @param value Value of the progress bar between 0 and 100, if >100 you must provide total.
#' @param total Used to calculate percentage if value > 100, force an indicator to appear on top right of the progress bar.
#' @param display_pct logical, display percentage on the progress bar.
#' @param size Size, `NULL` by default or a value in 'xxs', 'xs', 'sm', only work with package `shinydashboard`.
#' @param status Color, must be a valid Bootstrap status : primary, info, success, warning, danger.
#' @param striped logical, add a striped effect.
#' @param title character, optional title.
#' @param ... Arguments passed to [sendSweetAlert()]
#'
#' @seealso [progressBar()]
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
progressSweetAlert <- function(session = getDefaultReactiveDomain(),
                               id,
                               value,
                               total = NULL,
                               display_pct = FALSE,
                               size = NULL,
                               status = NULL,
                               striped = FALSE,
                               title = NULL,
                               ...) {
  # If we are inside a module, turn the (relative) id (e.g. 'input') into an absolute id (e.g. 'module-input')
  if (inherits(session, "session_proxy")) {
    # Keep old code working which externally uses session$ns() to create an absolute id.
    if (!starts_with(id, session$ns("")))
      id <- session$ns(id)
  }
  sendSweetAlert(
    session = session,
    title = NULL,
    btn_labels = NA,
    text = tags$div(id = "sweet-alert-progress-sw"),
    closeOnClickOutside = FALSE,
    backdrop = TRUE,
    ...
  )
  shiny::insertUI(
    selector = "#sweet-alert-progress-sw",
    ui = progressBar(
      id = id,
      value = value,
      total = total,
      display_pct = display_pct,
      size = size,
      status = status,
      striped = striped,
      title = title
    ),
    immediate = TRUE, session = session
  )
}





#' Show a toast notification
#'
#' @param title Title for the toast.
#' @param text Text for the toast.
#' @param type Type of the toast: `"default"`,
#'  `"success"`, `"error"`, `"info"`,
#'  `"warning"` or `"question"`.
#' @param timer Auto close timer of the modal. Set in ms (milliseconds).
#' @param timerProgressBar If set to true, the timer will have a progress bar at the bottom of a popup.
#' @param position Modal window position, can be `"top"`, `"top-start"`,
#'  `"top-end"`, `"center"`, `"center-start"`, `"center-end"`,
#'  `"bottom"`, `"bottom-start"`, or `"bottom-end"`.
#' @param width Modal window width, including paddings.
#' @param session The `session` object passed to function given to shinyServer.
#'
#' @return No value.
#' @export
#'
#' @seealso [show_alert()], [ask_confirmation()], [closeSweetAlert()].
#'
#' @example examples/show_toast.R
show_toast <- function(title,
                       text = NULL,
                       type = c("default", "success", "error",
                                "info", "warning", "question"),
                       timer = 3000,
                       timerProgressBar = TRUE,
                       position = c("bottom-end", "top", "top-start",
                                    "top-end", "center", "center-start",
                                    "center-end", "bottom", "bottom-start"),
                       width = NULL,
                       session = shiny::getDefaultReactiveDomain()) {
  type <- match.arg(type)
  if (identical(type, "default"))
    type <- NULL
  position <- match.arg(position)
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
      icon = type,
      toast = TRUE,
      timer = timer,
      timerProgressBar = timerProgressBar,
      width = width,
      showConfirmButton = FALSE,
      showCloseButton = TRUE
    ))
  )
}





#' Close Sweet Alert
#'
#' @param session The `session` object passed to function given
#' to shinyServer.
#'
#' @export
#'
closeSweetAlert <- function(session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage(
    type = "sweetalert-sw-close",
    message = list()
  )
}
