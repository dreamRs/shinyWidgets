

.shinyWidgetGalleryFuns$tabVirtualSelect <- function() {
  tagList(
    tags$h1("Virtual Select", class = "fw-bold text-primary"),
    tags$h5(
      "via ",
      tags$a(href = "https://github.com/sa-si-dev/virtual-select", "virtual-select")
    ),
    br(),

    fluidRow(
      column(
        width = 4,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Default",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = virtualSelectInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Default :",
              choices = month.name,
              width = "100%",
              dropboxWrapper = "body"
            )
          )
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Multiple",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = virtualSelectInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Multiple :",
              choices = month.name,
              multiple = TRUE,
              width = "100%",
              dropboxWrapper = "body"
            )
          )
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Group choices",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = virtualSelectInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Group choices :",
              choices = list(
                Winter = month.name[1:3],
                Spring = month.name[4:6],
                Summer = month.name[7:9],
                Fall = month.name[10:12]
              ),
              multiple = TRUE,
              width = "100%",
              dropboxWrapper = "body"
            )
          )
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "HTML in choices",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = virtualSelectInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "HTML in choices :",
              choices = setNames(
                as.list(month.abb),
                mapply(
                  FUN = function(number, month, color) {
                    as.character(tagList(
                      icon("calendar-days"),
                      tags$b(
                        style = css(color = color),
                        month
                      )
                    ))
                  },
                  month = month.name,
                  color = palette.colors(n = 12, palette = "Alphabet")
                )
              ),
              html = TRUE,
              width = "100%",
              dropboxWrapper = "body"
            )
          )
        )
      ),

      column(
        width = 4,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Search",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = virtualSelectInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Search :",
              choices = month.name,
              search = TRUE,
              markSearchResults = TRUE,
              width = "100%",
              dropboxWrapper = "body"
            )
          )
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Show values as tags",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = virtualSelectInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Show values as tags :",
              choices = month.name,
              multiple = TRUE,
              showValueAsTags = TRUE,
              width = "100%",
              dropboxWrapper = "body"
            )
          )
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Allow new option",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = virtualSelectInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Allow new option :",
              choices = month.name,
              allowNewOption = TRUE,
              width = "100%",
              dropboxWrapper = "body"
            )
          )
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Always open",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = virtualSelectInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Always open :",
              choices = month.name,
              keepAlwaysOpen = TRUE,
              width = "100%",
              dropboxWrapper = "body"
            )
          )
        )
      ),

      column(
        width = 4,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Add a description",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = virtualSelectInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Add a description:",
              choices = prepare_choices(
                data.frame(
                  name = state.name,
                  abb = state.abb,
                  region = state.region,
                  division = state.division
                ),
                label = name,
                value = abb,
                description = division
              ),
              multiple = TRUE,
              hasOptionDescription = TRUE,
              width = "100%",
              dropboxWrapper = "body"
            )
          )
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Disable group select all",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = virtualSelectInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Disable group select all:",
              choices = list(
                Winter = month.name[1:3],
                Spring = month.name[4:6],
                Summer = month.name[7:9],
                Fall = month.name[10:12]
              ),
              multiple = TRUE,
              disableOptionGroupCheckbox = TRUE,
              width = "100%",
              dropboxWrapper = "body"
            )
          )
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Show as popup",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = virtualSelectInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Show as popup :",
              choices = month.name,
              showDropboxAsPopup = TRUE,
              popupDropboxBreakpoint = "3000px",
              width = "100%",
              dropboxWrapper = "body"
            )
          )
        )
      )
    )
  )
}
