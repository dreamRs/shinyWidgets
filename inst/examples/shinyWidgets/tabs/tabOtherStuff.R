
.shinyWidgetGalleryFuns$tabOtherStuff <- function() {
  code_dropdownButton <- readLines(con = "code_dropdownButton.R")
  code_dropdownButton <- paste(code_dropdownButton, collapse = "\n")
  code_dropdown <- readLines(con = "code_dropdown.R")
  code_dropdown <- paste(code_dropdown, collapse = "\n")
  code_sa <- readLines(con = "code_sa.R")
  code_sa <- paste(code_sa, collapse = "\n")
  tagList(
    tags$h1("Other widgets", class = "fw-bold text-primary"),

    fluidRow(
      column(
        width = 8,

        bslib::card(
          bslib::card_header("Dropdown Button", class = "bg-primary text-light"),
          bslib::card_body(
            dropdownButton(
              tags$h3("List of Inputs"),
              selectInput(inputId = "xcol", label = "X Variable", choices = names(iris)),
              selectInput(inputId = "ycol", label = "Y Variable", choices = names(iris), selected = names(iris)[[2]]),
              sliderInput(inputId = "clusters", label = "Cluster count", value = 3, min = 1, max = 9),
              circle = TRUE, status = "danger", icon = icon("gear"), width = "300px",
              tooltip = tooltipOptions(title = "Click to see inputs !")
            ),
            plotOutput(outputId = "plot1"),
            tags$p("if you want to hide inputs to focus on a plot.."),
            tags$a(
              icon("code"),
              "Show code",
              `data-bs-toggle` = "collapse",
              href = "#showcode_dropdownButton"
            ),
            tags$div(
              class = "collapse",
              id = "showcode_dropdownButton",
              .shinyWidgetGalleryFuns$rCodeContainer(
                id="code_dropdownButton",
                code_dropdownButton
              )
            )
          )
        ),

        bslib::card(
          bslib::card_header("Dropdown (bis)", class = "bg-primary text-light"),
          bslib::card_body(
            dropdown(
              tags$h3("List of Input"),
              pickerInput(inputId = "xcol2", label = "X Variable", choices = names(iris), options = list(`style` = "btn-info")),
              pickerInput(inputId = "ycol2", label = "Y Variable", choices = names(iris), selected = names(iris)[[2]], options = list(`style` = "btn-warning")),
              sliderInput(inputId = "clusters2", label = "Cluster count", value = 3, min = 1, max = 9),
              style = "unite", icon = icon("gear"), status = "danger", width = "300px",
              animate = animateOptions(
                enter = animations$fading_entrances$fadeInLeftBig,
                exit = animations$fading_exits$fadeOutRightBig
              )
            ),
            plotOutput(outputId = "plot2"),
            tags$p("In this version you can add animations and pickerInput will work in it."),
            tags$a(
              icon("code"),
              "Show code",
              `data-bs-toggle` = "collapse",
              href = "#showcode_dropdown"
            ),
            tags$div(
              class = "collapse",
              id = "showcode_dropdown",
              .shinyWidgetGalleryFuns$rCodeContainer(
                id="code_dropdown",
                code_dropdown
              )
            )
          )
        )
      ),

      column(
        width = 4,
        bslib::card(
          bslib::card_header("Sweet Alert", class = "bg-primary text-light"),
          tags$span(
            "via ",
            tags$a(href = "https://github.com/sweetalert2/sweetalert2", "sweetalert2")
          ), br(), br(),
          fluidRow(
            column(
              width = 6,
              actionButton(inputId = "success", label = "Success !", width = "100%", class = "btn-success"),
              br(), br(),
              actionButton(inputId = "info", label = "Info", width = "100%", class = "btn-info")
              # receiveSweetAlert(messageId = "infomessage")
            ),
            column(
              width = 6,
              actionButton(inputId = "error", label = "Error", width = "100%", class = "btn-danger"),
              br(), br(),
              actionButton(inputId = "warning", label = "Warning", width = "100%", class = "btn-warning")
            )
          ),
          br(),
          tags$a(
            icon("code"),
            "Show code",
            `data-bs-toggle` = "collapse",
            href = "#showcodeSA"
          ),
          tags$div(
            class = "collapse",
            id = "showcodeSA",
            .shinyWidgetGalleryFuns$rCodeContainer(
              id = "codeSA",
              code_sa
            )
          )
        ),
        bslib::card(
          bslib::card_header("Confirmation dialog", class = "bg-primary text-light"),
          bslib::card_body(
            actionButton(inputId = "launch_confirmation", label = "Ask for confirmation"),
            tags$br(),
            verbatimTextOutput(outputId = "res_confirmation")
          )
        )
      )
    )
  )

}
