# Create a download `actionBttn`

Create a download button with
[`actionBttn()`](https://dreamrs.github.io/shinyWidgets/reference/actionBttn.md).

## Usage

``` r
downloadBttn(
  outputId,
  label = "Download",
  style = "unite",
  color = "primary",
  size = "md",
  block = FALSE,
  no_outline = TRUE,
  icon = shiny::icon("download")
)
```

## Arguments

- outputId:

  The name of the output slot that the
  [`shiny::downloadHandler()`](https://rdrr.io/pkg/shiny/man/downloadHandler.html)
  is assigned to.

- label:

  The contents of the button, usually a text label.

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

- icon:

  An optional icon to appear on the button.

## See also

[`actionBttn()`](https://dreamrs.github.io/shinyWidgets/reference/actionBttn.md)

## Examples

``` r
if (interactive()) {

library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h2("Download bttn"),
  downloadBttn(
    outputId = "downloadData",
    style = "bordered",
    color = "primary"
  )
)

server <- function(input, output, session) {

  output$downloadData <- downloadHandler(
    filename = function() {
      paste('data-', Sys.Date(), '.csv', sep='')
    },
    content = function(con) {
      write.csv(mtcars, con)
    }
  )

}

shinyApp(ui, server)

}
```
