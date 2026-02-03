# Custom background color for your shinyapp

Allow to change the background color of your shiny application.

## Usage

``` r
setBackgroundColor(
  color = "ghostwhite",
  gradient = c("linear", "radial"),
  direction = c("bottom", "top", "right", "left"),
  shinydashboard = FALSE
)
```

## Arguments

- color:

  Background color. Use either the fullname or the Hex code
  (<https://www.w3schools.com/colors/colors_hex.asp>). If more than one
  color is used, a gradient background is set.

- gradient:

  Type of gradient: `linear` or `radial`.

- direction:

  Direction for gradient, by default to `bottom`. Possibles choices are
  `bottom`, `top`, `right` or `left`, two values can be used, e.g.
  `c("bottom", "right")`.

- shinydashboard:

  Set to `TRUE` if in a shinydasboard application.

## Examples

``` r
if (interactive()) {

### Uniform color background :

library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h2("Change shiny app background"),
  setBackgroundColor("ghostwhite")
)

server <- function(input, output, session) {

}

shinyApp(ui, server)


### linear gradient background :

library(shiny)
library(shinyWidgets)

ui <- fluidPage(

  # use a gradient in background
  setBackgroundColor(
    color = c("#F7FBFF", "#2171B5"),
    gradient = "linear",
    direction = "bottom"
  ),

  titlePanel("Hello Shiny!"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("obs",
                  "Number of observations:",
                  min = 0,
                  max = 1000,
                  value = 500)
    ),
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

server <- function(input, output, session) {
  output$distPlot <- renderPlot({
    hist(rnorm(input$obs))
  })
}

shinyApp(ui, server)


### radial gradient background :

library(shiny)
library(shinyWidgets)

ui <- fluidPage(

  # use a gradient in background
  setBackgroundColor(
    color = c("#F7FBFF", "#2171B5"),
    gradient = "radial",
    direction = c("top", "left")
  ),

  titlePanel("Hello Shiny!"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("obs",
                  "Number of observations:",
                  min = 0,
                  max = 1000,
                  value = 500)
    ),
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

server <- function(input, output, session) {
  output$distPlot <- renderPlot({
    hist(rnorm(input$obs))
  })
}

shinyApp(ui, server)

}
```
