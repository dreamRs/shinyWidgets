
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  tags$h2("Download bttn"),
  downloadBttn(
    outputId = "downloadData1",
    style = "unite",
    color = "primary"
  ),
  tags$br(), tags$br(),
  downloadBttn(
    outputId = "downloadData2",
    style = "simple",
    color = "primary",
    icon = icon("file-pdf")
  ),
  tags$br(), tags$br(),
  downloadBttn(
    outputId = "downloadData3",
    style = "bordered",
    color = "primary"
  ),
  tags$br(), tags$br(),
  downloadBttn(
    outputId = "downloadData4",
    style = "stretch",
    color = "danger"
  ),
  tags$br(), tags$br(),
  downloadBttn(
    outputId = "downloadData5",
    style = "jelly",
    color = "success"
  ),
  tags$br(), tags$br(),
  downloadBttn(
    outputId = "downloadData6",
    style = "simple",
    color = "primary"
  ),
  tags$br(), tags$br(),
  downloadBttn(
    outputId = "downloadData7",
    style = "fill",
    color = "danger"
  ),
  tags$br(), tags$br(),
  downloadBttn(
    outputId = "downloadData8",
    style = "material-flat",
    color = "success"
  ),
  tags$br(), tags$br(),
  downloadBttn(
    outputId = "downloadData9",
    style = "pill",
    color = "primary"
  ),
  tags$br(), tags$br(),
  downloadBttn(
    outputId = "downloadData10",
    style = "float",
    color = "primary"
  )
)

server <- function(input, output, session) {

  lapply(
    X = seq_len(10),
    FUN = function(i) {
      output[[paste0("downloadData", i)]] <- downloadHandler(
        filename = function() {
          paste('data-', Sys.Date(), '.csv', sep='')
        },
        content = function(con) {
          write.csv(mtcars, con)
        }
      )
    }
  )

}

if (interactive())
  shinyApp(ui, server)
