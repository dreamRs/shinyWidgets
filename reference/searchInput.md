# Search Input

A text input only triggered when Enter key is pressed or search button
clicked

## Usage

``` r
searchInput(
  inputId,
  label = NULL,
  value = "",
  placeholder = NULL,
  btnSearch = NULL,
  btnReset = NULL,
  btnClass = "btn-default btn-outline-secondary",
  resetValue = "",
  inputType = "text",
  width = NULL
)
```

## Arguments

- inputId:

  The input slot that will be used to access the value.

- label:

  Display label for the control, or NULL for no label.

- value:

  Initial value.

- placeholder:

  A character string giving the user a hint as to what can be entered
  into the control.

- btnSearch:

  An icon for the button which validate the search.

- btnReset:

  An icon for the button which reset the search.

- btnClass:

  Class to add to buttons, if a vector of length 2 the first value is
  used for search button and second one for reset button.

- resetValue:

  Value used when reset button is clicked, default to `""` (empty
  string), if `NULL` value is not reset.

- inputType:

  The type of input to use, default is `"text"` but you can also use
  `"password"` for example, see
  [developer.mozilla.org](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/text)
  for other possible types.

- width:

  The width of the input, e.g. `400px`, or `100%`.

## Note

The two buttons ('search' and 'reset') act like
[`shiny::actionButton()`](https://rdrr.io/pkg/shiny/man/actionButton.html),
you can retrieve their value server-side with `input$<INPUTID>_search`
and `input$<INPUTID>_reset`.

## See also

[`updateSearchInput()`](https://dreamrs.github.io/shinyWidgets/reference/updateSearchInput.md)
to update value server-side.

## Examples

``` r
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  # theme = bslib::bs_theme(version = 5L, preset = "bootstrap"),
  tags$h1("Search Input"),
  br(),
  searchInput(
    inputId = "search", label = "Enter your text",
    placeholder = "A placeholder",
    btnSearch = icon("magnifying-glass"),
    btnReset = icon("xmark"),
    width = "450px"
  ),
  br(),
  verbatimTextOutput(outputId = "res")
)

server <- function(input, output, session) {
  output$res <- renderPrint(input$search)
}

if (interactive())
  shinyApp(ui = ui, server = server)
```
