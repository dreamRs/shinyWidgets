
.shinyWidgetGalleryFuns$tabOverview <- function() {

  countries <- list(
    "France", "United Kingdom", "Germany", "United States of America", "Belgium", "China", "Spain", "Netherlands", "Mexico",
    "Italy", "Canada", "Brazil", "Denmark", "Norway", "Switzerland", "Luxembourg", "Israel", "Russian Federation",
    "Turkey", "Saudi Arabia", "United Arab Emirates"
  )
  flags <- c("fr", "gb", "de", "us", "be", "cn", "es", "nl", "mx", "it", "ca", "br", "dk", "no", "ch", "lu", "il", "ru", "tr", "sa", "ae")
  flags <- sprintf("https://cdn.rawgit.com/lipis/flag-icon-css/master/flags/4x3/%s.svg", flags)

  tagList(
    tags$h1("shinyWidgets Overview", class = "fw-bold text-primary"),
    br(),

    fluidRow(

      column(
        width = 4,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Awesome checkbox Group",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = awesomeCheckboxGroup,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Checkboxes with status", choices = c("A", "B", "C"), inline = TRUE)
          ),
          footer = actionLink(inputId = "toAwesome1", label = "More examples", icon = icon("plus"))
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Checkbox Group Buttons",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = checkboxGroupButtons,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Choices", choices = c("Choice 1", "Choice 2", "Choice 3"))
          ),
          footer = actionLink(inputId = "tocheckButtons", label = "More examples", icon = icon("plus"))
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Awesome Radio Buttons",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = awesomeRadio,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Radio with status", choices = c("A", "B", "C"), selected = "B", status = "warning")
          ),
          footer = actionLink(inputId = "toAwesome2", label = "More examples", icon = icon("plus"))
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Radio Group Buttons",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = radioGroupButtons,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Choices", choices = c("Choice 1", "Choice 2", "Choice 3"))
          )
        )
      )
      ,
      column(
        width = 4,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Awesome checkbox",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = awesomeCheckbox,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "A single checkbox", value = TRUE)
          ),
          footer = actionLink(inputId = "toAwesome3", label = "More examples", icon = icon("plus"))
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Material Design Switch",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = materialSwitch,
            args = list(inputId = ID(.shinyWidgetGalleryId), label = "Primary switch", status = "primary", right = TRUE)
          ),
          footer = actionLink(inputId = "toMaterialSwitch", label = "More examples", icon = icon("plus"))
        )
        ,
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Bootstrap Switch",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = switchInput,
            args = list(inputId = ID(.shinyWidgetGalleryId), value = TRUE)
          ),
          footer = actionLink(inputId = "toSwictchInput", label = "More examples", icon = icon("plus"))
        )
      )
      ,
      column(
        width = 4,

        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Select Picker",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = pickerInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId), label = "With plain HTML",
              choices = paste("Badge", c("info", "success", "danger", "primary", "warning")),
              multiple = TRUE, selected = "Badge danger",
              choicesOpt = list(
                content=sprintf(
                  # "<span class='badge badge-%1$s bg-%1$s'>%2$s</span>", c("info", "success", "danger", "primary", "warning"),
                  "<span class='badge text-bg-%s'>%s</span>", c("info", "success", "danger", "primary", "warning"),
                  paste("Badge", c("info", "success", "danger", "primary", "warning"))
                )
              ),
              options = pickerOptions(container = "body")
            )
          ),
          footer = actionLink(inputId = "toSelectPicker", label = "More examples", icon = icon("plus"))
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Search field",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = searchInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId), label = "Click search icon to update or hit 'Enter'",
              placeholder = "A placeholder",
              btnSearch = icon("magnifying-glass"),
              btnReset = icon("xmark"),
              width = "100%"
            )
          )
        ),
        .shinyWidgetGalleryFuns$box_wrapper(
          title = "Multi.js",
          .shinyWidgetGalleryFuns$widget_wrapper(
            fun = multiInput,
            args = list(
              inputId = ID(.shinyWidgetGalleryId),
              label = "Countries :", choices = NULL,
              choiceNames = lapply(seq_along(countries), function(i) tagList(tags$img(src = flags[i], width=20, height=15), countries[i])),
              choiceValues = countries,
              width = "100%"
            )
          )
        )
      )
    )
  )
}
