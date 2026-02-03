# Progress bar in a sweet alert

Progress bar in a sweet alert

## Usage

``` r
progressSweetAlert(
  session = getDefaultReactiveDomain(),
  id,
  value,
  total = NULL,
  display_pct = FALSE,
  size = NULL,
  status = NULL,
  striped = FALSE,
  title = NULL,
  ...
)
```

## Arguments

- session:

  The `session` object passed to function given to shinyServer.

- id:

  An id used to update the progress bar.

- value:

  Value of the progress bar between 0 and 100, if \>100 you must provide
  total.

- total:

  Used to calculate percentage if value \> 100, force an indicator to
  appear on top right of the progress bar.

- display_pct:

  logical, display percentage on the progress bar.

- size:

  Size, `NULL` by default or a value in 'xxs', 'xs', 'sm', only work
  with package `shinydashboard`.

- status:

  Color, must be a valid Bootstrap status : primary, info, success,
  warning, danger.

- striped:

  logical, add a striped effect.

- title:

  character, optional title.

- ...:

  Arguments passed to
  [`sendSweetAlert()`](https://dreamrs.github.io/shinyWidgets/reference/sweetalert.md)

## See also

[`progressBar()`](https://dreamrs.github.io/shinyWidgets/reference/progress-bar.md)

## Examples

``` r
if (interactive()) {

library("shiny")
library("shinyWidgets")


ui <- fluidPage(
  tags$h1("Progress bar in Sweet Alert"),
  useSweetAlert(), # /!\ needed with 'progressSweetAlert'
  actionButton(
    inputId = "go",
    label = "Launch long calculation !"
  )
)

server <- function(input, output, session) {

  observeEvent(input$go, {
    progressSweetAlert(
      session = session, id = "myprogress",
      title = "Work in progress",
      display_pct = TRUE, value = 0
    )
    for (i in seq_len(50)) {
      Sys.sleep(0.1)
      updateProgressBar(
        session = session,
        id = "myprogress",
        value = i*2
      )
    }
    closeSweetAlert(session = session)
    sendSweetAlert(
      session = session,
      title =" Calculation completed !",
      type = "success"
    )
  })

}

shinyApp(ui = ui, server = server)

}
```
