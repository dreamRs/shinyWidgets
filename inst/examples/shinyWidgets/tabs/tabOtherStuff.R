
.shinyWidgetGalleryFuns$tabOtherStuff <- tagList(
  tags$h1("Other widgets", class = "fw-bold text-primary"),

  fluidRow(
    column(
      width = 8,

      box(
        title = "Dropdown Button", status = "danger", width = 12,
        dropdownButton(
          tags$h3("List of Inputs"),
          selectInput(inputId = 'xcol', label = 'X Variable', choices = names(iris)),
          selectInput(inputId = 'ycol', label = 'Y Variable', choices = names(iris), selected = names(iris)[[2]]),
          sliderInput(inputId = 'clusters', label = 'Cluster count', value = 3, min = 1, max = 9),
          circle = TRUE, status = "danger", icon = icon("gear"), width = "300px",
          tooltip = tooltipOptions(title = "Click to see inputs !")
        ),
        plotOutput(outputId = 'plot1'),
        tags$p("if you want to hide inputs to focus on a plot.."),
        tags$b(tags$a(icon("code"), "Show code", `data-toggle`="collapse", href="#showcode_dropdownButton")),
        tags$div(
          class="collapse", id="showcode_dropdownButton",
          .shinyWidgetGalleryFuns$rCodeContainer(
            id="code_dropdownButton",
            code_dropdownButton
          )
        )
      ),

      box(
        title = "Dropdown (bis)", status = "danger", width = 12,
        dropdown(
          tags$h3("List of Input"),
          pickerInput(inputId = 'xcol2', label = 'X Variable', choices = names(iris), options = list(`style` = "btn-info")),
          pickerInput(inputId = 'ycol2', label = 'Y Variable', choices = names(iris), selected = names(iris)[[2]], options = list(`style` = "btn-warning")),
          sliderInput(inputId = 'clusters2', label = 'Cluster count', value = 3, min = 1, max = 9),
          style = "unite", icon = icon("gear"), status = "danger", width = "300px",
          animate = animateOptions(enter = animations$fading_entrances$fadeInLeftBig, exit = animations$fading_exits$fadeOutRightBig)
        ),
        plotOutput(outputId = 'plot2'),
        tags$p("In this version you can add animations and pickerInput will work in it."),
        tags$b(tags$a(icon("code"), "Show code", `data-toggle`="collapse", href="#showcode_dropdown")),
        tags$div(
          class="collapse", id="showcode_dropdown",
          .shinyWidgetGalleryFuns$rCodeContainer(
            id="code_dropdown",
            code_dropdown
          )
        )
      )
    ),

    column(
      width = 4,
      box(
        title = "Sweet Alert", status = "danger", width = 12,
        tags$span(
          "via ",
          tags$a(href = "http://t4t5.github.io/sweetalert/", "sweetalert"),
          style="color: #d9534f;"
        ), br(), br(),
        # useSweetAlert(),
        fluidRow(
          column(
            width = 6,
            actionButton(inputId = "success", label = "Success !", width = "100%", class = "btn-success", style = "color: #FFF"),
            # receiveSweetAlert(messageId = "successmessage"),
            # br(), br(),
            # actionButton(inputId = "tags", label = "With HTML tags", width = "100%"),
            # receiveSweetAlert(messageId = "tagsmessage"),
            br(), br(),
            actionButton(inputId = "info", label = "Info", width = "100%", class = "btn-info", style = "color: #FFF")
            # receiveSweetAlert(messageId = "infomessage")
          ),
          column(
            width = 6,
            actionButton(inputId = "error", label = "Error", width = "100%", class = "btn-danger", style = "color: #FFF"),
            # receiveSweetAlert(messageId = "errormessage"),
            br(), br(),
            actionButton(inputId = "warning", label = "Warning", width = "100%", class = "btn-warning", style = "color: #FFF")
            # receiveSweetAlert(messageId = "warningmessage")
          )
        ),
        br(),
        tags$b(tags$a(icon("code"), "Show code", `data-toggle`="collapse", href="#showcodeSA")),
        tags$div(
          class="collapse", id="showcodeSA",
          .shinyWidgetGalleryFuns$rCodeContainer(
            id="codeSA",
            code_sa
          )
        )
      ),
      box(
        title = "Confirmation dialog", status = "danger", width = 12,
        actionButton(inputId = "launch_confirmation", label = "Ask for confirmation"),
        tags$br(),
        verbatimTextOutput(outputId = "res_confirmation")
      )
    )
  )
)
