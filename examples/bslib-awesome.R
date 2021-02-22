
library(shiny)
library(shinyWidgets)
library(bslib)

choices <- month.name[1:3]

ui <- fluidPage(
  theme = bs_theme(
    primary = "purple",
    info = "#00FF00",
    success = "#08088A",
    warning = "#D7DF01",
    danger = "#FA58D0"
  ),
  tags$h2("Checkbox"),
  tags$hr(),
  awesomeCheckbox("primary", "Pretty primary", value = TRUE, status = "primary"),
  awesomeCheckbox("info", "Pretty info", value = TRUE, status = "info"),
  awesomeCheckbox("success", "Pretty success", value = TRUE, status = "success"),
  awesomeCheckbox("warning", "Pretty warning", value = TRUE, status = "warning"),
  awesomeCheckbox("danger", "Pretty danger", value = TRUE, status = "danger"),

  tags$h2("Checkbox group"),
  tags$hr(),
  awesomeCheckboxGroup("primary1", "Pretty primary", choices, choices, status = "primary"),
  awesomeCheckboxGroup("info1", "Pretty info", choices, choices, status = "info"),
  awesomeCheckboxGroup("success1", "Pretty success", choices, choices, status = "success"),
  awesomeCheckboxGroup("warning1", "Pretty warning", choices, choices, status = "warning"),
  awesomeCheckboxGroup("danger1", "Pretty danger", choices, choices, status = "danger"),

  tags$h2("Checkbox group (inline)"),
  tags$hr(),
  awesomeCheckboxGroup("primary2", "Pretty primary", choices, choices, status = "primary", inline = TRUE),
  awesomeCheckboxGroup("info2", "Pretty info", choices, choices, status = "info", inline = TRUE),
  awesomeCheckboxGroup("success2", "Pretty success", choices, choices, status = "success", inline = TRUE),
  awesomeCheckboxGroup("warning2", "Pretty warning", choices, choices, status = "warning", inline = TRUE),
  awesomeCheckboxGroup("danger2", "Pretty danger", choices, choices, status = "danger", inline = TRUE),

  tags$h2("Radio Buttons"),
  tags$hr(),
  awesomeRadio("primary3", "Pretty primary", choices = choices, status = "primary"),
  awesomeRadio("info3", "Pretty info", choices = choices, status = "info"),
  awesomeRadio("success3", "Pretty success", choices = choices, status = "success"),
  awesomeRadio("warning3", "Pretty warning", choices = choices, status = "warning"),
  awesomeRadio("danger3", "Pretty danger", choices = choices, status = "danger"),

  tags$h2("Radio Buttons (inline)"),
  tags$hr(),
  awesomeRadio("primary4", "Pretty primary", choices = choices, status = "primary", inline = TRUE),
  awesomeRadio("info4", "Pretty info", choices = choices, status = "info", inline = TRUE),
  awesomeRadio("success4", "Pretty success", choices = choices, status = "success", inline = TRUE),
  awesomeRadio("warning4", "Pretty warning", choices = choices, status = "warning", inline = TRUE),
  awesomeRadio("danger4", "Pretty danger", choices = choices, status = "danger", inline = TRUE)
)

server <- function(input, output, session) {

}

if (interactive())
  shinyApp(ui = ui, server = server)
