
if (interactive()) {

  library(shiny)
  library(bs4Dash)
  library(shinyWidgets)

  ui <- fluidPage(
    h1("Import bs4Dash elements inside shiny!", align = "center"),
    h5("Don't need any sidebar, navbar, ...", align = "center"),
    h5("Only focus on basic elements for a pure interface", align = "center"),

    # use this in non dashboard app
    setBackgroundColor(color = "ghostwhite"),
    useBs4Dash(),

    # infoBoxes
    fluidRow(
      bs4InfoBox(
        title = "Messages",
        value = 1410,
        icon = icon("envelope")
      ),
      bs4InfoBox(
        title = "Bookmarks",
        color = "info",
        value = 240,
        icon = icon("bookmark")
      ),
      bs4InfoBox(
        title = "Comments",
        color = "danger",
        value = 41410,
        icon = icon("comments")
      )
    ),

    # valueBoxes
    fluidRow(
      bs4ValueBox(
        value = uiOutput("orderNum"),
        subtitle = "New Orders",
        icon = icon("credit-card"),
        href = "http://google.com"
      ),
      bs4ValueBox(
        value = "60%",
        subtitle = "Approval Rating",
        icon = icon("chart-line"),
        color = "success"
      ),
      bs4ValueBox(
        value = htmlOutput("progress"),
        subtitle = "Progress",
        icon = icon("users"),
        color = "danger"
      )
    ),

    # Boxes
    fluidRow(
      bs4Card(
        status = "primary",
        sliderInput("orders", "Orders", min = 1, max = 2000, value = 650),
        selectInput(
          "progress",
          "Progress",
          choices = c(
            "0%" = 0, "20%" = 20, "40%" = 40,
            "60%" = 60, "80%" = 80, "100%" = 100
          )
        )
      ),
      bs4Card(
        title = "Histogram box title",
        status = "warning",
        solidHeader = TRUE,
        collapsible = TRUE,
        plotOutput("plot", height = 250)
      )
    )
  )

  server <- function(input, output, session) {

    output$orderNum <- renderText({
      prettyNum(input$orders, big.mark=",")
    })

    output$orderNum2 <- renderText({
      prettyNum(input$orders, big.mark=",")
    })

    output$progress <- renderUI({
      tagList(input$progress, tags$sup(style="font-size: 20px", "%"))
    })

    output$progress2 <- renderUI({
      paste0(input$progress)
    })


    output$plot <- renderPlot({
      hist(rnorm(input$orders))
    })

  }

  shinyApp(ui, server)

}
