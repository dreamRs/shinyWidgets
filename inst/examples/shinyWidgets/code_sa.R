
# ui : call this function once somewhere
useSweetAlert()


# server : launch a sweet alert anytime you want
# here they are launched when actionButtons are clicked
# but it can be after loading data, a successful (or not)
# long calculation, ...

observeEvent(input$success, {
  sendSweetAlert(
    session = session,
    title = "Success !!",
    text = "All in order",
    type = "success"
  )
})

observeEvent(input$error, {
  sendSweetAlert(
    session = session,
    title = "Error...",
    text = "Oups !",
    type = "error"
  )
})

observeEvent(input$info, {
  sendSweetAlert(
    session = session,
    title = "Information",
    text = "Something helpful",
    type = "info"
  )
})

observeEvent(input$tags, {
  sendSweetAlert(
    session = session,
    title = "HTLM tags",
    text = "normal <b>bold</b> <span style='color: steelblue;'>color</span> <h1>h1</h1>",
    html = TRUE,
    type = NULL
  )
})

observeEvent(input$warning, {
  sendSweetAlert(
    session = session,
    title = "Warning !!!",
    text = NULL,
    type = "warning"
  )
})



