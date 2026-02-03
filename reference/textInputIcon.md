# Create a text input control with icon(s)

Extend form controls by adding text or icons before, after, or on both
sides of a classic `textInput`.

## Usage

``` r
textInputIcon(
  inputId,
  label,
  value = "",
  placeholder = NULL,
  icon = NULL,
  size = NULL,
  inputType = "text",
  width = NULL
)
```

## Arguments

- inputId:

  The `input` slot that will be used to access the value.

- label:

  Display label for the control, or `NULL` for no label.

- value:

  Initial value.

- placeholder:

  A character string giving the user a hint as to what can be entered
  into the control. Internet Explorer 8 and 9 do not support this
  option.

- icon:

  An [`shiny::icon()`](https://rdrr.io/pkg/shiny/man/icon.html) (or
  equivalent) or a `list`, containing `icon`s or text, to be displayed
  on the right or left of the text input.

- size:

  Size of the input, default to `NULL`, can be `"sm"` (small) or `"lg"`
  (large).

- inputType:

  The type of input to use, default is `"text"` but you can also use
  `"password"` for example, see
  [developer.mozilla.org](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/text)
  for other possible types.

- width:

  The width of the input, e.g. `'400px'`, or `'100%'`; see
  [`validateCssUnit()`](https://rstudio.github.io/htmltools/reference/validateCssUnit.html).

## Value

A text input control that can be added to a UI definition.

## See also

See
[`updateTextInputIcon()`](https://dreamrs.github.io/shinyWidgets/reference/updateTextInputIcon.md)
to update server-side, and
[`numericInputIcon()`](https://dreamrs.github.io/shinyWidgets/reference/numericInputIcon.md)
for using numeric value.

## Examples

``` r
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  # Test with different version of Bootstrap
  theme = bslib::bs_theme(version = 5),

  tags$h2("textInputIcon examples"),
  fluidRow(
    column(
      width = 6,
      textInputIcon(
        inputId = "ex1",
        label = "With an icon",
        icon = icon("circle-user")
      ),
      verbatimTextOutput("res1"),
      textInputIcon(
        inputId = "ex2",
        label = "With an icon (right)",
        icon = list(NULL, icon("circle-user"))
      ),
      verbatimTextOutput("res2"),
      textInputIcon(
        inputId = "ex3",
        label = "With text",
        icon = list("https://")
      ),
      verbatimTextOutput("res3"),
      textInputIcon(
        inputId = "ex4",
        label = "Both side",
        icon = list(icon("envelope"), "@mail.com")
      ),
      verbatimTextOutput("res4"),
      textInputIcon(
        inputId = "ex5",
        label = "Sizing",
        icon = list(icon("envelope"), "@mail.com"),
        size = "lg"
      ),
      verbatimTextOutput("res5")
    )
  )
)

server <- function(input, output, session) {

  output$res1 <- renderPrint(input$ex1)
  output$res2 <- renderPrint(input$ex2)
  output$res3 <- renderPrint(input$ex3)
  output$res4 <- renderPrint(input$ex4)
  output$res5 <- renderPrint(input$ex5)

}

if (interactive())
  shinyApp(ui, server)
```
