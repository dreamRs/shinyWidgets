library(shiny)
library(shinyWidgets)
library(bslib)

# Custom rules to match virtual select CSS classes to Boostrap classes
vs_rules <- c(
  ".vscomp-toggle-button { @extend .btn }",
  ".vscomp-toggle-button { @extend .btn-outline-secondary }",
  ".vscomp-toggle-button { @extend .text-start }",
  ".vscomp-arrow::after { @extend .border-dark }",
  ".vscomp-arrow::after { @extend .border-start-0 }",
  ".vscomp-arrow::after { @extend .border-top-0 }",
  ".vscomp-option:hover { @extend .bg-primary }",
  ".vscomp-option  { @extend .bg-light }",
  ".vscomp-search-wrapper { @extend .bg-light }",
  ".vscomp-toggle-all-label { @extend .bg-light }"
)

# Light theme
light <- bs_add_rules(
  bs_theme(preset = "bootstrap"),
  vs_rules
)

# Dark theme
dark <- bs_add_rules(
  bs_theme(preset = "bootstrap", bg = "black", fg = "white"),
  vs_rules
)

ui <- fluidPage(
  theme = light,
  checkboxInput("dark_mode", "Dark mode"),
  tags$h2("bslib theming for Virtual Select"),
  virtualSelectInput(
    inputId = "single",
    label = "Single select :",
    choices = month.name,
    search = TRUE
  ),
  virtualSelectInput(
    inputId = "multiple",
    label = "Multiple select:",
    choices = setNames(month.abb, month.name),
    multiple = TRUE
  )
)

server <- function(input, output, session) {
  observe(session$setCurrentTheme(
    if (isTRUE(input$dark_mode)) dark else light
  ))
}

if (interactive())
  shinyApp(ui, server)
