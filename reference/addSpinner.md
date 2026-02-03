# Display a spinner above an output when this one recalculate

Display a spinner above an output when this one recalculate

## Usage

``` r
addSpinner(output, spin = "double-bounce", color = "#112446")
```

## Arguments

- output:

  An output element, typically the result of `renderPlot`.

- spin:

  Style of the spinner, choice between : `circle`, `bounce`,
  `folding-cube`, `rotating-plane`, `cube-grid`, `fading-circle`,
  `double-bounce`, `dots`, `cube`.

- color:

  Color for the spinner.

## Value

a list of tags

## Note

The spinner don't disappear from the page, it's only masked by the plot,
so the plot must have a non-transparent background. For a more robust
way to insert loaders, see package "shinycssloaders".

## Examples

``` r
# wrap an output:
addSpinner(shiny::plotOutput("plot"))
#> <div style="position: relative; width:100%; height:400px;">
#>   <div class="spinner loading-spinner">
#>     <div class="double-bounce1" style="background-color: #112446;"></div>
#>     <div class="double-bounce2" style="background-color: #112446;"></div>
#>   </div>
#>   <div class="shiny-plot-output html-fill-item" id="plot" style="width:100%;height:400px;"></div>
#> </div>

# Complete demo:

if (interactive()) {

library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h2("Exemple spinners"),
  actionButton(inputId = "refresh", label = "Refresh", width = "100%"),
  fluidRow(
    column(
      width = 5, offset = 1,
      addSpinner(plotOutput("plot1"), spin = "circle", color = "#E41A1C"),
      addSpinner(plotOutput("plot3"), spin = "bounce", color = "#377EB8"),
      addSpinner(plotOutput("plot5"), spin = "folding-cube", color = "#4DAF4A"),
      addSpinner(plotOutput("plot7"), spin = "rotating-plane", color = "#984EA3"),
      addSpinner(plotOutput("plot9"), spin = "cube-grid", color = "#FF7F00")
    ),
    column(
      width = 5,
      addSpinner(plotOutput("plot2"), spin = "fading-circle", color = "#FFFF33"),
      addSpinner(plotOutput("plot4"), spin = "double-bounce", color = "#A65628"),
      addSpinner(plotOutput("plot6"), spin = "dots", color = "#F781BF"),
      addSpinner(plotOutput("plot8"), spin = "cube", color = "#999999")
    )
  ),
  actionButton(inputId = "refresh2", label = "Refresh", width = "100%")
)

server <- function(input, output, session) {

  dat <- reactive({
    input$refresh
    input$refresh2
    Sys.sleep(3)
    Sys.time()
  })

  lapply(
    X = seq_len(9),
    FUN = function(i) {
      output[[paste0("plot", i)]] <- renderPlot({
        dat()
        plot(sin, -pi, i*pi)
      })
    }
  )

}

shinyApp(ui, server)

}
```
