# Toggle a dropdown menu

Open or close a dropdown menu server-side.

## Usage

``` r
toggleDropdownButton(inputId, session = getDefaultReactiveDomain())
```

## Arguments

- inputId:

  Id for the dropdown to toggle.

- session:

  Standard shiny `session`.

## Examples

``` r
if (interactive()) {

library("shiny")
library("shinyWidgets")

ui <- fluidPage(
  tags$h2("Toggle Dropdown Button"),
  br(),
  fluidRow(
    column(
      width = 6,
      dropdownButton(
        tags$h3("List of Inputs"),
        selectInput(inputId = 'xcol',
                    label = 'X Variable',
                    choices = names(iris)),
        sliderInput(inputId = 'clusters',
                    label = 'Cluster count',
                    value = 3,
                    min = 1,
                    max = 9),
        actionButton(inputId = "toggle2",
                     label = "Close dropdown"),
        circle = TRUE, status = "danger",
        inputId = "mydropdown",
        icon = icon("gear"), width = "300px"
      )
    ),
    column(
      width = 6,
      actionButton(inputId = "toggle1",
                   label = "Open dropdown")
    )
  )
)

server <- function(input, output, session) {

  observeEvent(list(input$toggle1, input$toggle2), {
    toggleDropdownButton(inputId = "mydropdown")
  }, ignoreInit = TRUE)

}

shinyApp(ui = ui, server = server)

}
```
