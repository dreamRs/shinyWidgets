# Load Sweet Alert dependencies

This function isn't necessary for `sendSweetAlert`, `confirmSweetAlert`,
`inputSweetAlert` (except if you want to use a theme other than the
default one), but is still needed for `progressSweetAlert`.

## Usage

``` r
useSweetAlert(
  theme = c("sweetalert2", "minimal", "dark", "bootstrap-4", "material-ui", "bulma",
    "borderless"),
  ie = FALSE
)
```

## Arguments

- theme:

  Theme to modify alerts appearance.

- ie:

  Add a polyfill to work in Internet Explorer.

## See also

[`sendSweetAlert()`](https://dreamrs.github.io/shinyWidgets/reference/sweetalert.md),
[`confirmSweetAlert()`](https://dreamrs.github.io/shinyWidgets/reference/sweetalert-confirmation.md),
[`inputSweetAlert()`](https://dreamrs.github.io/shinyWidgets/reference/inputSweetAlert.md),
[`closeSweetAlert()`](https://dreamrs.github.io/shinyWidgets/reference/closeSweetAlert.md).

## Examples

``` r
if (interactive()) {

  library(shiny)
  library(shinyWidgets)

  ui <- fluidPage(

    useSweetAlert("borderless", ie = TRUE),

    tags$h2("Sweet Alert examples (with custom theme)"),
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

  shinyApp(ui, server)
}
```
