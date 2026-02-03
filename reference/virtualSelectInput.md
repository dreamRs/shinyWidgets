# Virtual Select Input

A select dropdown widget made for performance, based on
[virtual-select](https://github.com/sa-si-dev/virtual-select) JavaScript
library.

## Usage

``` r
virtualSelectInput(
  inputId,
  label,
  choices,
  selected = NULL,
  multiple = FALSE,
  search = FALSE,
  hideClearButton = !multiple,
  autoSelectFirstOption = !multiple,
  showSelectedOptionsFirst = FALSE,
  showValueAsTags = FALSE,
  optionsCount = 10,
  noOfDisplayValues = 50,
  allowNewOption = FALSE,
  disableSelectAll = !multiple,
  disableOptionGroupCheckbox = !multiple,
  disabled = FALSE,
  ...,
  stateInput = TRUE,
  updateOn = c("change", "close"),
  html = FALSE,
  inline = FALSE,
  width = NULL
)
```

## Arguments

- inputId:

  The `input` slot that will be used to access the value.

- label:

  Display label for the control, or `NULL` for no label.

- choices:

  List of values to select from. You can use:

  - `vector` use a simple vector for better performance.

  - `named list` / `named vector` in the same way as with
    [`shiny::selectInput()`](https://rdrr.io/pkg/shiny/man/selectInput.html)

  - custom formatted `list` allowing to use more options, must
    correspond to [virtual-select
    specifications](https://sa-si-dev.github.io/virtual-select/#/properties)

  - output of
    [`prepare_choices()`](https://dreamrs.github.io/shinyWidgets/reference/prepare_choices.md)

- selected:

  The initially selected value (or multiple values if
  `multiple = TRUE`). If not specified then defaults to the first value
  for single-select lists and no values for multiple select lists.

- multiple:

  Is selection of multiple items allowed?

- search:

  Enable search feature.

- hideClearButton:

  Hide clear value button.

- autoSelectFirstOption:

  Select first option by default on load.

- showSelectedOptionsFirst:

  Show selected options at the top of the dropbox.

- showValueAsTags:

  Show each selected values as tags with remove icon.

- optionsCount:

  No.of options to show on viewport.

- noOfDisplayValues:

  Maximum no.of values to show in the tooltip for multi-select.

- allowNewOption:

  Allow to add new option by searching.

- disableSelectAll:

  Disable select all feature of multiple select.

- disableOptionGroupCheckbox:

  Disable option group title checkbox.

- disabled:

  Disable entire dropdown.

- ...:

  Other arguments passed to JavaScript method, see [virtual-select
  documentation](https://sa-si-dev.github.io/virtual-select/#/properties)
  for a full list of options.

- stateInput:

  Activate or deactivate the special input value `input$<inputId>_open`
  to know if the menu is opened or not, see details.

- updateOn:

  When to update the input value server-side : on each changes or when
  the menu is closed.

- html:

  Allow usage of HTML in choices.

- inline:

  Display inline with label or not.

- width:

  The width of the input, e.g. `'400px'`, or `'100%'`; see
  [`validateCssUnit()`](https://rstudio.github.io/htmltools/reference/validateCssUnit.html).

## Value

A `shiny.tag` object that can be used in a UI definition.

## Note

State of the menu (open or close) is accessible server-side through the
input value: `input$<inputId>_open`, which can be `TRUE` (opened) or
`FALSE` (closed) or `NULL` (when initialized).

For arguments that accept a function (`onServerSearch`,
`labelRenderer`), only a string with a function name is accepted. The
function must be defined outside of any `$(document).ready({...})`
javascript block. For examples, see the documentation for
[onServerSearch](https://sa-si-dev.github.io/virtual-select/#/examples?id=server-search)
and
[labelRenderer](https://sa-si-dev.github.io/virtual-select/#/examples?id=add-imageicon).

## See also

- [`demoVirtualSelect()`](https://dreamrs.github.io/shinyWidgets/reference/demoVirtualSelect.md)
  for demo apps

- [`updateVirtualSelect()`](https://dreamrs.github.io/shinyWidgets/reference/updateVirtualSelect.md)
  for updating from server

## Examples

``` r
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h2("Virtual Select"),

  fluidRow(
    column(
      width = 4,
      virtualSelectInput(
        inputId = "single",
        label = "Single select :",
        choices = month.name,
        search = TRUE
      ),
      virtualSelectInput(
        inputId = "multiple",
        label = "Multiple select:",
        choices = setNames(month.abb, month.name),
        multiple = TRUE
      ),
      virtualSelectInput(
        inputId = "onclose",
        label = "Update value on close:",
        choices = setNames(month.abb, month.name),
        multiple = TRUE,
        updateOn = "close"
      )
    ),
    column(
      width = 4,
      tags$b("Single select :"),
      verbatimTextOutput("res_single"),
      tags$b("Is virtual select open ?"),
      verbatimTextOutput(outputId = "res_single_open"),

      tags$br(),

      tags$b("Multiple select :"),
      verbatimTextOutput("res_multiple"),
      tags$b("Is virtual select open ?"),
      verbatimTextOutput(outputId = "res_multiple_open"),

      tags$br(),

      tags$b("Update on close :"),
      verbatimTextOutput("res_onclose"),
      tags$b("Is virtual select open ?"),
      verbatimTextOutput(outputId = "res_onclose_open")
    )
  )


)

server <- function(input, output, session) {

  output$res_single <- renderPrint(input$single)
  output$res_single_open <- renderPrint(input$single_open)

  output$res_multiple <- renderPrint(input$multiple)
  output$res_multiple_open <- renderPrint(input$multiple_open)

  output$res_onclose <- renderPrint(input$onclose)
  output$res_onclose_open <- renderPrint(input$onclose_open)

}

if (interactive())
  shinyApp(ui, server)
# labelRenderer example ----

library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$head(
    tags$script(HTML("
      function colorText(data) {
        let text = `<span style='color: ${data.label};'>${data.label}</span>`;
        return text;
      }"
    )),
  ),
  tags$h1("Custom LabelRenderer"),
  br(),
  fluidRow(
    column(
      width = 6,
      virtualSelectInput(
        inputId = "search",
        label = "Color picker",
        choices = c("red", "blue", "green", "#cbf752"),
        width = "100%",
        keepAlwaysOpen = TRUE,
        labelRenderer = "colorText",
        allowNewOption = TRUE
      )
    )
  )

)

server <- function(input, output, session) {}

if (interactive())
  shinyApp(ui, server)

# onServerSearch example ----

library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$head(
    tags$script(HTML(r"(
      // Main function that is called
      function searchLabel(searchValue, virtualSelect) {
        // Words to search for - split by a space
        const searchWords = searchValue.split(/[\s]/);

        // Update visibility
        const found = virtualSelect.options.map(opt => {
          opt.isVisible = searchWords.every(word => opt.label.includes(word));
          return opt;
        });

        virtualSelect.setServerOptions(found);
        }
      )"
    )),
  ),
  tags$h1("Custom onServerSearch"),
  br(),
  fluidRow(
    column(
      width = 6,
      virtualSelectInput(
        inputId = "search",
        label = "Better search",
        choices = c("This is some random long text",
                    "This text is long and looks differently",
                    "Writing this text is a pure love",
                    "I love writing!"
        ),
        width = "100%",
        keepAlwaysOpen = TRUE,
        search = TRUE,
        autoSelectFirstOption = FALSE,
        onServerSearch = "searchLabel"
      )
    )
  )

)

server <- function(input, output, session) {}

if (interactive())
  shinyApp(ui, server)
```
