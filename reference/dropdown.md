# Dropdown

Create a dropdown menu

## Usage

``` r
dropdown(
  ...,
  style = "default",
  status = "default",
  size = "md",
  icon = NULL,
  label = NULL,
  tooltip = FALSE,
  right = FALSE,
  up = FALSE,
  width = NULL,
  animate = FALSE,
  inputId = NULL,
  block = FALSE,
  no_outline = TRUE
)
```

## Arguments

- ...:

  List of tag to be displayed into the dropdown menu.

- style:

  Style of the button, to choose between `simple`, `bordered`,
  `minimal`, `stretch`, `jelly`, `gradient`, `fill`, `material-circle`,
  `material-flat`, `pill`, `float`, `unite`.

- status:

  Color of the button, see
  [`actionBttn()`](https://dreamrs.github.io/shinyWidgets/reference/actionBttn.md).

- size:

  Size of the button : `xs`,`sm`, `md`, `lg`.

- icon:

  An optional icon to appear on the button.

- label:

  The contents of the button, usually a text label.

- tooltip:

  Put a tooltip on the button, you can customize tooltip with
  [`tooltipOptions()`](https://dreamrs.github.io/shinyWidgets/reference/tooltipOptions.md).

- right:

  Logical. The dropdown menu starts on the right.

- up:

  Logical. Display the dropdown menu above.

- width:

  Width of the dropdown menu content.

- animate:

  Add animation on the dropdown, can be logical or result of
  [`animateOptions()`](https://dreamrs.github.io/shinyWidgets/reference/animateOptions.md).

- inputId:

  Optional, id for the button, the button act like an `actionButton`,
  and you can use the id to toggle the dropdown menu server-side.

- block:

  Logical, full width button.

- no_outline:

  Logical, don't show outline when navigating with keyboard/interact
  using mouse or touch.

## Details

This function is similar to
[`dropdownButton()`](https://dreamrs.github.io/shinyWidgets/reference/dropdownButton.md)
but don't use Bootstrap, so you can use
[`pickerInput()`](https://dreamrs.github.io/shinyWidgets/reference/pickerInput.md)
in it. Moreover you can add animations on the appearance / disappearance
of the dropdown with animate.css.

## See also

[`dropMenu()`](https://dreamrs.github.io/shinyWidgets/reference/dropMenu.md)
for a more robust alternative.

## Examples

``` r
## Only run examples in interactive R sessions
if (interactive()) {

library("shiny")
library("shinyWidgets")

ui <- fluidPage(
  tags$h2("pickerInput in dropdown"),
  br(),
  dropdown(

    tags$h3("List of Input"),

    pickerInput(inputId = 'xcol2',
                label = 'X Variable',
                choices = names(iris),
                options = list(`style` = "btn-info")),

    pickerInput(inputId = 'ycol2',
                label = 'Y Variable',
                choices = names(iris),
                selected = names(iris)[[2]],
                options = list(`style` = "btn-warning")),

    sliderInput(inputId = 'clusters2',
                label = 'Cluster count',
                value = 3,
                min = 1, max = 9),

    style = "unite", icon = icon("gear"),
    status = "danger", width = "300px",
    animate = animateOptions(
      enter = animations$fading_entrances$fadeInLeftBig,
      exit = animations$fading_exits$fadeOutRightBig
    )
  ),

  plotOutput(outputId = 'plot2')
)

server <- function(input, output, session) {

  selectedData2 <- reactive({
    iris[, c(input$xcol2, input$ycol2)]
  })

  clusters2 <- reactive({
    kmeans(selectedData2(), input$clusters2)
  })

  output$plot2 <- renderPlot({
    palette(c("#E41A1C", "#377EB8", "#4DAF4A",
              "#984EA3", "#FF7F00", "#FFFF33",
              "#A65628", "#F781BF", "#999999"))

    par(mar = c(5.1, 4.1, 0, 1))
    plot(selectedData2(),
         col = clusters2()$cluster,
         pch = 20, cex = 3)
    points(clusters2()$centers, pch = 4, cex = 4, lwd = 4)
  })

}

shinyApp(ui = ui, server = server)

}
```
