# Theme selector for `sliderInput`

Customize the appearance of the original shiny's `sliderInput`

## Usage

``` r
chooseSliderSkin(
  skin = c("Shiny", "Flat", "Big", "Modern", "Sharp", "Round", "Square"),
  color = NULL
)
```

## Arguments

- skin:

  The `skin` to apply. Choose among 5 different flavors, namely 'Shiny',
  'Flat', 'Modern', 'Round' and 'Square'.

- color:

  A color to apply to all sliders. Works with following skins: 'Shiny',
  'Flat', 'Modern', 'HTML5'. For 'Flat' a CSS filter is applied, desired
  color maybe a little offset.

## Note

It is not currently possible to apply multiple themes at the same time.

## See also

See
[`setSliderColor`](https://dreamrs.github.io/shinyWidgets/reference/deprecated.md)
to update the color of your sliderInput.

## Examples

``` r
if (interactive()) {

library(shiny)
library(shinyWidgets)

# With Modern design

ui <- fluidPage(
  chooseSliderSkin("Modern"),
  sliderInput("obs", "Customized single slider:",
              min = 0, max = 100, value = 50
  ),
  sliderInput("obs2", "Customized range slider:",
              min = 0, max = 100, value = c(40, 80)
  ),
  plotOutput("distPlot")
)

server <- function(input, output) {

  output$distPlot <- renderPlot({
    hist(rnorm(input$obs))
  })

}

shinyApp(ui, server)



# Use Flat design & a custom color

ui <- fluidPage(
  chooseSliderSkin("Flat", color = "#112446"),
  sliderInput("obs", "Customized single slider:",
              min = 0, max = 100, value = 50
  ),
  sliderInput("obs2", "Customized range slider:",
              min = 0, max = 100, value = c(40, 80)
  ),
  sliderInput("obs3", "An other slider:",
              min = 0, max = 100, value = 50
  ),
  plotOutput("distPlot")
)

server <- function(input, output) {

  output$distPlot <- renderPlot({
    hist(rnorm(input$obs))
  })
}

shinyApp(ui, server)

}
```
