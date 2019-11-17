if (interactive()) {
  library(shiny)
  library(tablerDash)
  library(shinyWidgets)


  profileCard <- tablerProfileCard(
    width = 12,
    title = "Peter Richards",
    subtitle = "Big belly rude boy, million
        dollar hustler. Unemployed.",
    background = "https://preview.tabler.io/demo/photos/ilnur-kalimullin-218996-500.jpg",
    src = "https://preview.tabler.io/demo/faces/male/16.jpg",
    tablerSocialLinks(
      tablerSocialLink(
        name = "facebook",
        href = "https://www.facebook.com",
        icon = "facebook"
      ),
      tablerSocialLink(
        name = "twitter",
        href = "https://www.twitter.com",
        icon = "twitter"
      )
    )
  )


  plotCard <- tablerCard(
    title = "Plots",
    zoomable = TRUE,
    closable = TRUE,
    options = tagList(
      switchInput(
        inputId = "enable_distPlot",
        label = "Plot?",
        value = TRUE,
        onStatus = "success",
        offStatus = "danger"
      )
    ),
    plotOutput("distPlot"),
    status = "info",
    statusSide = "left",
    width = 12,
    footer = tagList(
      column(
        width = 12,
        align = "center",
        sliderInput(
          "obs",
          "Number of observations:",
          min = 0,
          max = 1000,
          value = 500
        )
      )
    )
  )


  # app
  shiny::shinyApp(
    ui = fluidPage(
      useTablerDash(),
      chooseSliderSkin("Nice"),

      h1("Import tablerDash elements inside shiny!", align = "center"),
      h5("Don't need any sidebar, navbar, ...", align = "center"),
      h5("Only focus on basic elements for a pure interface", align = "center"),

      fluidRow(
        column(
          width = 3,
          profileCard,
          tablerStatCard(
            value = 43,
            title = "Followers",
            trend = -10,
            width = 12
          ),
          tablerAvatarList(
            stacked = TRUE,
            tablerAvatar(
              name = "DG",
              size = "xxl"
            ),
            tablerAvatar(
              name = "DG",
              color = "orange"
            ),
            tablerAvatar(
              name = "DG",
              status = "warning"
            ),
            tablerAvatar(url = "https://image.flaticon.com/icons/svg/145/145852.svg")
          )
        ),
        column(
          width = 6,
          plotCard
        ),
        column(
          width = 3,
          tablerCard(
            width = 12,
            tablerTimeline(
              tablerTimelineItem(
                title = "Item 1",
                status = "green",
                date = "now"
              ),
              tablerTimelineItem(
                title = "Item 2",
                status = NULL,
                date = "yesterday",
                "Lorem ipsum dolor sit amet,
                  consectetur adipisicing elit."
              )
            )
          ),
          tablerInfoCard(
            value = "132 sales",
            status = "danger",
            icon = "dollar-sign",
            description = "12 waiting payments",
            width = 12
          ),
          numericInput(
            inputId = "totalStorage",
            label = "Enter storage capacity",
            value = 1000),
          uiOutput("info"),
          knobInput(
            inputId = "knob",
            width = "50%",
            label = "Progress value:",
            value = 10,
            min = 0,
            max = 100,
            skin = "tron",
            displayPrevious = TRUE,
            fgColor = "#428BCA",
            inputColor = "#428BCA"
          ),
          uiOutput("progress")
        )
      )
    ),
    server = function(input, output) {

      output$distPlot <- renderPlot({
        if (input$enable_distPlot) hist(rnorm(input$obs))
      })

      output$info <- renderUI({
        tablerInfoCard(
          width = 12,
          value = paste0(input$totalStorage, "GB"),
          status = "success",
          icon = "database",
          description = "Total Storage Capacity"
        )
      })


      output$progress <- renderUI({
        tagList(
          tablerProgress(value = input$knob, size = "xs", status = "yellow"),
          tablerProgress(value = input$knob, status = "red", size = "sm")
        )
      })

    }
  )
}
