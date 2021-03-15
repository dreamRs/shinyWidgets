
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
  awesomeCheckbox("primary", "Awesome primary", value = TRUE, status = "primary"),
  awesomeCheckbox("info", "Awesome info", value = TRUE, status = "info"),
  awesomeCheckbox("success", "Awesome success", value = TRUE, status = "success"),
  awesomeCheckbox("warning", "Awesome warning", value = TRUE, status = "warning"),
  awesomeCheckbox("danger", "Awesome danger", value = TRUE, status = "danger"),

  tags$h2("Checkbox group"),
  tags$hr(),
  awesomeCheckboxGroup("primary1", "Awesome primary", choices, choices, status = "primary"),
  awesomeCheckboxGroup("info1", "Awesome info", choices, choices, status = "info"),
  awesomeCheckboxGroup("success1", "Awesome success", choices, choices, status = "success"),
  awesomeCheckboxGroup("warning1", "Awesome warning", choices, choices, status = "warning"),
  awesomeCheckboxGroup("danger1", "Awesome danger", choices, choices, status = "danger"),

  tags$h2("Checkbox group (inline)"),
  tags$hr(),
  awesomeCheckboxGroup("primary2", "Awesome primary", choices, choices, status = "primary", inline = TRUE),
  awesomeCheckboxGroup("info2", "Awesome info", choices, choices, status = "info", inline = TRUE),
  awesomeCheckboxGroup("success2", "Awesome success", choices, choices, status = "success", inline = TRUE),
  awesomeCheckboxGroup("warning2", "Awesome warning", choices, choices, status = "warning", inline = TRUE),
  awesomeCheckboxGroup("danger2", "Awesome danger", choices, choices, status = "danger", inline = TRUE),

  tags$h2("Radio Buttons"),
  tags$hr(),
  awesomeRadio("primary3", "Awesome primary", choices = choices, status = "primary"),
  awesomeRadio("info3", "Awesome info", choices = choices, status = "info"),
  awesomeRadio("success3", "Awesome success", choices = choices, status = "success"),
  awesomeRadio("warning3", "Awesome warning", choices = choices, status = "warning"),
  awesomeRadio("danger3", "Awesome danger", choices = choices, status = "danger"),

  tags$h2("Radio Buttons (inline)"),
  tags$hr(),
  awesomeRadio("primary4", "Awesome primary", choices = choices, status = "primary", inline = TRUE),
  awesomeRadio("info4", "Awesome info", choices = choices, status = "info", inline = TRUE),
  awesomeRadio("success4", "Awesome success", choices = choices, status = "success", inline = TRUE),
  awesomeRadio("warning4", "Awesome warning", choices = choices, status = "warning", inline = TRUE),
  awesomeRadio("danger4", "Awesome danger", choices = choices, status = "danger", inline = TRUE)
)

server <- function(input, output, session) {

}

if (interactive())
  shinyApp(ui = ui, server = server)
