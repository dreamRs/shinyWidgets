# Drop Menu

A pop-up menu to hide inputs and other elements into.

## Usage

``` r
dropMenu(
  tag,
  ...,
  padding = "5px",
  placement = c("bottom", "bottom-start", "bottom-end", "top", "top-start", "top-end",
    "right", "right-start", "right-end", "left", "left-start", "left-end"),
  trigger = "click",
  arrow = TRUE,
  theme = c("light", "light-border", "material", "translucent"),
  hideOnClick = TRUE,
  maxWidth = "none",
  options = NULL
)
```

## Arguments

- tag:

  An HTML tag to which attach the menu.

- ...:

  UI elements to be displayed in the menu.

- padding:

  Amount of padding to apply. Can be numeric (in pixels) or character
  (e.g. "3em").

- placement:

  Positions of the menu relative to its reference element (`tag`).

- trigger:

  The event(s) which cause the menu to show.

- arrow:

  Determines if the menu has an arrow.

- theme:

  CSS theme to use.

- hideOnClick:

  Determines if the menu should hide if a mousedown event was fired
  outside of it (i.e. clicking on the reference element or the body of
  the page).

- maxWidth:

  Determines the maximum width of the menu.

- options:

  Additional options, see
  [`dropMenuOptions`](https://dreamrs.github.io/shinyWidgets/reference/dropMenuOptions.md).

## Value

A UI definition.

## See also

[dropMenu
interaction](https://dreamrs.github.io/shinyWidgets/reference/drop-menu-interaction.md)
for functions and examples to interact with `dropMenu` from server.

## Examples

``` r
if (interactive()) {
  library(shiny)
  library(shinyWidgets)

  ui <- fluidPage(
    tags$h3("drop example"),

    dropMenu(
      actionButton("go0", "See what"),
      tags$div(
        tags$h3("This is a dropdown"),
        tags$ul(
          tags$li("You can use HTML inside"),
          tags$li("Maybe Shiny inputs"),
          tags$li("And maybe outputs"),
          tags$li("and should work in markdown")
        )
      ),
      theme = "light-border",
      placement = "right",
      arrow = FALSE
    ),

    tags$br(),


    dropMenu(
      actionButton("go", "See what"),
      tags$h3("Some inputs"),
      sliderInput(
        "obs", "Number of observations:",
        min = 0, max = 1000, value = 500
      ),
      selectInput(
        "variable", "Variable:",
        c("Cylinders" = "cyl",
          "Transmission" = "am",
          "Gears" = "gear")
      ),
      pickerInput(
        inputId = "pckr",
        label = "Select all option",
        choices = rownames(mtcars),
        multiple = TRUE,
        options = list(`actions-box` = TRUE)
      ),
      radioButtons(
        "dist", "Distribution type:",
        c("Normal" = "norm",
          "Uniform" = "unif",
          "Log-normal" = "lnorm",
          "Exponential" = "exp")
      )
    ),
    verbatimTextOutput("slider"),
    verbatimTextOutput("select"),
    verbatimTextOutput("picker"),
    verbatimTextOutput("radio")
  )

  server <- function(input, output, session) {

    output$slider <- renderPrint(input$obs)
    output$select <- renderPrint(input$variable)
    output$picker <- renderPrint(input$pckr)
    output$radio <- renderPrint(input$dist)

  }

  shinyApp(ui, server)
}
```
