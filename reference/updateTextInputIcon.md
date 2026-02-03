# Change the value of a text input icon on the client

Change the value of a text input icon on the client

## Usage

``` r
updateTextInputIcon(
  session = getDefaultReactiveDomain(),
  inputId,
  label = NULL,
  value = NULL,
  placeholder = NULL,
  icon = NULL
)
```

## Arguments

- session:

  The `session` object passed to function given to `shinyServer`.
  Default is
  [`getDefaultReactiveDomain()`](https://rdrr.io/pkg/shiny/man/domains.html).

- inputId:

  The id of the input object.

- label:

  The label to set for the input object.

- value:

  Initial value.

- placeholder:

  A character string giving the user a hint as to what can be entered
  into the control. Internet Explorer 8 and 9 do not support this
  option.

- icon:

  Icon to update, note that you can update icon only if initialized in
  [`textInputIcon()`](https://dreamrs.github.io/shinyWidgets/reference/textInputIcon.md).

## Value

No value.

## See also

[`textInputIcon()`](https://dreamrs.github.io/shinyWidgets/reference/textInputIcon.md)

## Examples

``` r
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  textInputIcon(
    inputId = "id",
    label = "With an icon",
    icon = icon("circle-user")
  ),
  actionButton("updateValue", "Update value"),
  actionButton("updateIcon", "Update icon"),
  verbatimTextOutput("value")
)

server <- function(input, output, session) {

  output$value <- renderPrint(input$id)

  observeEvent(input$updateValue, {
    updateTextInputIcon(
      session = session,
      inputId = "id",
      value = paste(sample(letters, 8), collapse = "")
    )
  })

  observeEvent(input$updateIcon, {
    i <- sample(c("home", "gears", "dollar-sign", "globe", "sliders-h"), 1)
    updateTextInputIcon(
      session = session,
      inputId = "id",
      icon = icon(i)
    )
  })

}

if (interactive())
  shinyApp(ui, server)
```
