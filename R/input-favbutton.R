#
# #' @title Circle Action button
# #'
# #' @description
# #' Create a FAV checkbox button.
# #'
# #' @param inputId The \code{input} slot that will be used to access the value.
# #' @param status Color of the button.
# #'
# #'
# #' @importFrom htmltools tagList singleton
# #'
# #' @export
#
#
# # favButton <- function (inputId, value = FALSE, status = "default", ...)
# # {
# #   htmltools::tagList(
# #     htmltools::singleton(
# #       tags$head(
# #         tags$link(rel='stylesheet', type='text/css', href='shinyWidgets/favButton/fav-button.css'),
# #         tags$script(src = "shinyWidgets/checkboxGroupButtons/checkboxGroupButtons-bindings.js")
# #       )
# #     ),
# #     tags$div(
# #       id=inputId, class="shiny-input-container checkboxGroupButtons",
# #       tags$div(
# #         class="btn-group", role="group", `aria-label`="...", `data-toggle`="buttons",
# #         tags$button(
# #           type = "button",
# #           class = paste0("btn btn-", status, " btn-circle"), ...,
# #           class=if (value) "active",
# #           tags$input(
# #             type="checkbox", name=inputId,
# #             value="fav", checked=if (value) "checked",
# #             shiny::icon("heart-o"),shiny::icon("heart")
# #           )
# #         )
# #       )
# #     )
# #   )
# # }
#
#
# favButton <- function (inputId, value = FALSE, type = "heart", status = "default", size = "default", animated = FALSE, ...)
# {
#   icofav_o <- if(type == "heart") "heart-o fa-lg" else "star-o fa-lg"
#   icofav <- if(type == "heart") "heart fa-lg" else "star fa-lg"
#   if (identical(animated, TRUE)) {
#     number <- 14
#   } else if (is.numeric(animated)) {
#     number <- animated
#     animated <- TRUE
#   }
#   if (animated) {
#     iconFav <- tagList(shiny::icon(icofav_o), shiny::icon(icofav))
#     headFav <- tags$head(
#       tags$link(rel='stylesheet', type='text/css', href='shinyWidgets/favButton/fav-button.css'),
#       # tags$link(rel='stylesheet', type='text/css', href='shinyWidgets/favButton/fav-icons.css'),
#       tags$script(src = "shinyWidgets/favButton/mo.min.js"),
#       tags$script(src = paste0("shinyWidgets/favButton/fav-button-", number, ".js"))
#     )
#     buttonClass <- paste0("icobutton", number, " icobutton--heart")
#     divClass <- paste0("btn-group fav-heart-button", number)
#   } else {
#     iconFav <- tagList(shiny::icon(icofav_o),shiny::icon(icofav))
#     headFav <- tags$head(
#       tags$link(rel='stylesheet', type='text/css', href='shinyWidgets/favButton/fav-button.css')
#     )
#     buttonClass <- ""
#     divClass <- "btn-group"
#   }
#   htmltools::tagList(
#     htmltools::singleton(headFav),
#     tags$div(
#       class=divClass, role="group", `aria-label`="...", `data-toggle`="buttons",
#       tags$button(
#         type = "button",
#         class = paste0("btn btn-", status, " btn-circle"), class = buttonClass, ...,
#         class=if(size=="large") "btn-lg",
#         class=if (value) "active",
#         iconFav,
#         tags$input(
#           type="checkbox", id=inputId,
#           checked=if (value) "checked"
#         )
#       )
#     )
#   )
# }
