% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/input-radiogroupbuttons.R
\name{updateRadioGroupButtons}
\alias{updateRadioGroupButtons}
\title{Change the value of a radio group buttons input on the client}
\usage{
updateRadioGroupButtons(
  session = getDefaultReactiveDomain(),
  inputId,
  label = NULL,
  choices = NULL,
  selected = NULL,
  status = "default",
  size = "normal",
  justified = FALSE,
  checkIcon = list(),
  choiceNames = NULL,
  choiceValues = NULL,
  disabled = FALSE,
  disabledChoices = NULL
)
}
\arguments{
\item{session}{The \code{session} object passed to function given to
\code{shinyServer}. Default is \code{getDefaultReactiveDomain()}.}

\item{inputId}{The id of the input object.}

\item{label}{The label to set for the input object.}

\item{choices}{List of values to select from (if elements of the list are
named then that name rather than the value is displayed to the user). If
this argument is provided, then \code{choiceNames} and \code{choiceValues} must not
be provided, and vice-versa. The values should be strings; other types
(such as logicals and numbers) will be coerced to strings.}

\item{selected}{The initially selected value. If not specified, then it
defaults to the first item in \code{choices}. To start with no items selected,
use \code{character(0)}.}

\item{status}{Add a class to the buttons, you can use Bootstrap status like 'info', 'primary', 'danger', 'warning' or 'success'.
Or use an arbitrary strings to add a custom class, e.g. : with \code{status = "custom-class"}, buttons will have class \code{btn-custom-class}.}

\item{size}{Size of the buttons ('xs', 'sm', 'normal', 'lg')}

\item{justified}{If TRUE, fill the width of the parent div}

\item{checkIcon}{A list, if no empty must contain at least one element named 'yes'
corresponding to an icon to display if the button is checked.}

\item{choiceNames, choiceValues}{List of names and values, respectively, that
are displayed to the user in the app and correspond to the each choice (for
this reason, \code{choiceNames} and \code{choiceValues} must have the same length).
If either of these arguments is provided, then the other \emph{must} be provided
and \code{choices} \emph{must not} be provided. The advantage of using both of these
over a named list for \code{choices} is that \code{choiceNames} allows any type of UI
object to be passed through (tag objects, icons, HTML code, ...), instead
of just simple text. See Examples.}

\item{disabled}{Logical, disable or enable buttons,
if \code{TRUE} users won't be able to select a value.}

\item{disabledChoices}{Vector of specific choices to disable.}
}
\description{
Change the value of a radio group buttons input on the client
}
\examples{
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  radioGroupButtons(
    inputId = "somevalue",
    choices = c("A", "B", "C"),
    label = "My label"
  ),

  verbatimTextOutput(outputId = "res"),

  actionButton(inputId = "updatechoices", label = "Random choices"),
  pickerInput(
    inputId = "updateselected", label = "Update selected:",
    choices = c("A", "B", "C"), multiple = FALSE
  ),
  textInput(inputId = "updatelabel", label = "Update label")
)

server <- function(input, output, session) {

  output$res <- renderPrint({
    input$somevalue
  })

  observeEvent(input$updatechoices, {
    newchoices <- sample(letters, sample(3:9, 1))
    updateRadioGroupButtons(
      session = session,
      inputId = "somevalue",
      choices = newchoices
    )
    updatePickerInput(
      session = session,
      inputId = "updateselected",
      choices = newchoices
    )
  })

  observeEvent(input$updateselected, {
    updateRadioGroupButtons(
      session = session, inputId = "somevalue",
      selected = input$updateselected
    )
  }, ignoreNULL = TRUE, ignoreInit = TRUE)

  observeEvent(input$updatelabel, {
    updateRadioGroupButtons(
      session = session, inputId = "somevalue",
      label = input$updatelabel
    )
  }, ignoreInit = TRUE)

}

if (interactive())
  shinyApp(ui = ui, server = server)
}
\seealso{
\code{\link[=radioGroupButtons]{radioGroupButtons()}}
}
