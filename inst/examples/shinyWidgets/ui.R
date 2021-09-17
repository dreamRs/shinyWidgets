
#  ------------------------------------------------------------------------
#
# Title : shinyWidgets Gallery - ui
#    By : Victor
#  Date : 2020-12-01
#
#  ------------------------------------------------------------------------


# dropdown code ----
code_dropdownButton <- readLines(con = system.file('examples/shinyWidgets/code_dropdownButton.R', package='shinyWidgets', mustWork=TRUE))
code_dropdownButton <- paste(code_dropdownButton, collapse = "\n")
code_dropdown <- readLines(con = system.file('examples/shinyWidgets/code_dropdown.R', package='shinyWidgets', mustWork=TRUE))
code_dropdown <- paste(code_dropdown, collapse = "\n")
code_sa <- readLines(con = system.file('examples/shinyWidgets/code_sa.R', package='shinyWidgets', mustWork=TRUE))
code_sa <- paste(code_sa, collapse = "\n")


# Flags ----
countries <- list(
  "France", "United Kingdom", "Germany", "United States of America", "Belgium", "China", "Spain", "Netherlands", "Mexico",
  "Italy", "Canada", "Brazil", "Denmark", "Norway", "Switzerland", "Luxembourg", "Israel", "Russian Federation",
  "Turkey", "Saudi Arabia", "United Arab Emirates"
)
flags <- c("fr", "gb", "de", "us", "be", "cn", "es", "nl", "mx", "it", "ca", "br", "dk", "no", "ch", "lu", "il", "ru", "tr", "sa", "ae")
flags <- sprintf("https://cdn.rawgit.com/lipis/flag-icon-css/master/flags/4x3/%s.svg", flags)


# IDs
# Ids widgets
ID <- function(.shinyWidgetGalleryId) {
  tmp <- paste0("Id", sprintf("%03d", .shinyWidgetGalleryId))
  .shinyWidgetGalleryId <<- .shinyWidgetGalleryId + 1
  return(tmp)
}





# header ----

header <- dashboardHeader(title = "shinyWidgets gallery")



# sidebar ----

sidebar <- dashboardSidebar(
  sidebarMenu(
    id = "tabs",
    menuItem(text = "Overview", tabName = "tabOverview", icon = icon("th")),
    menuItem(text = "switchInput", tabName = "tabswitchInput", icon = icon("toggle-on")),
    menuItem(text = "Pretty Checkboxes & Radios", tabName = "tabPretty", icon = icon("check-circle")),
    menuItem(text = "Awesome Checkboxes & Radios", tabName = "tabAwesome", icon = icon("check-square")),
    menuItem(text = "checkboxGroup Buttons", tabName = "tabcheckButtons", icon = icon("square")),
    menuItem(text = "radio Buttons", tabName = "tabradioButtons", icon = icon("circle")),
    menuItem(text = "materialSwitch", tabName = "tabMaterialSwitch", icon = icon("toggle-off")),
    menuItem(text = "pickerInput", tabName = "tabPickerInput", icon = icon("caret-down")),
    menuItem(text = "sliderText", tabName = "tabSliderText", icon = icon("sliders-h")),
    menuItem(text = "progressBar", tabName = "tabProgressBars", icon = icon("tasks")),
    menuItem(text = "bttn", tabName = "tabBttn", icon = icon("square")),
    menuItem(text = "dropdowns & sweetalert", tabName = "tabOtherStuff", icon = icon("plus-circle"))
  )
)


# body ----

body <- dashboardBody(

  .shinyWidgetGalleryFuns$includeHighlightJs(),

  tabItems(

    # tabOverview ----
    tabItem(
      tabName = "tabOverview",

      tags$h1("shinyWidgets Overview", style = "font-weight: bold; color: #d9534f;"),
      br(),

      fluidRow(

        column(
          width = 4,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Awesome checkbox Group",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = awesomeCheckboxGroup,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Checkboxes with status", choices = c("A", "B", "C"), inline = TRUE, status = "danger")
            ),
            footer = actionLink(inputId = "toAwesome1", label = "More examples", icon = icon("plus"), style = "color: #d9534f")
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Checkbox Group Buttons",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = checkboxGroupButtons,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Choices", choices = c("Choice 1", "Choice 2", "Choice 3"), status = "danger")
            ),
            footer = actionLink(inputId = "tocheckButtons", label = "More examples", icon = icon("plus"), style = "color: #d9534f")
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Awesome Radio Buttons",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = awesomeRadio,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Radio with status", choices = c("A", "B", "C"), selected = "B", status = "warning")
            ),
            footer = actionLink(inputId = "toAwesome2", label = "More examples", icon = icon("plus"), style = "color: #d9534f")
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Radio Group Buttons",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = radioGroupButtons,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Choices", choices = c("Choice 1", "Choice 2", "Choice 3"), status = "primary")
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
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "A single checkbox", value = TRUE, status = "danger")
            ),
            footer = actionLink(inputId = "toAwesome3", label = "More examples", icon = icon("plus"), style = "color: #d9534f")
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Material Design Switch",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = materialSwitch,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Primary switch", status = "primary", right = TRUE)
            ),
            footer = actionLink(inputId = "toMaterialSwitch", label = "More examples", icon = icon("plus"), style = "color: #d9534f")
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Bootstrap Switch",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = switchInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), value = TRUE)
            ),
            footer = actionLink(inputId = "toSwictchInput", label = "More examples", icon = icon("plus"), style = "color: #d9534f")
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
                    "<span class='label label-%s'>%s</span>", c("info", "success", "danger", "primary", "warning"),
                    paste("Badge", c("info", "success", "danger", "primary", "warning"))
                  )
                )
              )
            ),
            footer = actionLink(inputId = "toSelectPicker", label = "More examples", icon = icon("plus"), style = "color: #d9534f")
          ),
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Search field",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = searchInput,
              args = list(
                inputId = ID(.shinyWidgetGalleryId), label = "Click search icon to update or hit 'Enter'",
                placeholder = "A placeholder",
                btnSearch = icon("search"),
                btnReset = icon("times"),
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
    ),

    # tabswitchInput ----
    tabItem(
      tabName = "tabswitchInput",

      tags$h1("switchInput", style = "font-weight: bold; color: #d9534f;"),
      tags$h5(
        "via ",
        tags$a(href = "http://www.bootstrap-switch.org/examples.html", "bootstrap-switch.org"),
        style="color: #d9534f;"
      ),
      br(),

      fluidRow(
        column(
          width = 4,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Default",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = switchInput,
              args = list(inputId = ID(.shinyWidgetGalleryId))
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "TRUE at start",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = switchInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), value = TRUE)
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Change ON/OFF labels",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = switchInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), onLabel = "Yes", offLabel = "No")
            )
          )
        )
        ,
        column(
          width = 4,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Change ON/OFF colors",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = switchInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), onStatus = "success", offStatus = "danger")
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Label in the middle",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = switchInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "My label", labelWidth = "80px")
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Size : mini",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = switchInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), size = "mini")
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Size : large",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = switchInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), size = "large")
            )
          )
        )
        ,
        column(
          width = 4,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Icon in the middle",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = switchInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "<i class=\"fa fa-thumbs-up\"></i>")
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Update value",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = switchInput,
              args = list(inputId = "switchUp", label = "<i class=\"fa fa-thumbs-up\"></i>")
            ),
            br(),
            tags$p("Click to update :"),
            actionGroupButtons(inputIds = c("on", "off"), labels = c("ON", "OFF"))
          )
        )
      )

    ),


    # tabPretty ----

    tabItem(
      tabName = "tabPretty",

      tags$h1("Pretty Checkboxes And Radios", style = "font-weight: bold; color: #d9534f;"),
      tags$h5(
        "via ",
        tags$a(href = "https://lokesh-coder.github.io/pretty-checkbox/", "pretty checkbox"),
        style="color: #d9534f;"
      ),
      br(),

      fluidRow(

        column(
          width = 4,

          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Default single checkbox",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = prettyCheckbox,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Click me!", value = TRUE)
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "With status",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = prettyCheckbox,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Click me!", value = TRUE,
                          status = "warning")
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "With curve shape",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = prettyCheckbox,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Click me!", value = TRUE,
                          status = "danger", shape = "curve")
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "With outline color",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = prettyCheckbox,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Click me!", value = TRUE,
                          status = "danger", shape = "curve", outline = TRUE)
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "With fill color",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = prettyCheckbox,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Click me!", value = TRUE,
                          status = "success", fill = TRUE)
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "With Font Awesome icon",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = prettyCheckbox,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Click me!", value = TRUE,
                          status = "info", icon = icon("thumbs-up"), plain = TRUE, outline = TRUE)
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "With animation",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = prettyCheckbox,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Click me!", value = TRUE,
                          icon = icon("check"), status = "success", animation = "rotate")
            )
          )

        ),

        column(
          width = 4,

          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Default switch",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = prettySwitch,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Click me!")
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Switch fill & status",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = prettySwitch,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Click me!", status = "success", fill = TRUE)
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Switch slim & status",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = prettySwitch,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Click me!", status = "primary", slim = TRUE)
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Default toggle",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = prettyToggle,
              args = list(inputId = ID(.shinyWidgetGalleryId), label_on = "Checked!",
                          label_off = "Unchecked...")
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Toggle with icons & status",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = prettyToggle,
              args = list(inputId = ID(.shinyWidgetGalleryId),
                          label_on = "Yes!", icon_on = icon("check"),
                          status_on = "info", status_off = "warning",
                          label_off = "No..", icon_off = icon("times"))
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Toggle with icons",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = prettyToggle,
              args = list(inputId = ID(.shinyWidgetGalleryId), label_on = "Yes!",
                          label_off = "No..", outline = TRUE,
                          plain = TRUE,
                          icon_on = icon("thumbs-up"),
                          icon_off = icon("thumbs-down"))
            )
          )

        ),

        column(
          width = 4,

          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Default checkbox group",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = prettyCheckboxGroup,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Choose:", choices = c("Click me !", "Me !", "Or me !"))
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Inline checkbox group & fill status",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = prettyCheckboxGroup,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Choose:", choices = c("Click me !", "Me !", "Or me !"),
                          inline = TRUE, status = "danger", fill = TRUE)
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Checkbox group with icons",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = prettyCheckboxGroup,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Choose:", choices = c("Click me !", "Me !", "Or me !"),
                          icon = icon("user"), animation = "tada")
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Checkbox group with icons, status & outline",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = prettyCheckboxGroup,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Choose:", choices = c("Click me !", "Me !", "Or me !"),
                          icon = icon("check-square"), status = "primary", outline = TRUE, animation = "jelly")
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Default radio buttons",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = prettyRadioButtons,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Choose:", choices = c("Click me !", "Me !", "Or me !"))
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Inline radio buttons & fill status",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = prettyRadioButtons,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Choose:", choices = c("Click me !", "Me !", "Or me !"),
                          inline = TRUE, status = "danger", fill = TRUE)
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Radio buttons with icons",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = prettyRadioButtons,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Choose:", choices = c("Click me !", "Me !", "Or me !"),
                          icon = icon("user"), animation = "tada")
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Radio buttons with icons, status",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = prettyRadioButtons,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Choose:", choices = c("Click me !", "Me !", "Or me !"),
                          icon = icon("check"), bigger = TRUE,
                          status = "info", animation = "jelly")
            )
          )

        )

      )
    ),


    # tabAwesome ----
    tabItem(
      tabName = "tabAwesome",

      tags$h1("Awesome Checkboxes And Radios", style = "font-weight: bold; color: #d9534f;"),
      tags$h5(
        "via ",
        tags$a(href = "http://flatlogic.github.io/awesome-bootstrap-checkbox/demo/", "awesome-bootstrap-checkbox"),
        style="color: #d9534f;"
      ),
      br(),

      fluidRow(
        column(
          width = 4,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Shiny default",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = checkboxInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "A single checkbox", value = TRUE)
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Shiny default",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = checkboxGroupInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Checkboxes", choices = c("A", "B", "C"), selected = "A")
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Shiny default",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = radioButtons,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Radio buttons", choices = c("A", "B", "C"))
            )
          )
        ),

        column(
          width = 4,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Single",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = awesomeCheckbox,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "A single checkbox", value = TRUE)
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Checkbox group",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = awesomeCheckboxGroup,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Checkboxes", choices = c("A", "B", "C"), selected = "A")
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Radio buttons",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = awesomeRadio,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Radio buttons", choices = c("A", "B", "C"), selected = "A")
            )
          )
        ),

        column(
          width = 4,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Another color",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = awesomeCheckbox,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "A single checkbox", value = TRUE, status = "info")
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Inline & danger",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = awesomeCheckboxGroup,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Checkboxes", choices = c("A", "B", "C"), selected = "A", inline = TRUE, status = "danger")
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Inline & success",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = awesomeRadio,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Radio buttons", choices = c("A", "B", "C"), selected = "A", inline = TRUE, status = "success")
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Inline & checkbox styled",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = awesomeRadio,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Radio buttons", choices = c("A", "B", "C"), selected = "A", inline = TRUE, checkbox =  TRUE)
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Update selected",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = awesomeRadio,
              args = list(inputId = "upAwesomeRadio", label = "Radio buttons", choices = c("A", "B", "C"), selected = "A", inline = TRUE)
            ),
            br(),
            tags$p("Click to update :"),
            actionGroupButtons(inputIds = c("upAwesomeRadioA", "upAwesomeRadioB", "upAwesomeRadioC"), labels = c("A", "B", "C"))
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Update choices",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = awesomeCheckboxGroup,
              args = list(inputId = "upAwesomeCheckbox", label = "Checkbox group", choices = c("A", "B", "C"), selected = "A", inline = TRUE, status = "warning")
            ),
            br(),
            tags$p("Click to update :"),
            actionGroupButtons(inputIds = c("upAwesomeCheckbox1", "upAwesomeCheckbox2"), labels = c("tolower & success", "TOUPPER & warning"))
          )
        )
      )

    ),

    # tabcheckButtons ----
    tabItem(
      tabName = "tabcheckButtons",

      tags$h1("Turn buttons into checkbox", style = "font-weight: bold; color: #d9534f;"),
      br(),

      fluidRow(

        column(
          width = 4,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Default",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = checkboxGroupButtons,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("A", "B", "C"))
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "With choices",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = checkboxGroupButtons,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("A", "B", "C", "D"), selected = c("B", "D"))
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Danger status",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = checkboxGroupButtons,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("A", "B", "C", "D"), status = "danger")
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Success status",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = checkboxGroupButtons,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("A", "B", "C", "D"), status = "success")
            )
          )
        ),

        column(
          width = 4,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Justified",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = checkboxGroupButtons,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("A", "B"), justified = TRUE)
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Vertical",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = checkboxGroupButtons,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("A", "B", "C", "D"), direction = "vertical")
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Large",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = checkboxGroupButtons,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("A", "B", "C", "D"), size = "lg")
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Update",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = checkboxGroupButtons,
              args = list(inputId = "upcheckboxGroupButtons", label = "Label", choices = c("A", "B", "C", "D"),
                          checkIcon = list(yes = icon("ok", lib = "glyphicon")))
            ),
            br(),
            tags$p("Click to update :"),
            actionGroupButtons(inputIds = c("upCheckBtnA", "upCheckBtnB", "upCheckBtnC", "upCheckBtnD"), labels = c("A", "B", "C", "D"))
          )
        ),

        column(
          width = 4,

          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Large",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = checkboxGroupButtons,
              args = list(
                inputId = ID(.shinyWidgetGalleryId), label = "Choose a graph :",
                choices = c(
                  "<i class='fa fa-bar-chart'></i>" = "bar",
                  "<i class='fa fa-line-chart'></i>" = "line",
                  "<i class='fa fa-pie-chart'></i>" = "pie"
                ), justified = TRUE
              )
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Icons",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = checkboxGroupButtons,
              args = list(
                inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("A", "B", "C", "D"), justified = TRUE,
                checkIcon = list(yes = icon("ok", lib = "glyphicon"))
              )
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "More icons",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = checkboxGroupButtons,
              args = list(
                inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("A", "B", "C", "D"), status = "primary",
                checkIcon = list(yes = icon("ok", lib = "glyphicon"), no = icon("remove", lib = "glyphicon"))
              )
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Colored icons",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = checkboxGroupButtons,
              args = list(
                inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("Option 1", "Option 2", "Option 3", "Option 4"),
                checkIcon = list(yes = tags$i(class = "fa fa-check-square", style = "color: steelblue"),
                                 no = tags$i(class = "fa fa-square-o", style = "color: steelblue")))
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Separated buttons",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = checkboxGroupButtons,
              args = list(
                inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("Option 1", "Option 2", "Option 3", "Option 4"), individual = TRUE,
                checkIcon = list(yes = tags$i(class = "fa fa-circle", style = "color: steelblue"),
                                 no = tags$i(class = "fa fa-circle-o", style = "color: steelblue"))
              )
            )
          )

        )
      )

    )
    ,

    # tabradioButtons ----
    tabItem(
      tabName = "tabradioButtons",

      tags$h1("Turn buttons into radio", style = "font-weight: bold; color: #d9534f;"),
      br(),

      fluidRow(

        column(
          width = 4,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Default",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = radioGroupButtons,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("A", "B", "C"))
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "With choices",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = radioGroupButtons,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("A", "B", "C", "D"), selected = "B")
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Danger status",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = radioGroupButtons,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("A", "B", "C", "D"), status = "danger")
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Success status",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = radioGroupButtons,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("A", "B", "C", "D"), status = "success")
            )
          )
        ),

        column(
          width = 4,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Justified",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = radioGroupButtons,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("A", "B"), justified = TRUE)
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Vertical",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = radioGroupButtons,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("A", "B", "C", "D"), direction = "vertical")
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Large",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = radioGroupButtons,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("A", "B", "C", "D"), size = "lg")
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Update",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = radioGroupButtons,
              args = list(inputId = "upradioGroupButtons", label = "Label", choices = c("A", "B", "C", "D"),
                          checkIcon = list(yes = icon("ok", lib = "glyphicon")))
            ),
            br(),
            tags$p("Click to update :"),
            actionGroupButtons(inputIds = c("upRadioBtnA", "upRadioBtnB", "upRadioBtnC", "upRadioBtnD"), labels = c("A", "B", "C", "D"))
          )
        ),

        column(
          width = 4,

          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Large",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = radioGroupButtons,
              args = list(
                inputId = ID(.shinyWidgetGalleryId), label = "Choose a graph :",
                choices = c(
                  "<i class='fa fa-bar-chart'></i>" = "bar",
                  "<i class='fa fa-line-chart'></i>" = "line",
                  "<i class='fa fa-pie-chart'></i>" = "pie"
                ), justified = TRUE
              )
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Icons",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = radioGroupButtons,
              args = list(
                inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("A", "B", "C", "D"), justified = TRUE,
                checkIcon = list(yes = icon("ok", lib = "glyphicon"))
              )
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "More icons",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = radioGroupButtons,
              args = list(
                inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("A", "B", "C", "D"), status = "primary",
                checkIcon = list(yes = icon("ok", lib = "glyphicon"), no = icon("remove", lib = "glyphicon"))
              )
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Colored icons",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = radioGroupButtons,
              args = list(
                inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("Option 1", "Option 2", "Option 3", "Option 4"),
                checkIcon = list(yes = tags$i(class = "fa fa-check-square", style = "color: steelblue"),
                                 no = tags$i(class = "fa fa-square-o", style = "color: steelblue")))
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Separated buttons",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = radioGroupButtons,
              args = list(
                inputId = ID(.shinyWidgetGalleryId), label = "Label", choices = c("Option 1", "Option 2", "Option 3", "Option 4"), individual = TRUE,
                checkIcon = list(yes = tags$i(class = "fa fa-circle", style = "color: steelblue"),
                                 no = tags$i(class = "fa fa-circle-o", style = "color: steelblue"))
              )
            )
          )

        )
      )

    ),

    # tabMaterialSwitch ----
    tabItem(
      tabName = "tabMaterialSwitch",

      tags$h1("Material switch", style = "font-weight: bold; color: #d9534f;"),
      tags$h5(
        "via ",
        tags$a(href = "http://bootsnipp.com/snippets/featured/material-design-switch", "material-design-switch"),
        style="color: #d9534f;"
      ),
      br(),

      fluidRow(

        column(
          width = 4,

          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Default",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = materialSwitch,
              args = list(inputId = ID(.shinyWidgetGalleryId))
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Label on left",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = materialSwitch,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "A label")
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Label on right",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = materialSwitch,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "A label", right = TRUE)
            )
          )

        ),

        column(
          width = 4,

          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Status primary",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = materialSwitch,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Primary", value = TRUE, status = "primary")
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Status danger",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = materialSwitch,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Danger", value = TRUE, status = "danger")
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Status success",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = materialSwitch,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Success", value = TRUE, status = "success")
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Status warning",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = materialSwitch,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Warning", value = TRUE, status = "warning")
            )
          )

        ),

        column(
          width = 4,

          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Update",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = materialSwitch,
              args = list(inputId = "upMaterial", label = "Update value", value = FALSE, status = "info")
            ),
            br(),
            tags$p("Click to update :"),
            actionGroupButtons(inputIds = c("upMaterialY", "upMaterialN"), labels = c("TRUE", "FALSE"))
          )
        )

      )

    ),

    # tabPickerInput ----
    tabItem(
      tabName = "tabPickerInput",

      tags$h1("Select Picker", style = "font-weight: bold; color: #d9534f;"),
      tags$h5(
        "via ",
        tags$a(href = "https://silviomoreto.github.io/bootstrap-select/examples/", "bootstrap-select"),
        style="color: #d9534f;"
      ),
      br(),

      fluidRow(

        column(
          width = 4,

          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Default",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = pickerInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Default", choices = c("a", "b", "c", "d"))
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Options group",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = pickerInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Options group",
                          choices = list(lower = c("a", "b", "c", "d"), upper = c("A", "B", "C", "D")))
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Multiple",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = pickerInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Multiple", choices = attr(UScitiesD, "Labels"), multiple = TRUE)
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Live search",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = pickerInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Live search", choices = attr(UScitiesD, "Labels"),
                          options = list("live-search" = TRUE))
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Menu size",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = pickerInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Menu size (5 items visible)", choices = LETTERS,
                          options = list(`size` = 5))
            )
          )

        ),

        column(
          width = 4,

          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Placeholder",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = pickerInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Placeholder", choices = c("a", "b", "c", "d"),
                          options = list(title = "This is a placeholder"))
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Selected text format",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = pickerInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Selected text format (select >3 items)", choices = LETTERS,
                          options = list(`selected-text-format` = "count > 3"), multiple = TRUE)
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Style : primary",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = pickerInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Style : primary", choices = c("a", "b", "c", "d"),
                          options = list(`style` = "btn-primary"))
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Style : danger",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = pickerInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Style : danger", choices = c("a", "b", "c", "d"),
                          options = list(`style` = "btn-danger"))
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Style individual options",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = pickerInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Style individual options with HTML",
                          choices = c("steelblue 150%", "right align + red", "bold", "background color"),
                          choicesOpt = list(
                            style = c("color: steelblue; font-size: 150%;", "color: firebrick; text-align: right;",
                                      "font-weight: bold;",
                                      "background: forestgreen; color: white;")
                          ))
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Style individual options (preserved)",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = pickerInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Style individual options with HTML",
                          choices = c("steelblue 150%", "right align + red", "bold", "background color"),
                          choicesOpt = list(
                            content = c("<div style='color: steelblue; font-size: 150%;'>steelblue 150%</div>",
                                        "<div style='color: firebrick; text-align: right;'>right align + red</div>",
                                      "<div style='font-weight: bold;'>bold</div>",
                                      "<div style='background: forestgreen; color: white; padding-left: 5px;'>background color</div>")
                          ))
            )
          )

        ),

        column(
          width = 4,

          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Icons",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = pickerInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Glyphicon",
                          choices = c("glyphicon-cog", "glyphicon-play", "glyphicon-ok-sign",
                                      "glyphicon-arrow-right", "glyphicon-euro", "glyphicon-music"),
                          choicesOpt = list(
                            icon = c("glyphicon-cog", "glyphicon-play", "glyphicon-ok-sign",
                                     "glyphicon-arrow-right", "glyphicon-euro", "glyphicon-music")
                          ))
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Subtext",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = pickerInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Subtext",
                          choices = rownames(mtcars),
                          choicesOpt = list(
                            subtext = paste("mpg", mtcars$mpg, sep =": ")
                          ))
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Select/deselect all",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = pickerInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Select/deselect all options", choices = LETTERS,
                          options = list(`actions-box` = TRUE), multiple = TRUE)
            )
          )
          ,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Update choices",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = pickerInput,
              args = list(inputId = "uppickerIcons",
                          label = "Glyphicon <> FontAwesome",
                          choices = c("glyphicon-arrow-right / fa-arrow-right", "glyphicon-cog / fa-cog", "glyphicon-play / fa-play",
                                      "glyphicon-ok-sign / fa-check", "glyphicon-euro / fa-eur", "glyphicon-music / fa-music"),
                          choicesOpt = list(
                            icon = c("glyphicon glyphicon-arrow-right", "glyphicon glyphicon-cog", "glyphicon glyphicon-play",
                                     "glyphicon glyphicon-ok-sign", "glyphicon glyphicon-euro", "glyphicon glyphicon-music")
                          ),
                          options = list(`icon-base` = ""))
            ),
            br(),
            radioButtons(inputId = "uppickerIconsRadio", label = "Update with Icons", choices = c("Glyphicon", "FontAwesome"), inline = TRUE)
          )

        )

      )

    ),

    # tabSliderText ----
    tabItem(
      tabName = "tabSliderText",

      tags$h1("Slider Text", style = "font-weight: bold; color: #d9534f;"),


      fluidRow(

        column(
          width = 4,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "With characters:",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = sliderTextInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Choose a letter:", choices = c("a", "b", "c", "d", "e"))
            )
          ),
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Range slider:",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = sliderTextInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Choose a range:", choices = month.abb, selected = month.abb[c(4, 8)])
            )
          ),
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Custom range for numeric:",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = sliderTextInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Choose a value:", choices = c(1, 10, 100, 500, 1000), grid = TRUE)
            )
          ),
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Decreasing order:",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = sliderTextInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Choose a value:", choices = seq(from = 10, to = 1, by = -1), grid = TRUE)
            )
          )
        ),

        column(
          width = 4,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "With month",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = sliderTextInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Pick a month:", choices = month.name)
            )
          ),
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Restricted choices",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = sliderTextInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Restricted choices:", choices = LETTERS,
                          selected = "A",
                          from_min = "E", from_max = "T")
            )
          ),
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Restricted choices",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = sliderTextInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Restricted choices for range:", choices = LETTERS,
                          selected = c("A", "T"),
                          from_min = "A", from_max = "E",
                          to_min = "R", to_max = "Z")
            )
          )
        ),

        column(
          width = 4,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Likert scale",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = sliderTextInput,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "Your choice:", grid = TRUE, force_edges = TRUE,
                          choices = c("Strongly disagree", "Disagree", "Neither agree nor disagree", "Agree", "Strongly agree"))
            )
          ),
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Update selected",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = sliderTextInput,
              args = list(inputId = "selectedSliderText", label = "Your choice:", grid = TRUE, force_edges = TRUE,
                          choices = letters[1:5])
            ),
            br(),
            radioButtons(inputId = "upSelectedSliderText", label = "Update selected:", choices = letters[1:5], inline = TRUE)
          ),
          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Update choices",
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = sliderTextInput,
              args = list(inputId = "choicesSliderText", label = "Your choice:", grid = TRUE, force_edges = TRUE,
                          choices = month.abb)
            ),
            br(),
            radioButtons(inputId = "upChoicesSliderText", label = "Update selected:", choices = c("Abbreviations", "Full names"), inline = TRUE)
          )
        )

      )

    ),



    # tabProgressBars ----
    tabItem(
      tabName = "tabProgressBars",
      tags$h1("Progress Bars", style = "font-weight: bold; color: #d9534f;"),

      fluidRow(
        column(
          width = 6,

          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Default",
            shinyWidgets::progressBar(id = "pb1", value = 50),
            sliderInput(inputId = "uppb1", label = "Update", min = 0, max = 100, value = 50),
            .shinyWidgetGalleryFuns$pb_code(
              id = "pb1",
              'progressBar(id = "pb1", value = 50)',
              'updateProgressBar(session = session, id = "pb1", value = input$slider)'
            )
          ),

          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Status : info & title",
            shinyWidgets::progressBar(id = "pb2", value = 50, status = "info", title = "This is a progress bar"),
            sliderInput(inputId = "uppb2", label = "Update", min = 0, max = 100, value = 50),
            .shinyWidgetGalleryFuns$pb_code(
              id = "pb2",
              'progressBar(id = "pb2", value = 50, status = "info", title = "This is a progress bar")',
              'updateProgressBar(session = session, id = "pb2", value = input$slider)'
            )
          ),

          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Status : danger & striped : true",
            shinyWidgets::progressBar(id = "pb3", value = 50, status = "danger", striped = TRUE),
            sliderInput(inputId = "uppb3", label = "Update", min = 0, max = 100, value = 50),
            .shinyWidgetGalleryFuns$pb_code(
              id = "pb3",
              'progressBar(id = "pb3", value = 50, status = "danger", striped = TRUE)',
              'updateProgressBar(session = session, id = "pb3", value = input$slider)'
            )
          )

        ),
        column(
          width = 6,

          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Display : percent",
            shinyWidgets::progressBar(id = "pb4", value = 50, display_pct = TRUE),
            sliderInput(inputId = "uppb4", label = "Update", min = 0, max = 100, value = 50, step = 5),
            .shinyWidgetGalleryFuns$pb_code(
              id = "pb4",
              'progressBar(id = "pb4", value = 50, display_pct = TRUE)',
              'updateProgressBar(session = session, id = "pb4", value = input$slider)'
            )
          ),

          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Status : warning & value > 100 (force value and total to appear)",
            shinyWidgets::progressBar(id = "pb5", value = 1500, total = 5000, status = "warning"),
            sliderInput(inputId = "uppb5", label = "Update", min = 0, max = 5000, value = 50),
            .shinyWidgetGalleryFuns$pb_code(
              id = "pb5",
              'progressBar(id = "pb5", value = 1500, total = 5000, status = "warning")',
              'updateProgressBar(session = session, id = "pb5", value = input$slider, total = 5000)'
            )
          ),

          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Status : success & size : xs",
            shinyWidgets::progressBar(id = "pb6", value = 50, status = "success", size = "xs"),
            sliderInput(inputId = "uppb6", label = "Update", min = 0, max = 100, value = 50),
            .shinyWidgetGalleryFuns$pb_code(
              id = "pb6",
              'progressBar(id = "pb6", value = 50, status = "success", size = "xs")',
              'updateProgressBar(session = session, id = "pb6", value = input$slider)'
            )
          )

        ),

        column(
          width = 12,

          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Status update",
            shinyWidgets::progressBar(id = "pb7", value = 50, display_pct = TRUE, status = "warning"),
            sliderInput(inputId = "uppb7", label = "Update", min = 0, max = 100, value = 50, step = 5),
            .shinyWidgetGalleryFuns$pb_code(
              id = "pb7",
              'progressBar(id = "pb7", value = 50, display_pct = TRUE, status = "warning")',
              paste(
                'if (input$slider < 33) {',
                '  status <- "danger"',
                '} else if (input$slider >= 33 & input$slider < 67) {',
                '  status <- "warning"',
                '} else {',
                '  status <- "success"',
                '}',
                'updateProgressBar(session = session, id = "pb7", value = input$slider, status = status)',
                sep = "\n"
              )
            )
          ),

          .shinyWidgetGalleryFuns$box_wrapper(
            title = "",
            shinyWidgets::progressBar(id = "pb8", value = 1500, total = 5000, status = "info", display_pct = TRUE, striped = TRUE, title = "All options"),
            sliderInput(inputId = "uppb8", label = "Update", min = 0, max = 5000, value = 50),
            .shinyWidgetGalleryFuns$pb_code(
              id = "pb8",
              'progressBar(id = "pb8", value = 1500, total = 5000, status = "info", display_pct = TRUE, striped = TRUE, title = "All options")',
              'updateProgressBar(session = session, id = "pb8", value = input$slider, total = 5000)'
            )
          ),

          .shinyWidgetGalleryFuns$box_wrapper(
            title = "Update total",
            shinyWidgets::progressBar(id = "pb9", value = 1000, total = 1000, display_pct = TRUE),
            sliderInput(inputId = "uppb9", label = "Update", min = 1000, max = 5000, value = 1000, step = 50),
            .shinyWidgetGalleryFuns$pb_code(
              id = "pb9",
              'progressBar(id = "pb9", value = 1000, total = 1000, display_pct = TRUE)',
              'updateProgressBar(session = session, id = "pb9", value = 1000, total = input$slider)'
            )
          )

        )
      )

    ),

    # tabBttn ----
    tabItem(
      tabName = "tabBttn",

      tags$h1("bttn", style = "font-weight: bold; color: #d9534f;"),

      fluidRow(

        column(
          width = 4,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = NULL,
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = actionBttn,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = NULL, style = "material-circle", color = "danger", icon = icon("bars"))
            ),
            footer = NULL
          ),
          .shinyWidgetGalleryFuns$box_wrapper(
            title = NULL,
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = actionBttn,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "material-flat", style = "material-flat", color = "danger")
            ),
            footer = NULL
          ),
          .shinyWidgetGalleryFuns$box_wrapper(
            title = NULL,
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = actionBttn,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "pill", style = "pill", color = "danger")
            ),
            footer = NULL
          ),
          .shinyWidgetGalleryFuns$box_wrapper(
            title = NULL,
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = actionBttn,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "float", style = "float", color = "danger")
            ),
            footer = NULL
          ),
          .shinyWidgetGalleryFuns$box_wrapper(
            title = NULL,
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = actionBttn,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "unite", style = "unite", color = "danger")
            ),
            footer = NULL
          ),
          .shinyWidgetGalleryFuns$box_wrapper(
            title = NULL,
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = actionBttn,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "fill", style = "fill", color = "danger")
            ),
            footer = NULL
          )
        ),



        column(
          width = 4,
          .shinyWidgetGalleryFuns$box_wrapper(
            title = NULL,
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = actionBttn,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = NULL, style = "simple", color = "primary", icon = icon("bars"))
            ),
            footer = NULL
          ),
          .shinyWidgetGalleryFuns$box_wrapper(
            title = NULL,
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = actionBttn,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "bordered", style = "bordered", color = "success", icon = icon("sliders-h"))
            ),
            footer = NULL
          ),
          .shinyWidgetGalleryFuns$box_wrapper(
            title = NULL,
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = actionBttn,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "minimal", style = "minimal", color = "danger")
            ),
            footer = NULL
          ),
          .shinyWidgetGalleryFuns$box_wrapper(
            title = NULL,
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = actionBttn,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "stretch", style = "stretch", color = "warning")
            ),
            footer = NULL
          ),
          .shinyWidgetGalleryFuns$box_wrapper(
            title = NULL,
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = actionBttn,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "jelly", style = "jelly", color = "danger")
            ),
            footer = NULL
          ),
          .shinyWidgetGalleryFuns$box_wrapper(
            title = NULL,
            .shinyWidgetGalleryFuns$widget_wrapper(
              fun = actionBttn,
              args = list(inputId = ID(.shinyWidgetGalleryId), label = "gradient", style = "gradient", color = "danger", icon = icon("thumbs-up"))
            ),
            footer = NULL
          )
        )


      )

    ),

    # tabOtherStuff ----
    tabItem(
      tabName = "tabOtherStuff",

      tags$h1("Other stuffs", style = "font-weight: bold; color: #d9534f;"),


      fluidRow(
        column(
          width = 8,

          box(
            title = "Dropdown Button", status = "danger", width = 12,
            dropdownButton(
              tags$h3("List of Inputs"),
              selectInput(inputId = 'xcol', label = 'X Variable', choices = names(iris)),
              selectInput(inputId = 'ycol', label = 'Y Variable', choices = names(iris), selected = names(iris)[[2]]),
              sliderInput(inputId = 'clusters', label = 'Cluster count', value = 3, min = 1, max = 9),
              circle = TRUE, status = "danger", icon = icon("cog"), width = "300px",
              tooltip = tooltipOptions(title = "Click to see inputs !")
            ),
            plotOutput(outputId = 'plot1'),
            tags$p("if you want to hide inputs to focus on a plot.."),
            tags$b(tags$a(icon("code"), "Show code", `data-toggle`="collapse", href="#showcode_dropdownButton")),
            tags$div(
              class="collapse", id="showcode_dropdownButton",
              .shinyWidgetGalleryFuns$rCodeContainer(
                id="code_dropdownButton",
                code_dropdownButton
              )
            )
          ),

          box(
            title = "Dropdown (bis)", status = "danger", width = 12,
            dropdown(
              tags$h3("List of Input"),
              pickerInput(inputId = 'xcol2', label = 'X Variable', choices = names(iris), options = list(`style` = "btn-info")),
              pickerInput(inputId = 'ycol2', label = 'Y Variable', choices = names(iris), selected = names(iris)[[2]], options = list(`style` = "btn-warning")),
              sliderInput(inputId = 'clusters2', label = 'Cluster count', value = 3, min = 1, max = 9),
              style = "unite", icon = icon("cog"), status = "danger", width = "300px",
              animate = animateOptions(enter = animations$fading_entrances$fadeInLeftBig, exit = animations$fading_exits$fadeOutRightBig)
            ),
            plotOutput(outputId = 'plot2'),
            tags$p("In this version you can add animations and pickerInput will work in it."),
            tags$b(tags$a(icon("code"), "Show code", `data-toggle`="collapse", href="#showcode_dropdown")),
            tags$div(
              class="collapse", id="showcode_dropdown",
              .shinyWidgetGalleryFuns$rCodeContainer(
                id="code_dropdown",
                code_dropdown
              )
            )
          )
        ),

        column(
          width = 4,
          box(
            title = "Sweet Alert", status = "danger", width = 12,
            tags$span(
              "via ",
              tags$a(href = "http://t4t5.github.io/sweetalert/", "sweetalert"),
              style="color: #d9534f;"
            ), br(), br(),
            # useSweetAlert(),
            fluidRow(
              column(
                width = 6,
                actionButton(inputId = "success", label = "Success !", width = "100%", class = "btn-success", style = "color: #FFF"),
                # receiveSweetAlert(messageId = "successmessage"),
                # br(), br(),
                # actionButton(inputId = "tags", label = "With HTML tags", width = "100%"),
                # receiveSweetAlert(messageId = "tagsmessage"),
                br(), br(),
                actionButton(inputId = "info", label = "Info", width = "100%", class = "btn-info", style = "color: #FFF")
                # receiveSweetAlert(messageId = "infomessage")
              ),
              column(
                width = 6,
                actionButton(inputId = "error", label = "Error", width = "100%", class = "btn-danger", style = "color: #FFF"),
                # receiveSweetAlert(messageId = "errormessage"),
                br(), br(),
                actionButton(inputId = "warning", label = "Warning", width = "100%", class = "btn-warning", style = "color: #FFF")
                # receiveSweetAlert(messageId = "warningmessage")
              )
            ),
            br(),
            tags$b(tags$a(icon("code"), "Show code", `data-toggle`="collapse", href="#showcodeSA")),
            tags$div(
              class="collapse", id="showcodeSA",
              .shinyWidgetGalleryFuns$rCodeContainer(
                id="codeSA",
                code_sa
              )
            )
          ),
          box(
            title = "Confirmation dialog", status = "danger", width = 12,
            actionButton(inputId = "launch_confirmation", label = "Ask for confirmation"),
            tags$br(),
            verbatimTextOutput(outputId = "res_confirmation")
          )
        )
      )

    )

  )

)



# app ----

dashboardPage(header = header, sidebar = sidebar, body = body, skin = "red") #


