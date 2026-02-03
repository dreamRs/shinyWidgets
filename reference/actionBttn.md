# Awesome action button

Like
[`shiny::actionButton()`](https://rdrr.io/pkg/shiny/man/actionButton.html)
but awesome, via <https://bttn.surge.sh/>

## Usage

``` r
actionBttn(
  inputId,
  label = NULL,
  icon = NULL,
  style = "unite",
  color = "default",
  size = "md",
  block = FALSE,
  no_outline = TRUE,
  ...
)
```

## Arguments

- inputId:

  The `input` slot that will be used to access the value.

- label:

  The contents of the button, usually a text label.

- icon:

  An optional icon to appear on the button.

- style:

  Style of the button, to choose between `simple`, `bordered`,
  `minimal`, `stretch`, `jelly`, `gradient`, `fill`, `material-circle`,
  `material-flat`, `pill`, `float`, `unite`.

- color:

  Color of the button : `default`, `primary`, `warning`, `danger`,
  `success`, `royal`.

- size:

  Size of the button : `xs`,`sm`, `md`, `lg`.

- block:

  Logical, full width button.

- no_outline:

  Logical, don't show outline when navigating with keyboard/interact
  using mouse or touch.

- ...:

  Other arguments to pass to the container tag function.

## See also

[`downloadBttn()`](https://dreamrs.github.io/shinyWidgets/reference/downloadBttn.md)

## Examples

``` r
if (interactive()) {

library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h2("Awesome action button"),
  tags$br(),
  actionBttn(
    inputId = "bttn1",
    label = "Go!",
    color = "primary",
    style = "bordered"
  ),
  tags$br(),
  verbatimTextOutput(outputId = "res_bttn1"),
  tags$br(),
  actionBttn(
    inputId = "bttn2",
    label = "Go!",
    color = "success",
    style = "material-flat",
    icon = icon("sliders"),
    block = TRUE
  ),
  tags$br(),
  verbatimTextOutput(outputId = "res_bttn2")
)

server <- function(input, output, session) {
  output$res_bttn1 <- renderPrint(input$bttn1)
  output$res_bttn2 <- renderPrint(input$bttn2)
}

shinyApp(ui = ui, server = server)

}
```
