# Launch a confirmation dialog

Launch a popup to ask the user for confirmation.

## Usage

``` r
confirmSweetAlert(
  session = getDefaultReactiveDomain(),
  inputId,
  title = NULL,
  text = NULL,
  type = "question",
  btn_labels = c("Cancel", "Confirm"),
  btn_colors = NULL,
  closeOnClickOutside = FALSE,
  showCloseButton = FALSE,
  allowEscapeKey = FALSE,
  cancelOnDismiss = TRUE,
  html = FALSE,
  ...
)

ask_confirmation(
  inputId,
  title = NULL,
  text = NULL,
  type = "question",
  btn_labels = c("Cancel", "Confirm"),
  btn_colors = NULL,
  closeOnClickOutside = FALSE,
  showCloseButton = FALSE,
  allowEscapeKey = FALSE,
  cancelOnDismiss = TRUE,
  html = FALSE,
  ...,
  session = shiny::getDefaultReactiveDomain()
)
```

## Arguments

- session:

  The `session` object passed to function given to shinyServer.

- inputId:

  The `input` slot that will be used to access the value. If in a Shiny
  module, it use same logic than inputs : use namespace in UI, not in
  server.

- title:

  Title of the alert.

- text:

  Text of the alert, can contains HTML tags.

- type:

  Type of the alert : info, success, warning or error.

- btn_labels:

  Labels for buttons, cancel button (`FALSE`) first then confirm button
  (`TRUE`).

- btn_colors:

  Colors for buttons.

- closeOnClickOutside:

  Decide whether the user should be able to dismiss the modal by
  clicking outside of it, or not.

- showCloseButton:

  Show close button in top right corner of the modal.

- allowEscapeKey:

  If set to `FALSE`, the user can't dismiss the popup by pressing the
  `Esc` key.

- cancelOnDismiss:

  If `TRUE`, when dialog is dismissed (click outside, close button or
  Esc key) it will be equivalent to canceling (input value will be
  `FALSE`), if `FALSE` nothing happen (input value remain `NULL`).

- html:

  Does `text` contains HTML tags ?

- ...:

  Additional arguments (not used)

## See also

[`sendSweetAlert()`](https://dreamrs.github.io/shinyWidgets/reference/sweetalert.md),
[`inputSweetAlert()`](https://dreamrs.github.io/shinyWidgets/reference/inputSweetAlert.md),
[`closeSweetAlert()`](https://dreamrs.github.io/shinyWidgets/reference/closeSweetAlert.md).

## Examples

``` r
library(shiny)
library(shinyWidgets)


ui <- fluidPage(
  tags$h1("Ask the user for confirmation"),
  actionButton(
    inputId = "launch",
    label = "Ask for confirmation"
  ),
  verbatimTextOutput(outputId = "res"),
  uiOutput(outputId = "count")
)

server <- function(input, output, session) {

  # Launch sweet alert confirmation
  observeEvent(input$launch, {
    ask_confirmation(
      inputId = "myconfirmation",
      title = "Want to confirm ?"
    )
  })

  # raw output
  output$res <- renderPrint(input$myconfirmation)

  # count click
  true <- reactiveVal(0)
  false <- reactiveVal(0)
  observeEvent(input$myconfirmation, {
    if (isTRUE(input$myconfirmation)) {
      x <- true() + 1
      true(x)
    } else {
      x <- false() + 1
      false(x)
    }
  }, ignoreNULL = TRUE)

  output$count <- renderUI({
    tags$span(
      "Confirm:", tags$b(true()),
      tags$br(),
      "Cancel:", tags$b(false())
    )
  })
}

if (interactive())
  shinyApp(ui, server)

# ------------------------------------
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h1("Ask for confirmation"),
  actionButton(
    inputId = "launch1",
    label = "Launch confirmation dialog"
  ),
  verbatimTextOutput(outputId = "res1"),
  tags$br(),
  actionButton(
    inputId = "launch2",
    label = "Launch confirmation dialog (with normal mode)"
  ),
  verbatimTextOutput(outputId = "res2"),
  tags$br(),
  actionButton(
    inputId = "launch3",
    label = "Launch confirmation dialog (with HTML)"
  ),
  verbatimTextOutput(outputId = "res3")
)

server <- function(input, output, session) {

  observeEvent(input$launch1, {
    ask_confirmation(
      inputId = "myconfirmation1",
      type = "warning",
      title = "Want to confirm ?"
    )
  })
  output$res1 <- renderPrint(input$myconfirmation1)

  observeEvent(input$launch2, {
    ask_confirmation(
      inputId = "myconfirmation2",
      type = "warning",
      title = "Are you sure ??",
      btn_labels = c("Nope", "Yep"),
      btn_colors = c("#FE642E", "#04B404")
    )
  })
  output$res2 <- renderPrint(input$myconfirmation2)

  observeEvent(input$launch3, {
    ask_confirmation(
      inputId = "myconfirmation3",
      title = NULL,
      text = tags$b(
        icon("file"),
        "Do you really want to delete this file ?",
        style = "color: #FA5858;"
      ),
      btn_labels = c("Cancel", "Delete file"),
      btn_colors = c("#00BFFF", "#FE2E2E"),
      html = TRUE
    )
  })
  output$res3 <- renderPrint(input$myconfirmation3)

}

if (interactive())
  shinyApp(ui, server)
```
