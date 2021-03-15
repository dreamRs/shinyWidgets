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
  prettyCheckbox("primary", "Pretty primary", value = TRUE, status = "primary"),
  prettyCheckbox("info", "Pretty info", value = TRUE, status = "info"),
  prettyCheckbox("success", "Pretty success", value = TRUE, status = "success"),
  prettyCheckbox("warning", "Pretty warning", value = TRUE, status = "warning"),
  prettyCheckbox("danger", "Pretty danger", value = TRUE, status = "danger"),

  tags$h2("Checkbox group"),
  tags$hr(),
  prettyCheckboxGroup("primary1", "Pretty primary", choices, choices, status = "primary"),
  prettyCheckboxGroup("info1", "Pretty info", choices, choices, status = "info"),
  prettyCheckboxGroup("success1", "Pretty success", choices, choices, status = "success"),
  prettyCheckboxGroup("warning1", "Pretty warning", choices, choices, status = "warning"),
  prettyCheckboxGroup("danger1", "Pretty danger", choices, choices, status = "danger"),

  tags$h2("Checkbox group (inline)"),
  tags$hr(),
  prettyCheckboxGroup("primary2", "Pretty primary", choices, choices, status = "primary", inline = TRUE),
  prettyCheckboxGroup("info2", "Pretty info", choices, choices, status = "info", inline = TRUE),
  prettyCheckboxGroup("success2", "Pretty success", choices, choices, status = "success", inline = TRUE),
  prettyCheckboxGroup("warning2", "Pretty warning", choices, choices, status = "warning", inline = TRUE),
  prettyCheckboxGroup("danger2", "Pretty danger", choices, choices, status = "danger", inline = TRUE),

  tags$h2("Radio buttons"),
  tags$hr(),
  prettyRadioButtons("primary3", "Pretty primary", choices, status = "primary"),
  prettyRadioButtons("info3", "Pretty info", choices, status = "info"),
  prettyRadioButtons("success3", "Pretty success", choices, status = "success"),
  prettyRadioButtons("warning3", "Pretty warning", choices, status = "warning"),
  prettyRadioButtons("danger3", "Pretty danger", choices, status = "danger"),

  tags$h2("Radio buttons (inline)"),
  tags$hr(),
  prettyRadioButtons("primary4", "Pretty primary", choices, status = "primary", inline = TRUE),
  prettyRadioButtons("info4", "Pretty info", choices, status = "info", inline = TRUE),
  prettyRadioButtons("success4", "Pretty success", choices, status = "success", inline = TRUE),
  prettyRadioButtons("warning4", "Pretty warning", choices, status = "warning", inline = TRUE),
  prettyRadioButtons("danger4", "Pretty danger", choices, status = "danger", inline = TRUE)
)

server <- function(input, output, session) {

}

if (interactive())
  shinyApp(ui = ui, server = server)
