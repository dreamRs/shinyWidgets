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
