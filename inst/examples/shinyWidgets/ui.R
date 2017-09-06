


# shinyWidgets examples ---------------------------------------------------


# Packages ----

library("shinydashboard")
library("shinyWidgets")



# header ----

header <- dashboardHeader(title = "shinyWidgets")



# sidebar ----

sidebar <- dashboardSidebar(
  sidebarMenu(
    id = "tabs",
    menuItem(text = "Overview", tabName = "tabOverview", icon = icon("th")),
    menuItem(text = "switchInput", tabName = "tabswitchInput", icon = icon("toggle-on")),
    menuItem(text = "Checkboxes and Radios", tabName = "tabAwesome", icon = icon("check-square")),
    menuItem(text = "checkboxGroup Buttons", tabName = "tabcheckButtons", icon = icon("square")),
    menuItem(text = "radio Buttons", tabName = "tabradioButtons", icon = icon("circle")),
    menuItem(text = "materialSwitch", tabName = "tabMaterialSwitch", icon = icon("toggle-off")),
    menuItem(text = "pickerInput", tabName = "tabPickerInput", icon = icon("caret-down")),
    menuItem(text = "progressBar", tabName = "tabProgressBars", icon = icon("tasks")),
    menuItem(text = "bttn", tabName = "tabBttn", icon = icon("square-o")),
    menuItem(text = "Other stuffs", tabName = "tabOtherStuff", icon = icon("plus-circle"))
  )
)


# body ----

body <- dashboardBody(

  includeHighlightJs(),

  tabItems(

    # tabOverview ----
    tabItem(
      tabName = "tabOverview",

      tags$h1("shinyWidgets Overview", style = "font-weight: bold; color: #d9534f;"),
      br(),

      fluidRow(

        column(
          width = 4,
          box_wrapper(
            title = "Awesome checkbox Group",
            widget_wrapper(
              fun = awesomeCheckboxGroup,
              args = list(inputId = ID(ids), label = "Checkboxes with status", choices = c("A", "B", "C"), inline = TRUE, status = "danger")
            ),
            footer = actionLink(inputId = "toAwesome1", label = "More examples", icon = icon("plus"), style = "color: #d9534f")
          )
          ,
          box_wrapper(
            title = "Checkbox Group Buttons",
            widget_wrapper(
              fun = checkboxGroupButtons,
              args = list(inputId = ID(ids), label = "Choices", choices = c("Choice 1", "Choice 2", "Choice 3"), status = "danger")
            ),
            footer = actionLink(inputId = "tocheckButtons", label = "More examples", icon = icon("plus"), style = "color: #d9534f")
          )
          ,
          box_wrapper(
            title = "Awesome Radio Buttons",
            widget_wrapper(
              fun = awesomeRadio,
              args = list(inputId = ID(ids), label = "Radio with status", choices = c("A", "B", "C"), selected = "B", status = "warning")
            ),
            footer = actionLink(inputId = "toAwesome2", label = "More examples", icon = icon("plus"), style = "color: #d9534f")
          )
          ,
          box_wrapper(
            title = "Radio Group Buttons",
            widget_wrapper(
              fun = radioGroupButtons,
              args = list(inputId = ID(ids), label = "Choices", choices = c("Choice 1", "Choice 2", "Choice 3"), status = "primary")
            )
          )
        )
        ,
        column(
          width = 4,
          box_wrapper(
            title = "Awesome checkbox",
            widget_wrapper(
              fun = awesomeCheckbox,
              args = list(inputId = ID(ids), label = "A single checkbox", value = TRUE, status = "danger")
            ),
            footer = actionLink(inputId = "toAwesome3", label = "More examples", icon = icon("plus"), style = "color: #d9534f")
          )
          ,
          box_wrapper(
            title = "Material Design Switch",
            widget_wrapper(
              fun = materialSwitch,
              args = list(inputId = ID(ids), label = "Primary switch", status = "primary", right = TRUE)
            ),
            footer = actionLink(inputId = "toMaterialSwitch", label = "More examples", icon = icon("plus"), style = "color: #d9534f")
          )
          ,
          box_wrapper(
            title = "Bootstrap Switch",
            widget_wrapper(
              fun = switchInput,
              args = list(inputId = ID(ids), value = TRUE)
            ),
            footer = actionLink(inputId = "toSwictchInput", label = "More examples", icon = icon("plus"), style = "color: #d9534f")
          )
        )
        ,
        column(
          width = 4,

          box_wrapper(
            title = "Select Picker",
            widget_wrapper(
              fun = pickerInput,
              args = list(
                inputId = ID(ids), label = "With plain HTML",
                choices = paste("Badge", c("info", "success", "danger", "primary", "warning")),
                multiple = TRUE, selected = "Badge danger",
                choicesOpt = list(
                  content=sprintf(
                    "<span class='label label-%s'>%s</span>", c("info", "success", "danger", "primary", "warning"),
                    paste("Badge", c("info", "success", "danger", "primary", "warning"))
                  )
                )
              )
            ),
            footer = actionLink(inputId = "toSelectPicker", label = "More examples", icon = icon("plus"), style = "color: #d9534f")
          ),
          box_wrapper(
            title = "Search field",
            widget_wrapper(
              fun = searchInput,
              args = list(
                inputId = ID(ids), label = "Click search icon to update or hit 'Enter'",
                placeholder = "A placeholder",
                btnSearch = icon("search"),
                btnReset = icon("remove"),
                width = "100%"
              )
            )
          ),
          box_wrapper(
            title = "Multi.js",
            widget_wrapper(
              fun = multiInput,
              args = list(
                inputId = ID(ids),
                label = "Countries :", choices = NULL,
                choiceNames = lapply(seq_along(countries), function(i) tagList(tags$img(src = flags[i], width=20, height=15), countries[i])),
                choiceValues = countries
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
          box_wrapper(
            title = "Default",
            widget_wrapper(
              fun = switchInput,
              args = list(inputId = ID(ids))
            )
          )
          ,
          box_wrapper(
            title = "TRUE at start",
            widget_wrapper(
              fun = switchInput,
              args = list(inputId = ID(ids), value = TRUE)
            )
          )
          ,
          box_wrapper(
            title = "Change ON/OFF labels",
            widget_wrapper(
              fun = switchInput,
              args = list(inputId = ID(ids), onLabel = "Yes", offLabel = "No")
            )
          )
        )
        ,
        column(
          width = 4,
          box_wrapper(
            title = "Change ON/OFF colors",
            widget_wrapper(
              fun = switchInput,
              args = list(inputId = ID(ids), onStatus = "success", offStatus = "danger")
            )
          )
          ,
          box_wrapper(
            title = "Label in the middle",
            widget_wrapper(
              fun = switchInput,
              args = list(inputId = ID(ids), label = "My label", labelWidth = "80px")
            )
          )
          ,
          box_wrapper(
            title = "Size : mini",
            widget_wrapper(
              fun = switchInput,
              args = list(inputId = ID(ids), size = "mini")
            )
          )
          ,
          box_wrapper(
            title = "Size : large",
            widget_wrapper(
              fun = switchInput,
              args = list(inputId = ID(ids), size = "large")
            )
          )
        )
        ,
        column(
          width = 4,
          box_wrapper(
            title = "Icon in the middle",
            widget_wrapper(
              fun = switchInput,
              args = list(inputId = ID(ids), label = "<i class=\"fa fa-thumbs-up\"></i>")
            )
          )
          ,
          box_wrapper(
            title = "Update value",
            widget_wrapper(
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

    # tabAwesome ----
    tabItem(
      tabName = "tabAwesome",

      tags$h1("Prettier Checkboxes And Radios", style = "font-weight: bold; color: #d9534f;"),
      tags$h5(
        "via ",
        tags$a(href = "http://flatlogic.github.io/awesome-bootstrap-checkbox/demo/", "awesome-bootstrap-checkbox"),
        style="color: #d9534f;"
      ),
      br(),

      fluidRow(
        column(
          width = 4,
          box_wrapper(
            title = "Shiny default",
            widget_wrapper(
              fun = checkboxInput,
              args = list(inputId = ID(ids), label = "A single checkbox", value = TRUE)
            )
          )
          ,
          box_wrapper(
            title = "Shiny default",
            widget_wrapper(
              fun = checkboxGroupInput,
              args = list(inputId = ID(ids), label = "Checkboxes", choices = c("A", "B", "C"), selected = "A")
            )
          )
          ,
          box_wrapper(
            title = "Shiny default",
            widget_wrapper(
              fun = radioButtons,
              args = list(inputId = ID(ids), label = "Radio buttons", choices = c("A", "B", "C"))
            )
          )
        ),

        column(
          width = 4,
          box_wrapper(
            title = "Single",
            widget_wrapper(
              fun = awesomeCheckbox,
              args = list(inputId = ID(ids), label = "A single checkbox", value = TRUE)
            )
          )
          ,
          box_wrapper(
            title = "Checkbox group",
            widget_wrapper(
              fun = awesomeCheckboxGroup,
              args = list(inputId = ID(ids), label = "Checkboxes", choices = c("A", "B", "C"), selected = "A")
            )
          )
          ,
          box_wrapper(
            title = "Radio buttons",
            widget_wrapper(
              fun = awesomeRadio,
              args = list(inputId = ID(ids), label = "Radio buttons", choices = c("A", "B", "C"), selected = "A")
            )
          )
        ),

        column(
          width = 4,
          box_wrapper(
            title = "Another color",
            widget_wrapper(
              fun = awesomeCheckbox,
              args = list(inputId = ID(ids), label = "A single checkbox", value = TRUE, status = "info")
            )
          )
          ,
          box_wrapper(
            title = "Inline & danger",
            widget_wrapper(
              fun = awesomeCheckboxGroup,
              args = list(inputId = ID(ids), label = "Checkboxes", choices = c("A", "B", "C"), selected = "A", inline = TRUE, status = "danger")
            )
          )
          ,
          box_wrapper(
            title = "Inline & success",
            widget_wrapper(
              fun = awesomeRadio,
              args = list(inputId = ID(ids), label = "Radio buttons", choices = c("A", "B", "C"), selected = "A", inline = TRUE, status = "success")
            )
          )
          ,
          box_wrapper(
            title = "Inline & checkbox styled",
            widget_wrapper(
              fun = awesomeRadio,
              args = list(inputId = ID(ids), label = "Radio buttons", choices = c("A", "B", "C"), selected = "A", inline = TRUE, checkbox =  TRUE)
            )
          )
          ,
          box_wrapper(
            title = "Update selected",
            widget_wrapper(
              fun = awesomeRadio,
              args = list(inputId = "upAwesomeRadio", label = "Radio buttons", choices = c("A", "B", "C"), selected = "A", inline = TRUE)
            ),
            br(),
            tags$p("Click to update :"),
            actionGroupButtons(inputIds = c("upAwesomeRadioA", "upAwesomeRadioB", "upAwesomeRadioC"), labels = c("A", "B", "C"))
          )
          ,
          box_wrapper(
            title = "Update choices",
            widget_wrapper(
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
          box_wrapper(
            title = "Default",
            widget_wrapper(
              fun = checkboxGroupButtons,
              args = list(inputId = ID(ids), label = "Label", choices = c("A", "B", "C"))
            )
          )
          ,
          box_wrapper(
            title = "With choices",
            widget_wrapper(
              fun = checkboxGroupButtons,
              args = list(inputId = ID(ids), label = "Label", choices = c("A", "B", "C", "D"), selected = c("B", "D"))
            )
          )
          ,
          box_wrapper(
            title = "Danger status",
            widget_wrapper(
              fun = checkboxGroupButtons,
              args = list(inputId = ID(ids), label = "Label", choices = c("A", "B", "C", "D"), status = "danger")
            )
          )
          ,
          box_wrapper(
            title = "Success status",
            widget_wrapper(
              fun = checkboxGroupButtons,
              args = list(inputId = ID(ids), label = "Label", choices = c("A", "B", "C", "D"), status = "success")
            )
          )
        ),

        column(
          width = 4,
          box_wrapper(
            title = "Justified",
            widget_wrapper(
              fun = checkboxGroupButtons,
              args = list(inputId = ID(ids), label = "Label", choices = c("A", "B"), justified = TRUE)
            )
          )
          ,
          box_wrapper(
            title = "Vertical",
            widget_wrapper(
              fun = checkboxGroupButtons,
              args = list(inputId = ID(ids), label = "Label", choices = c("A", "B", "C", "D"), direction = "vertical")
            )
          )
          ,
          box_wrapper(
            title = "Large",
            widget_wrapper(
              fun = checkboxGroupButtons,
              args = list(inputId = ID(ids), label = "Label", choices = c("A", "B", "C", "D"), size = "lg")
            )
          )
          ,
          box_wrapper(
            title = "Update",
            widget_wrapper(
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

          box_wrapper(
            title = "Large",
            widget_wrapper(
              fun = checkboxGroupButtons,
              args = list(
                inputId = ID(ids), label = "Choose a graph :",
                choices = c(
                  "<i class='fa fa-bar-chart'></i>" = "bar",
                  "<i class='fa fa-line-chart'></i>" = "line",
                  "<i class='fa fa-pie-chart'></i>" = "pie"
                ), justified = TRUE
              )
            )
          )
          ,
          box_wrapper(
            title = "Icons",
            widget_wrapper(
              fun = checkboxGroupButtons,
              args = list(
                inputId = ID(ids), label = "Label", choices = c("A", "B", "C", "D"), justified = TRUE,
                checkIcon = list(yes = icon("ok", lib = "glyphicon"))
              )
            )
          )
          ,
          box_wrapper(
            title = "More icons",
            widget_wrapper(
              fun = checkboxGroupButtons,
              args = list(
                inputId = ID(ids), label = "Label", choices = c("A", "B", "C", "D"), status = "primary",
                checkIcon = list(yes = icon("ok", lib = "glyphicon"), no = icon("remove", lib = "glyphicon"))
              )
            )
          )
          ,
          box_wrapper(
            title = "Colored icons",
            widget_wrapper(
              fun = checkboxGroupButtons,
              args = list(
                inputId = ID(ids), label = "Label", choices = c("Option 1", "Option 2", "Option 3", "Option 4"),
                checkIcon = list(yes = tags$i(class = "fa fa-check-square", style = "color: steelblue"),
                                 no = tags$i(class = "fa fa-square-o", style = "color: steelblue")))
            )
          )
          ,
          box_wrapper(
            title = "Separated buttons",
            widget_wrapper(
              fun = checkboxGroupButtons,
              args = list(
                inputId = ID(ids), label = "Label", choices = c("Option 1", "Option 2", "Option 3", "Option 4"), individual = TRUE,
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
          box_wrapper(
            title = "Default",
            widget_wrapper(
              fun = radioGroupButtons,
              args = list(inputId = ID(ids), label = "Label", choices = c("A", "B", "C"))
            )
          )
          ,
          box_wrapper(
            title = "With choices",
            widget_wrapper(
              fun = radioGroupButtons,
              args = list(inputId = ID(ids), label = "Label", choices = c("A", "B", "C", "D"), selected = "B")
            )
          )
          ,
          box_wrapper(
            title = "Danger status",
            widget_wrapper(
              fun = radioGroupButtons,
              args = list(inputId = ID(ids), label = "Label", choices = c("A", "B", "C", "D"), status = "danger")
            )
          )
          ,
          box_wrapper(
            title = "Success status",
            widget_wrapper(
              fun = radioGroupButtons,
              args = list(inputId = ID(ids), label = "Label", choices = c("A", "B", "C", "D"), status = "success")
            )
          )
        ),

        column(
          width = 4,
          box_wrapper(
            title = "Justified",
            widget_wrapper(
              fun = radioGroupButtons,
              args = list(inputId = ID(ids), label = "Label", choices = c("A", "B"), justified = TRUE)
            )
          )
          ,
          box_wrapper(
            title = "Vertical",
            widget_wrapper(
              fun = radioGroupButtons,
              args = list(inputId = ID(ids), label = "Label", choices = c("A", "B", "C", "D"), direction = "vertical")
            )
          )
          ,
          box_wrapper(
            title = "Large",
            widget_wrapper(
              fun = radioGroupButtons,
              args = list(inputId = ID(ids), label = "Label", choices = c("A", "B", "C", "D"), size = "lg")
            )
          )
          ,
          box_wrapper(
            title = "Update",
            widget_wrapper(
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

          box_wrapper(
            title = "Large",
            widget_wrapper(
              fun = radioGroupButtons,
              args = list(
                inputId = ID(ids), label = "Choose a graph :",
                choices = c(
                  "<i class='fa fa-bar-chart'></i>" = "bar",
                  "<i class='fa fa-line-chart'></i>" = "line",
                  "<i class='fa fa-pie-chart'></i>" = "pie"
                ), justified = TRUE
              )
            )
          )
          ,
          box_wrapper(
            title = "Icons",
            widget_wrapper(
              fun = radioGroupButtons,
              args = list(
                inputId = ID(ids), label = "Label", choices = c("A", "B", "C", "D"), justified = TRUE,
                checkIcon = list(yes = icon("ok", lib = "glyphicon"))
              )
            )
          )
          ,
          box_wrapper(
            title = "More icons",
            widget_wrapper(
              fun = radioGroupButtons,
              args = list(
                inputId = ID(ids), label = "Label", choices = c("A", "B", "C", "D"), status = "primary",
                checkIcon = list(yes = icon("ok", lib = "glyphicon"), no = icon("remove", lib = "glyphicon"))
              )
            )
          )
          ,
          box_wrapper(
            title = "Colored icons",
            widget_wrapper(
              fun = radioGroupButtons,
              args = list(
                inputId = ID(ids), label = "Label", choices = c("Option 1", "Option 2", "Option 3", "Option 4"),
                checkIcon = list(yes = tags$i(class = "fa fa-check-square", style = "color: steelblue"),
                                 no = tags$i(class = "fa fa-square-o", style = "color: steelblue")))
            )
          )
          ,
          box_wrapper(
            title = "Separated buttons",
            widget_wrapper(
              fun = radioGroupButtons,
              args = list(
                inputId = ID(ids), label = "Label", choices = c("Option 1", "Option 2", "Option 3", "Option 4"), individual = TRUE,
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

          box_wrapper(
            title = "Default",
            widget_wrapper(
              fun = materialSwitch,
              args = list(inputId = ID(ids))
            )
          )
          ,
          box_wrapper(
            title = "Label on left",
            widget_wrapper(
              fun = materialSwitch,
              args = list(inputId = ID(ids), label = "A label")
            )
          )
          ,
          box_wrapper(
            title = "Label on right",
            widget_wrapper(
              fun = materialSwitch,
              args = list(inputId = ID(ids), label = "A label", right = TRUE)
            )
          )

        ),

        column(
          width = 4,

          box_wrapper(
            title = "Status primary",
            widget_wrapper(
              fun = materialSwitch,
              args = list(inputId = ID(ids), label = "Primary", value = TRUE, status = "primary")
            )
          )
          ,
          box_wrapper(
            title = "Status danger",
            widget_wrapper(
              fun = materialSwitch,
              args = list(inputId = ID(ids), label = "Danger", value = TRUE, status = "danger")
            )
          )
          ,
          box_wrapper(
            title = "Status success",
            widget_wrapper(
              fun = materialSwitch,
              args = list(inputId = ID(ids), label = "Success", value = TRUE, status = "success")
            )
          )
          ,
          box_wrapper(
            title = "Status warning",
            widget_wrapper(
              fun = materialSwitch,
              args = list(inputId = ID(ids), label = "Warning", value = TRUE, status = "warning")
            )
          )

        ),

        column(
          width = 4,

          box_wrapper(
            title = "Update",
            widget_wrapper(
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

          box_wrapper(
            title = "Default",
            widget_wrapper(
              fun = pickerInput,
              args = list(inputId = ID(ids), label = "Default", choices = c("a", "b", "c", "d"))
            )
          )
          ,
          box_wrapper(
            title = "Options group",
            widget_wrapper(
              fun = pickerInput,
              args = list(inputId = ID(ids), label = "Options group",
                          choices = list(lower = c("a", "b", "c", "d"), upper = c("A", "B", "C", "D")))
            )
          )
          ,
          box_wrapper(
            title = "Multiple",
            widget_wrapper(
              fun = pickerInput,
              args = list(inputId = ID(ids), label = "Multiple", choices = attr(UScitiesD, "Labels"), multiple = TRUE)
            )
          )
          ,
          box_wrapper(
            title = "Live search",
            widget_wrapper(
              fun = pickerInput,
              args = list(inputId = ID(ids), label = "Live search", choices = attr(UScitiesD, "Labels"),
                          options = list("live-search" = TRUE))
            )
          )
          ,
          box_wrapper(
            title = "Menu size",
            widget_wrapper(
              fun = pickerInput,
              args = list(inputId = ID(ids), label = "Menu size (5 items visible)", choices = LETTERS,
                          options = list(`size` = 5))
            )
          )

        ),

        column(
          width = 4,

          box_wrapper(
            title = "Placeholder",
            widget_wrapper(
              fun = pickerInput,
              args = list(inputId = ID(ids), label = "Placeholder", choices = c("a", "b", "c", "d"),
                          options = list(title = "This is a placeholder"))
            )
          )
          ,
          box_wrapper(
            title = "Selected text format",
            widget_wrapper(
              fun = pickerInput,
              args = list(inputId = ID(ids), label = "Selected text format (select >3 items)", choices = LETTERS,
                          options = list(`selected-text-format` = "count > 3"), multiple = TRUE)
            )
          )
          ,
          box_wrapper(
            title = "Style : primary",
            widget_wrapper(
              fun = pickerInput,
              args = list(inputId = ID(ids), label = "Style : primary", choices = c("a", "b", "c", "d"),
                          options = list(`style` = "btn-primary"))
            )
          )
          ,
          box_wrapper(
            title = "Style : danger",
            widget_wrapper(
              fun = pickerInput,
              args = list(inputId = ID(ids), label = "Style : danger", choices = c("a", "b", "c", "d"),
                          options = list(`style` = "btn-danger"))
            )
          )
          ,
          box_wrapper(
            title = "Style individual options",
            widget_wrapper(
              fun = pickerInput,
              args = list(inputId = ID(ids), label = "Style individual options with HTML",
                          choices = c("steelblue 150%", "right align + red", "bold", "background color"),
                          choicesOpt = list(
                            style = c("color: steelblue; font-size: 150%;", "color: firebrick; text-align: right;",
                                      "font-weight: bold;",
                                      "background: forestgreen; color: white;")
                          ))
            )
          )
          ,
          box_wrapper(
            title = "Style individual options (preserved)",
            widget_wrapper(
              fun = pickerInput,
              args = list(inputId = ID(ids), label = "Style individual options with HTML",
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

          box_wrapper(
            title = "Icons",
            widget_wrapper(
              fun = pickerInput,
              args = list(inputId = ID(ids), label = "Glyphicon",
                          choices = c("glyphicon-cog", "glyphicon-play", "glyphicon-ok-sign",
                                      "glyphicon-arrow-right", "glyphicon-euro", "glyphicon-music"),
                          choicesOpt = list(
                            icon = c("glyphicon-cog", "glyphicon-play", "glyphicon-ok-sign",
                                     "glyphicon-arrow-right", "glyphicon-euro", "glyphicon-music")
                          ))
            )
          )
          ,
          box_wrapper(
            title = "Subtext",
            widget_wrapper(
              fun = pickerInput,
              args = list(inputId = ID(ids), label = "Subtext",
                          choices = rownames(mtcars),
                          choicesOpt = list(
                            subtext = paste("mpg", mtcars$mpg, sep =": ")
                          ))
            )
          )
          ,
          box_wrapper(
            title = "Select/deselect all",
            widget_wrapper(
              fun = pickerInput,
              args = list(inputId = ID(ids), label = "Select/deselect all options", choices = LETTERS,
                          options = list(`actions-box` = TRUE), multiple = TRUE)
            )
          )
          ,
          box_wrapper(
            title = "Update choices",
            widget_wrapper(
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


    # tabProgressBars ----
    tabItem(
      tabName = "tabProgressBars",
      tags$h1("Progress Bars", style = "font-weight: bold; color: #d9534f;"),

      fluidRow(
        column(
          width = 6,

          box_wrapper(
            title = "Default",
            progressBar(id = "pb1", value = 50),
            sliderInput(inputId = "uppb1", label = "Update", min = 0, max = 100, value = 50),
            pb_code(
              id = "pb1",
              'progressBar(id = "pb1", value = 50)',
              'updateProgressBar(session = session, id = "pb1", value = input$slider)'
            )
          ),

          box_wrapper(
            title = "Status : info & title",
            progressBar(id = "pb2", value = 50, status = "info", title = "This is a progress bar"),
            sliderInput(inputId = "uppb2", label = "Update", min = 0, max = 100, value = 50),
            pb_code(
              id = "pb2",
              'progressBar(id = "pb2", value = 50, status = "info", title = "This is a progress bar")',
              'updateProgressBar(session = session, id = "pb2", value = input$slider)'
            )
          ),

          box_wrapper(
            title = "Status : danger & striped : true",
            progressBar(id = "pb3", value = 50, status = "danger", striped = TRUE),
            sliderInput(inputId = "uppb3", label = "Update", min = 0, max = 100, value = 50),
            pb_code(
              id = "pb3",
              'progressBar(id = "pb3", value = 50, status = "danger", striped = TRUE)',
              'updateProgressBar(session = session, id = "pb3", value = input$slider)'
            )
          )

        ),
        column(
          width = 6,

          box_wrapper(
            title = "Display : percent",
            progressBar(id = "pb4", value = 50, display_pct = TRUE),
            sliderInput(inputId = "uppb4", label = "Update", min = 0, max = 100, value = 50, step = 5),
            pb_code(
              id = "pb4",
              'progressBar(id = "pb4", value = 50, display_pct = TRUE)',
              'updateProgressBar(session = session, id = "pb4", value = input$slider)'
            )
          ),

          box_wrapper(
            title = "Status : warning & value > 100 (force value and total to appear)",
            progressBar(id = "pb5", value = 1500, total = 5000, status = "warning"),
            sliderInput(inputId = "uppb5", label = "Update", min = 0, max = 5000, value = 50),
            pb_code(
              id = "pb5",
              'progressBar(id = "pb5", value = 1500, total = 5000, status = "warning")',
              'updateProgressBar(session = session, id = "pb5", value = input$slider, total = 5000)'
            )
          ),

          box_wrapper(
            title = "Status : success & size : xs",
            progressBar(id = "pb6", value = 50, status = "success", size = "xs"),
            sliderInput(inputId = "uppb6", label = "Update", min = 0, max = 100, value = 50),
            pb_code(
              id = "pb6",
              'progressBar(id = "pb6", value = 50, status = "success", size = "xs")',
              'updateProgressBar(session = session, id = "pb6", value = input$slider)'
            )
          )

        ),

        column(
          width = 12,

          box_wrapper(
            title = "Status update",
            progressBar(id = "pb7", value = 50, display_pct = TRUE, status = "warning"),
            sliderInput(inputId = "uppb7", label = "Update", min = 0, max = 100, value = 50, step = 5),
            pb_code(
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

          box_wrapper(
            title = "",
            progressBar(id = "pb8", value = 1500, total = 5000, status = "info", display_pct = TRUE, striped = TRUE, title = "All options"),
            sliderInput(inputId = "uppb8", label = "Update", min = 0, max = 5000, value = 50),
            pb_code(
              id = "pb8",
              'progressBar(id = "pb8", value = 1500, total = 5000, status = "info", display_pct = TRUE, striped = TRUE, title = "All options")',
              'updateProgressBar(session = session, id = "pb8", value = input$slider, total = 5000)'
            )
          ),

          box_wrapper(
            title = "Update total",
            progressBar(id = "pb9", value = 1000, total = 1000, display_pct = TRUE),
            sliderInput(inputId = "uppb9", label = "Update", min = 1000, max = 5000, value = 1000, step = 50),
            pb_code(
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
          box_wrapper(
            title = NULL,
            widget_wrapper(
              fun = actionBttn,
              args = list(inputId = ID(ids), label = NULL, style = "material-circle", color = "danger", icon = icon("bars"))
            ),
            footer = NULL
          ),
          box_wrapper(
            title = NULL,
            widget_wrapper(
              fun = actionBttn,
              args = list(inputId = ID(ids), label = "material-flat", style = "material-flat", color = "danger")
            ),
            footer = NULL
          ),
          box_wrapper(
            title = NULL,
            widget_wrapper(
              fun = actionBttn,
              args = list(inputId = ID(ids), label = "pill", style = "pill", color = "danger")
            ),
            footer = NULL
          ),
          box_wrapper(
            title = NULL,
            widget_wrapper(
              fun = actionBttn,
              args = list(inputId = ID(ids), label = "float", style = "float", color = "danger")
            ),
            footer = NULL
          ),
          box_wrapper(
            title = NULL,
            widget_wrapper(
              fun = actionBttn,
              args = list(inputId = ID(ids), label = "unite", style = "unite", color = "danger")
            ),
            footer = NULL
          ),
          box_wrapper(
            title = NULL,
            widget_wrapper(
              fun = actionBttn,
              args = list(inputId = ID(ids), label = "fill", style = "fill", color = "danger")
            ),
            footer = NULL
          )
        ),



        column(
          width = 4,
          box_wrapper(
            title = NULL,
            widget_wrapper(
              fun = actionBttn,
              args = list(inputId = ID(ids), label = NULL, style = "simple", color = "primary", icon = icon("bars"))
            ),
            footer = NULL
          ),
          box_wrapper(
            title = NULL,
            widget_wrapper(
              fun = actionBttn,
              args = list(inputId = ID(ids), label = "bordered", style = "bordered", color = "success", icon = icon("sliders"))
            ),
            footer = NULL
          ),
          box_wrapper(
            title = NULL,
            widget_wrapper(
              fun = actionBttn,
              args = list(inputId = ID(ids), label = "minimal", style = "minimal", color = "danger")
            ),
            footer = NULL
          ),
          box_wrapper(
            title = NULL,
            widget_wrapper(
              fun = actionBttn,
              args = list(inputId = ID(ids), label = "stretch", style = "stretch", color = "warning")
            ),
            footer = NULL
          ),
          box_wrapper(
            title = NULL,
            widget_wrapper(
              fun = actionBttn,
              args = list(inputId = ID(ids), label = "jelly", style = "jelly", color = "danger")
            ),
            footer = NULL
          ),
          box_wrapper(
            title = NULL,
            widget_wrapper(
              fun = actionBttn,
              args = list(inputId = ID(ids), label = "gradient", style = "gradient", color = "danger", icon = icon("thumbs-up"))
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

        box(
          title = "Dropdown Button", status = "danger", width = 8,
          dropdownButton(
            tags$h3("List of Inputs"),
            selectInput(inputId = 'xcol', label = 'X Variable', choices = names(iris)),
            selectInput(inputId = 'ycol', label = 'Y Variable', choices = names(iris), selected = names(iris)[[2]]),
            sliderInput(inputId = 'clusters', label = 'Cluster count', value = 3, min = 1, max = 9),
            circle = TRUE, status = "danger", icon = icon("gear"), width = "300px",
            tooltip = tooltipOptions(title = "Click to see inputs !")
          ),
          plotOutput(outputId = 'plot1'),
          tags$p("if you want to hide inputs to focus on a plot.."),
          tags$b(tags$a(icon("code"), "Show code", `data-toggle`="collapse", href="#showcode_dropdownButton")),
          tags$div(
            class="collapse", id="showcode_dropdownButton",
            rCodeContainer(
              id="code_dropdownButton",
              code_dropdownButton
            )
          )
        ),

        box(
          title = "Sweet Alert", status = "danger", width = 4,
          tags$span(
            "via ",
            tags$a(href = "http://t4t5.github.io/sweetalert/", "sweetalert"),
            style="color: #d9534f;"
          ), br(), br(),
          fluidRow(
            column(
              width = 6,
              actionButton(inputId = "success", label = "Success !", width = "100%", class = "btn-success", style = "color: #FFF"),
              receiveSweetAlert(messageId = "successmessage"),
              br(), br(),
              actionButton(inputId = "tags", label = "With HTML tags", width = "100%"),
              receiveSweetAlert(messageId = "tagsmessage"),
              br(), br(),
              actionButton(inputId = "info", label = "Info", width = "100%", class = "btn-info", style = "color: #FFF"),
              receiveSweetAlert(messageId = "infomessage")
            ),
            column(
              width = 6,
              actionButton(inputId = "error", label = "Error", width = "100%", class = "btn-danger", style = "color: #FFF"),
              receiveSweetAlert(messageId = "errormessage"),
              br(), br(),
              actionButton(inputId = "warning", label = "Warning", width = "100%", class = "btn-warning", style = "color: #FFF"),
              receiveSweetAlert(messageId = "warningmessage")
            )
          )
        )

      ),

      fluidRow(

        box(
          title = "Dropdown (bis)", status = "danger", width = 8,
          dropdown(
            tags$h3("List of Input"),
            pickerInput(inputId = 'xcol2', label = 'X Variable', choices = names(iris), options = list(`style` = "btn-info")),
            pickerInput(inputId = 'ycol2', label = 'Y Variable', choices = names(iris), selected = names(iris)[[2]], options = list(`style` = "btn-warning")),
            sliderInput(inputId = 'clusters2', label = 'Cluster count', value = 3, min = 1, max = 9),
            style = "unite", icon = icon("gear"), status = "danger", width = "300px",
            animate = animateOptions(enter = animations$fading_entrances$fadeInLeftBig, exit = animations$fading_exits$fadeOutRightBig)
          ),
          plotOutput(outputId = 'plot2'),
          tags$p("In this version you can add animations and pickerInput will work in it."),
          tags$b(tags$a(icon("code"), "Show code", `data-toggle`="collapse", href="#showcode_dropdown")),
          tags$div(
            class="collapse", id="showcode_dropdown",
            rCodeContainer(
              id="code_dropdown",
              code_dropdown
            )
          )
        )

      )

    )

  )

)



# app ----

dashboardPage(header = header, sidebar = sidebar, body = body, skin = "red")


