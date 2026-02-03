# Dropdown Button

Create a dropdown menu with Bootstrap where you can put input elements.

## Usage

``` r
dropdownButton(
  ...,
  circle = TRUE,
  status = "default",
  size = "default",
  icon = NULL,
  label = NULL,
  tooltip = FALSE,
  right = FALSE,
  up = FALSE,
  width = NULL,
  margin = "10px",
  inline = FALSE,
  inputId = NULL
)
```

## Arguments

- ...:

  List of tag to be displayed into the dropdown menu.

- circle:

  Logical. Use a circle button

- status:

  Add a class to the buttons, you can use Bootstrap status like 'info',
  'primary', 'danger', 'warning' or 'success'. Or use an arbitrary
  strings to add a custom class, e.g. : with `status = 'myClass'`,
  buttons will have class `btn-myClass`.

- size:

  Size of the button : default, lg, sm, xs.

- icon:

  An icon to appear on the button.

- label:

  Label to appear on the button. If circle = TRUE and tooltip = TRUE,
  label is used in tooltip.

- tooltip:

  Put a tooltip on the button, you can customize tooltip with
  `tooltipOptions`.

- right:

  Logical. The dropdown menu starts on the right.

- up:

  Logical. Display the dropdown menu above.

- width:

  Width of the dropdown menu content.

- margin:

  Value of the dropdown margin-right and margin-left menu content.

- inline:

  use an inline
  ([`span()`](https://rstudio.github.io/htmltools/reference/builder.html))
  or block container
  ([`div()`](https://rstudio.github.io/htmltools/reference/builder.html))
  for the output.

- inputId:

  Optional, id for the button, the button act like an `actionButton`,
  and you can use the id to toggle the dropdown menu server-side with
  [`toggleDropdownButton`](https://dreamrs.github.io/shinyWidgets/reference/toggleDropdownButton.md).

## Details

It is possible to know if a dropdown is open or closed server-side with
`input$<inputId>_state`.

## Note

`pickerInput` doesn't work inside `dropdownButton` because that's also a
dropdown and you can't nest them. Instead use
[`dropdown`](https://dreamrs.github.io/shinyWidgets/reference/dropdown.md),
it has similar features but is built differently so it works.

## Examples

``` r
## Only run examples in interactive R sessions
if (interactive()) {

library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  dropdownButton(
    inputId = "mydropdown",
    label = "Controls",
    icon = icon("sliders"),
    status = "primary",
    circle = FALSE,
    sliderInput(
      inputId = "n",
      label = "Number of observations",
      min = 10, max = 100, value = 30
    ),
    prettyToggle(
      inputId = "na",
      label_on = "NAs keeped",
      label_off = "NAs removed",
      icon_on = icon("check"),
      icon_off = icon("xmark")
    )
  ),
  tags$div(style = "height: 140px;"), # spacing
  verbatimTextOutput(outputId = "out"),
  verbatimTextOutput(outputId = "state")
)

server <- function(input, output, session) {

  output$out <- renderPrint({
    cat(
      " # n\n", input$n, "\n",
      "# na\n", input$na
    )
  })

  output$state <- renderPrint({
    cat("Open:", input$mydropdown_state)
  })

}

shinyApp(ui, server)

}
```
