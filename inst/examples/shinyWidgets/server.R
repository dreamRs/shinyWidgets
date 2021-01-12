
#  ------------------------------------------------------------------------
#
# Title : shinyWidgets Gallery - server
#    By : Victor
#  Date : 2020-12-01
#
#  ------------------------------------------------------------------------



function(input, output, session) {

  # cleanup app
  session$onSessionEnded(function() {
    suppressWarnings(
      rm(.shinyWidgetGalleryFuns, .shinyWidgetGalleryId, envir = globalenv())
    )
    shiny::stopApp()
  })

  # highlight code dropdowns & sweetalert
  .shinyWidgetGalleryFuns$highlightCode(session, "code_dropdownButton")

  .shinyWidgetGalleryFuns$highlightCode(session, "code_dropdown")

  .shinyWidgetGalleryFuns$highlightCode(session, "codeSA")

  # navigation ----

  observeEvent(input$toSwictchInput, {
    updateTabItems(session = session, inputId = "tabs", selected = "tabswitchInput")
  })

  observeEvent(input$toAwesome1, {
    updateTabItems(session = session, inputId = "tabs", selected = "tabAwesome")
  })
  observeEvent(input$toAwesome2, {
    updateTabItems(session = session, inputId = "tabs", selected = "tabAwesome")
  })
  observeEvent(input$toAwesome3, {
    updateTabItems(session = session, inputId = "tabs", selected = "tabAwesome")
  })

  observeEvent(input$tocheckButtons, {
    updateTabItems(session = session, inputId = "tabs", selected = "tabcheckButtons")
  })

  observeEvent(input$toMaterialSwitch, {
    updateTabItems(session = session, inputId = "tabs", selected = "tabMaterialSwitch")
  })

  observeEvent(input$toSelectPicker, {
    updateTabItems(session = session, inputId = "tabs", selected = "tabPickerInput")
  })



  # input values ----
  lapply(
    X = seq_len(.shinyWidgetGalleryId),
    FUN = function(i) {
      ii <- paste0("Id", sprintf("%03d", i))
      .shinyWidgetGalleryFuns$highlightCode(session, paste0("code", ii))
      output[[paste0("res", ii)]] <- renderPrint({
        input[[ii]]
      })
    }
  )


  # Update switchInput
  output$resswitchUp <- renderPrint({
    input$switchUp
  })
  observeEvent(input$on, {
    updateSwitchInput(session = session, inputId = "switchUp", value = TRUE)
  })
  observeEvent(input$off, {
    updateSwitchInput(session = session, inputId = "switchUp", value = FALSE)
  })


  # Update awesomeRadios
  output$resupAwesomeRadio <- renderPrint({
    input$upAwesomeRadio
  })
  observeEvent(input$upAwesomeRadioA, {
    updateAwesomeRadio(session = session, inputId = "upAwesomeRadio", selected = "A")
  })
  observeEvent(input$upAwesomeRadioB, {
    updateAwesomeRadio(session = session, inputId = "upAwesomeRadio", selected = "B")
  })
  observeEvent(input$upAwesomeRadioC, {
    updateAwesomeRadio(session = session, inputId = "upAwesomeRadio", selected = "C")
  })

  # Update awesomeRadios
  output$resupAwesomeCheckbox <- renderPrint({
    input$upAwesomeCheckbox
  })
  observeEvent(input$upAwesomeCheckbox1, {
    updateAwesomeCheckboxGroup(session = session, inputId = "upAwesomeCheckbox", choices = c("a", "b", "c"), inline = TRUE, status = "success")
  })
  observeEvent(input$upAwesomeCheckbox2, {
    updateAwesomeCheckboxGroup(session = session, inputId = "upAwesomeCheckbox", choices = c("A", "B", "C"), inline = TRUE, status = "warning")
  })


  # update checkboxGroupButtons ----
  output$resupcheckboxGroupButtons <- renderPrint({
    input$upcheckboxGroupButtons
  })
  observeEvent(input$upCheckBtnA, {
    updateCheckboxGroupButtons(session = session, inputId = "upcheckboxGroupButtons", selected = "A")
  })
  observeEvent(input$upCheckBtnB, {
    updateCheckboxGroupButtons(session = session, inputId = "upcheckboxGroupButtons", selected = "B")
  })
  observeEvent(input$upCheckBtnC, {
    updateCheckboxGroupButtons(session = session, inputId = "upcheckboxGroupButtons", selected = "C")
  })
  observeEvent(input$upCheckBtnD, {
    updateCheckboxGroupButtons(session = session, inputId = "upcheckboxGroupButtons", selected = "D")
  })


  # Update radioGroupButtons ----
  output$resupradioGroupButtons <- renderPrint({
    input$upradioGroupButtons
  })
  observeEvent(input$upRadioBtnA, {
    updateRadioGroupButtons(session = session, inputId = "upradioGroupButtons", selected = "A")
  })
  observeEvent(input$upRadioBtnB, {
    updateRadioGroupButtons(session = session, inputId = "upradioGroupButtons", selected = "B")
  })
  observeEvent(input$upRadioBtnC, {
    updateRadioGroupButtons(session = session, inputId = "upradioGroupButtons", selected = "C")
  })
  observeEvent(input$upRadioBtnD, {
    updateRadioGroupButtons(session = session, inputId = "upradioGroupButtons", selected = "D")
  })





  # Update materialSwitch ----
  output$resupMaterial <- renderPrint({
    input$upMaterial
  })
  observeEvent(input$upMaterialY, {
    updateMaterialSwitch(session = session, inputId = "upMaterial", value = TRUE)
  })
  observeEvent(input$upMaterialN, {
    updateMaterialSwitch(session = session, inputId = "upMaterial", value = FALSE)
  })






  # Update PickerInput ----
  output$resuppickerIcons <- renderPrint({
    input$uppickerIcons
  })
  observeEvent(input$uppickerIconsRadio, {
    if (input$uppickerIconsRadio == "Glyphicon") {
      updatePickerInput(
        session = session, inputId = "uppickerIcons", selected = input$uppickerIcons,
        choices = c("glyphicon-arrow-right / fa-arrow-right", "glyphicon-cog / fa-cog", "glyphicon-play / fa-play",
                    "glyphicon-ok-sign / fa-check", "glyphicon-euro / fa-eur", "glyphicon-music / fa-music"),
        choicesOpt = list(
          icon = c("glyphicon glyphicon-arrow-right", "glyphicon glyphicon-cog", "glyphicon glyphicon-play",
                   "glyphicon glyphicon-ok-sign", "glyphicon glyphicon-euro", "glyphicon glyphicon-music")
        )
      )
    } else {
      updatePickerInput(
        session = session, inputId = "uppickerIcons", selected = input$uppickerIcons,
        choices = c("glyphicon-arrow-right / fa-arrow-right", "glyphicon-cog / fa-cog", "glyphicon-play / fa-play",
                    "glyphicon-ok-sign / fa-check", "glyphicon-euro / fa-eur", "glyphicon-music / fa-music"),
        choicesOpt = list(
          icon = c("fa fa-arrow-right", "fa fa-cog", "fa fa-play",
                   "fa fa-check", "fa fa-eur", "fa fa-music")
        )
      )
    }
  })



  # Update sliderText ----

  output$resselectedSliderText <- renderPrint({
    input$selectedSliderText
  })
  observeEvent(input$upSelectedSliderText, {
    updateSliderTextInput(
      session = session,
      inputId = "selectedSliderText",
      selected = input$upSelectedSliderText
    )
  }, ignoreInit = TRUE)

  output$reschoicesSliderText <- renderPrint({
    input$choicesSliderText
  })
  observeEvent(input$upChoicesSliderText, {
    choices <- switch(
      input$upChoicesSliderText,
      "Abbreviations" = month.abb,
      "Full names" = month.name
    )
    updateSliderTextInput(
      session = session,
      inputId = "choicesSliderText",
      choices = choices
    )
  }, ignoreInit = TRUE)




  # dropdown : iris clustering example ----
  selectedData <- reactive({
    iris[, c(input$xcol, input$ycol)]
  })

  clusters <- reactive({
    kmeans(selectedData(), input$clusters)
  })

  output$plot1 <- renderPlot({
    palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
              "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

    par(mar = c(5.1, 4.1, 0, 1))
    plot(selectedData(),
         col = clusters()$cluster,
         pch = 20, cex = 3)
    points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
  })


  # dropdown 2 : iris clustering example ----
  selectedData2 <- reactive({
    iris[, c(input$xcol2, input$ycol2)]
  })

  clusters2 <- reactive({
    kmeans(selectedData2(), input$clusters2)
  })

  output$plot2 <- renderPlot({
    palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
              "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

    par(mar = c(5.1, 4.1, 0, 1))
    plot(selectedData2(),
         col = clusters2()$cluster,
         pch = 20, cex = 3)
    points(clusters2()$centers, pch = 4, cex = 4, lwd = 4)
  })



  # sweetalert ----
  observeEvent(input$success, {
    sendSweetAlert(
      session = session, title = "Success !!", text = "All in order", type = "success"
    )
  })

  observeEvent(input$error, {
    sendSweetAlert(
      session = session, title = "Error...", text = "Oups !", type = "error"
    )
  })

  observeEvent(input$info, {
    sendSweetAlert(
      session = session, title = "Information", text = "Something helpful", type = "info"
    )
  })

  # observeEvent(input$tags, {
  #   sendSweetAlert(
  #     session = session, title = "HTLM tags",
  #     text = "normal <b>bold</b> <span style='color: steelblue;'>color</span> <h1>h1</h1>", html = TRUE, type = NULL
  #   )
  # })

  observeEvent(input$warning, {
    sendSweetAlert(
      session = session, title = "Warning !!!",
      text = NULL, type = "warning"
    )
  })


  observeEvent(input$launch_confirmation, {
    confirmSweetAlert(
      session = session, inputId = "myconfirmation", type = "warning",
      title = "Want to confirm ?", danger_mode = TRUE
    )
  })
  output$res_confirmation <- renderPrint(input$myconfirmation)

  # Progress Bars ----

  lapply(
    X = paste0("pb", 1:10),
    FUN = function(i) {
      .shinyWidgetGalleryFuns$highlightCode(session, paste0("code", i))
    }
  )

  observeEvent(input$uppb1, {
    updateProgressBar(session = session, id = "pb1", value = input$uppb1)
  })

  observeEvent(input$uppb2, {
    updateProgressBar(session = session, id = "pb2", value = input$uppb2)
  })

  observeEvent(input$uppb3, {
    updateProgressBar(session = session, id = "pb3", value = input$uppb3)
  })

  observeEvent(input$uppb4, {
    updateProgressBar(session = session, id = "pb4", value = input$uppb4)
  })

  observeEvent(input$uppb5, {
    updateProgressBar(session = session, id = "pb5", value = input$uppb5, total = 5000)
  })

  observeEvent(input$uppb6, {
    updateProgressBar(session = session, id = "pb6", value = input$uppb6)
  })

  observeEvent(input$uppb7, {
    if (input$uppb7 < 33) {
      status <- "danger"
    } else if (input$uppb7 >= 33 & input$uppb7 < 67) {
      status <- "warning"
    } else {
      status <- "success"
    }
    updateProgressBar(session = session, id = "pb7", value = input$uppb7, status = status)
  })

  observeEvent(input$uppb8, {
    updateProgressBar(session = session, id = "pb8", value = input$uppb8, total = 5000)
  })

  observeEvent(input$uppb9, {
    updateProgressBar(session = session, id = "pb9", value = 1000, total = input$uppb9)
  })


}

