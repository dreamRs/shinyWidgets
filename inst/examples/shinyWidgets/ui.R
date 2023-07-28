
#  ------------------------------------------------------------------------
#
# Title : shinyWidgets Gallery - ui
#    By : Victor
#  Date : 2020-12-01
#
#  ------------------------------------------------------------------------


library(shiny)
library(bslib)

ui <- page_navbar(
  theme = bs_add_rules(bs_theme(
    version = 5,
    # bg = "#FFFFFF",
    # fg = "#5E81AC",
    primary = "#4C566A",
    danger = "#BF616A",
    "well-bg" = "#FFF",
    base_font = font_google("Poppins")
  ), rules = c(
    ".nav-link.active {@extend .text-light }"
  )),
  title = tags$b("shinyWidgets gallery", class = "text-light"),
  window_title = "shinyWidgets gallery",
  bg = "#4C566A",
  nav_spacer(),
  nav_item(
    class = "text-light", paste0("v", packageVersion("shinyWidgets"))
  ),
  header = tags$div(
    class = "my-2",
    navlistPanel(
      id = "tabs",
      well = TRUE,
      fluid = FALSE,
      widths = c(2, 10),
      tabPanel(
        title = "Overview",
        value = "tabOverview",
        icon = icon("table-cells"),
        .shinyWidgetGalleryFuns$tabOverview()
      ),
      tabPanel(
        title = "switchInput",
        value = "tabswitchInput",
        icon = icon("toggle-on"),
        .shinyWidgetGalleryFuns$tabswitchInput()
      ),
      tabPanel(
        title = "Pretty Checkboxes & Radios",
        value = "tabPretty",
        icon = icon("circle-check"),
        .shinyWidgetGalleryFuns$tabPretty()
      ),
      tabPanel(
        title = "Awesome Checkboxes & Radios",
        value = "tabAwesome",
        icon = icon("square-check"),
        .shinyWidgetGalleryFuns$tabAwesome()
      ),
      tabPanel(
        title = "checkboxGroup Buttons",
        value = "tabcheckButtons",
        icon = icon("square"),
        .shinyWidgetGalleryFuns$tabcheckButtons()
      ),
      tabPanel(
        title = "radio Buttons",
        value = "tabradioButtons",
        icon = icon("circle"),
        .shinyWidgetGalleryFuns$tabradioButtons()
      ),
      tabPanel(
        title = "materialSwitch",
        value = "tabMaterialSwitch",
        icon = icon("toggle-off"),
        .shinyWidgetGalleryFuns$tabMaterialSwitch()
      ),
      tabPanel(
        title = "pickerInput",
        value = "tabPickerInput",
        icon = icon("caret-down"),
        .shinyWidgetGalleryFuns$tabPickerInput()
      ),
      tabPanel(
        title = "virtualSelect",
        value = "tabVirtualSelect",
        icon = icon("square-caret-down"),
        .shinyWidgetGalleryFuns$tabVirtualSelect()
      ),
      tabPanel(
        title = "airDatepicker",
        value = "tabAirDate",
        icon = icon("calendar"),
        .shinyWidgetGalleryFuns$tabAirDate()
      ),
      tabPanel(
        title = "sliderText",
        value = "tabSliderText",
        icon = icon("sliders"),
        .shinyWidgetGalleryFuns$tabSliderText()
      ),
      tabPanel(
        title = "progressBar",
        value = "tabProgressBars",
        icon = icon("list-check"),
        .shinyWidgetGalleryFuns$tabProgressBars()
      ),
      tabPanel(
        title = "bttn",
        value = "tabBttn",
        icon = icon("square"),
        .shinyWidgetGalleryFuns$tabBttn()
      ),
      tabPanel(
        title = "dropdowns & sweetalert",
        value = "tabOtherStuff",
        icon = icon("circle-plus"),
        .shinyWidgetGalleryFuns$tabOtherStuff()
      )
    )
  )
)
