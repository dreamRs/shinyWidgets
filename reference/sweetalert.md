# Display a Sweet Alert to the user

Show an alert message to the user to provide some feedback.

## Usage

``` r
sendSweetAlert(
  session = getDefaultReactiveDomain(),
  title = "Title",
  text = NULL,
  type = NULL,
  btn_labels = "Ok",
  btn_colors = "#3085d6",
  html = FALSE,
  closeOnClickOutside = TRUE,
  showCloseButton = FALSE,
  width = NULL,
  ...
)

show_alert(
  title = "Title",
  text = NULL,
  type = NULL,
  btn_labels = "Ok",
  btn_colors = "#3085d6",
  html = FALSE,
  closeOnClickOutside = TRUE,
  showCloseButton = FALSE,
  width = NULL,
  ...,
  session = shiny::getDefaultReactiveDomain()
)
```

## Arguments

- session:

  The `session` object passed to function given to shinyServer.

- title:

  Title of the alert.

- text:

  Text of the alert.

- type:

  Type of the alert : info, success, warning or error.

- btn_labels:

  Label(s) for button(s), can be of length 2, in which case the alert
  will have two buttons. Use `NA` for no buttons.s

- btn_colors:

  Color(s) for the buttons.

- html:

  Does `text` contains HTML tags ?

- closeOnClickOutside:

  Decide whether the user should be able to dismiss the modal by
  clicking outside of it, or not.

- showCloseButton:

  Show close button in top right corner of the modal.

- width:

  Width of the modal (in pixel).

- ...:

  Other arguments passed to JavaScript method.

## Note

This function use the JavaScript sweetalert2 library, see the official
documentation for more <https://sweetalert2.github.io/>.

## See also

[`confirmSweetAlert()`](https://dreamrs.github.io/shinyWidgets/reference/sweetalert-confirmation.md),
[`inputSweetAlert()`](https://dreamrs.github.io/shinyWidgets/reference/inputSweetAlert.md),
[`closeSweetAlert()`](https://dreamrs.github.io/shinyWidgets/reference/closeSweetAlert.md).

## Examples

``` r
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h2("Sweet Alert examples"),
  actionButton(
    inputId = "success",
    label = "Launch a success sweet alert",
    icon = icon("check")
  ),
  actionButton(
    inputId = "error",
    label = "Launch an error sweet alert",
    icon = icon("xmark")
  ),
  actionButton(
    inputId = "sw_html",
    label = "Sweet alert with HTML",
    icon = icon("thumbs-up")
  )
)

server <- function(input, output, session) {

  observeEvent(input$success, {
    show_alert(
      title = "Success !!",
      text = "All in order",
      type = "success"
    )
  })

  observeEvent(input$error, {
    show_alert(
      title = "Error !!",
      text = "It's broken...",
      type = "error"
    )
  })

  observeEvent(input$sw_html, {
    show_alert(
      title = NULL,
      text = tags$span(
        tags$h3("With HTML tags",
                style = "color: steelblue;"),
        "In", tags$b("bold"), "and", tags$em("italic"),
        tags$br(),
        "and",
        tags$br(),
        "line",
        tags$br(),
        "breaks",
        tags$br(),
        "and an icon", icon("thumbs-up")
      ),
      html = TRUE
    )
  })

}

if (interactive())
  shinyApp(ui, server)

# Ouptut in alert ----

library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h1("Click the button to open the alert"),
  actionButton(
    inputId = "sw_html",
    label = "Sweet alert with plot"
  )
)

server <- function(input, output, session) {

  observeEvent(input$sw_html, {
    show_alert(
      title = "Yay a plot!",
      text = tags$div(
        plotOutput(outputId = "plot"),
        sliderInput(
          inputId = "clusters",
          label = "Number of clusters",
          min = 2, max = 6, value = 3, width = "100%"
        )
      ),
      html = TRUE,
      width = "80%"
    )
  })

  output$plot <- renderPlot({
    plot(Sepal.Width ~ Sepal.Length,
         data = iris, col = Species,
         pch = 20, cex = 2)
    points(kmeans(iris[, 1:2], input$clusters)$centers,
           pch = 4, cex = 4, lwd = 4)
  })
}


if (interactive())
  shinyApp(ui, server)
```
