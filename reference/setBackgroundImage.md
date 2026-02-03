# Custom background image for your shinyapp

Allow to change the background image of your shinyapp.

## Usage

``` r
setBackgroundImage(src = NULL, shinydashboard = FALSE)
```

## Arguments

- src:

  Url or path to the image, if using local image, the file must be in
  `www/` directory and the path not contain `www/`.

- shinydashboard:

  Set to `TRUE` if in a shinydasboard application.

## Examples

``` r
if (interactive()) {

library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h2("Add a shiny app background image"),
  setBackgroundImage(
    src = "https://www.fillmurray.com/1920/1080"
  )
)

server <- function(input, output, session) {

}

shinyApp(ui, server)

}
```
