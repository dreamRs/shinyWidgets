
#' Currency Input Widget
#'
#' A shiny widget for as-you-type formatting of currency. For a more modifiable
#' version see \code{\link{autonumericInput}}.
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label Display label for the control, or NULL for no label.
#' @param value Initial value (unformatted).
#' @param format A character string specifying the currency format of the
#'   input.  See "Details" for possible values.
#' @param width The width of the input box, eg. \code{"200px"} or
#'   \code{"100\%"}.
#' @param align The alignment of the text inside the input box, one of
#'   "center", "left", "right". Defaults to "center".
#'
#' @details
#' In regards to \code{format}, there are currently 41 sets of predefined
#' options that can be used, most of which are variations of one another.
#' The most common are:
#'
#' \itemize{
#'   \item \code{"French"}
#'   \item \code{"Spanish"}
#'   \item \code{"NorthAmerican"}
#'   \item \code{"British"}
#'   \item \code{"Swiss"}
#'   \item \code{"Japanese"}
#'   \item \code{"Chinese"}
#'   \item \code{"Brazilian"}
#'   \item \code{"Turkish"}
#'   \item \code{"euro"} (same as \code{"French"})
#'   \item \code{"dollar"} (same as \code{"NorthAmerican"})
#'   \item \code{"percentageEU2dec"}
#'   \item \code{"percentageUS2dec"}
#' }
#'
#' To see the full list please visit
#' \href{https://github.com/autoNumeric/autoNumeric/#predefined-common-options}{this section}
#' of the AutoNumeric Github Page.
#'
#' @seealso \code{\link{autonumericInput}}
#'
#' @references Bonneau, Alexandre. 2018. "AutoNumeric.js javascript Package".
#'   \url{http://autonumeric.org}
#'
#' @return a currency input widget that can be added to the UI of a shiny app.
#' @export
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyWidgets)
#'
#'   ui <- fluidPage(
#'     tags$h2("Currency Input"),
#'
#'     currencyInput(
#'       inputId = "id1",
#'       label = "Euro:",
#'       value = 1234,
#'       format = "euro",
#'       width = 200,
#'       align = "right"
#'     ),
#'     verbatimTextOutput("res1"),
#'
#'     currencyInput(
#'       inputId = "id2",
#'       label = "Dollar:",
#'       value = 1234,
#'       format = "dollar",
#'       width = 200,
#'       align = "left"
#'     ),
#'     verbatimTextOutput("res2")
#'   )
#'
#'   server <- function(input, output, session) {
#'     output$res1 <- renderPrint(input$id1)
#'     output$res2 <- renderPrint(input$id2)
#'   }
#'
#'   shinyApp(ui, server)
#'
#' }
currencyInput <- function(inputId, label, value, format = "euro",
                          width = NULL, align = "center") {
  value <- shiny::restoreInput(inputId, value)
  tags$div(
    class = "form-group shiny-input-container",
    style = if (!is.null(width)) paste0("width: ", shiny::validateCssUnit(width), ";"),
    if (!is.null(label)) tags$label(`for` = inputId, label),
    tags$input(
      type = "text",
      style = paste0("text-align: ", align, "; font-size: 1.5rem;"),
      value = value,
      id = inputId,
      class = "form-control currency-input"
    ),
    tags$script(
      type = "application/json",
      `data-for` = inputId,
      jsonlite::toJSON(
        x = list(
          format = format
        ),
        auto_unbox = TRUE,
        json_verbatim = TRUE
      )
    ),
    html_dependency_autonumeric()
  )
}

#' Autonumeric Input Widget
#'
#' An \code{R} wrapper over the javascript \code{AutoNumeric} library, for
#' formatting numeric inputs in shiny applications.
#'
#' @param inputId The \code{input} slot that will be used to access the value.
#' @param label Display label for the control, or NULL for no label.
#' @param value Initial value (unformatted).
#' @param width The width of the input box, eg. \code{"200px"} or
#'   \code{"100\%"}.
#' @param align The alignment of the text inside the input box, one of
#'   "center" (default), "left", "right".
#' @param currencySymbol Defines the currency symbol string. It can be a string
#'   of more than one character (allowing for instance to use a space on either
#'   side of it, example: '$ ' or ' $'). Defaults to "".
#' @param currencySymbolPlacement Defines where the currency symbol should be
#'   placed, "p" for prefix or "s" for suffix (default).
#' @param decimalCharacter Defines what decimal separator character is used.
#'   Must be one of c(',', '.', '·', '٫', '⎖'). Defaults to ",".
#' @param digitGroupSeparator Defines what decimal separator character is used.
#'   Must be one of c(',', '.', ' ', '', ''', '٬', '˙'). Defaults to ".".
#' @param allowDecimalPadding Defines if decimal places should be padded with
#'   zeros.  Defaults to TRUE.
#' @param decimalPlaces Defines the default number of decimal places to show
#'   on the formatted value, and keep for the precision. Must be 0 or a
#'   positive integer. Defaults to 2.
#' @param decimalPlacesRawValue Defines How many decimal places should be kept
#'   for the raw value. If set to NULL (default) then \code{decimalPlaces} is
#'   used.
#' @param decimalPlacesShownOnBlur Defines how many decimal places should be
#'   visible when the element is unfocused. If NULL (default) then
#'   \code{decimalPlaces} is used.
#' @param decimalPlacesShownOnFocus Defines how many decimal places should be
#'   visible when the element has the focus. If NULL (default) then
#'   \code{decimalPlaces} is used.
#' @param digitalGroupSpacing Defines how many numbers should be grouped
#'   together for the thousands separator groupings.  Must be one of
#'   c("2", "2s", "3", "4"). Defaults to 3.
#' @param alwaysAllowDecimalCharacter Defines if the decimal character or
#'   decimal character alternative should be accepted when there is already
#'   a decimal character shown in the element. If set to TRUE, any decimal
#'   character input will be accepted and will subsequently modify the decimal
#'   character position, as well as the rawValue. If set to FALSE, the decimal
#'   character and its alternative key will be dropped. This is the default
#'   setting.
#' @param createLocalList Defines if a local list of AutoNumeric objects should
#'   be kept when initializing this object. Defaults to TRUE.
#' @param decimalCharacterAlternative Allow to declare an alternative decimal
#'   separator which is automatically replaced by \code{decimalCharacter} when
#'   typed. This is useful for countries that use a comma ',' as the decimal
#'   character and have keyboards with numeric pads providing a period '.' as
#'   the decimal character (in France or Spain for instance). Must be NULL
#'   (default), ",", or ".".
#' @param divisorWhenUnfocused The number that divides the element value on
#'   blur.  On focus, the number is multiplied back in. Defaults to NULL.
#' @param rawValueDivisor Divides the formatted value shown in the AutoNumeric
#'   element and store the divided result in \code{rawValue}. Defaults to NULL.
#' @param emptyInputBehavior Defines what should be displayed in the element if
#'   the raw value is missing. One of c(NULL, "focus", "press", "always", "min",
#'   "max", "zero") or a custom value. Defaults to NULL.  See
#'   \href{http://autonumeric.org/guide}{AutoNumeric documentation} for full
#'   details.
#' @param selectNumberOnly Determine if the select all keyboard command will
#'   select the complete input text, or only the input numeric value.
#'   Defaults to TRUE.
#' @param selectOnFocus Defines if the element value should be selected on
#' focus. Note: The selection is done using the \code{selectNumberOnly} option.
#' Defaults to TRUE.
#' @param eventBubbles Defines if the custom and native events triggered by
#'   AutoNumeric should bubble up or not. Defaults to TRUE.
#' @param eventIsCancelable Defines if the custom and native events triggered
#'   by AutoNumeric should be cancelable. Defaults to TRUE.
#' @param formatOnPageLoad Determine if the default value will be formatted on
#'   initialization. Defaults to TRUE.
#' @param formulaMode Defines if the formula mode can be activated by the user.
#'   If set to true, then the user can enter the formula mode by entering the '='
#'   character. The user will then be allowed to enter any simple math formula
#'   using numeric characters as well as the following operators: +, -, *, /, (
#'   and ). The formula mode is exited when the user either validate their math
#'   expression using the Enter key, or when the element is blurred. Defaults to
#'   FALSE.
#' @param historySize Set the undo/redo history table size. Defaults to 20.
#' @param isCancellable Allow the user to cancel and undo the changes he made
#'   to the given autonumeric-managed element, by pressing the \code{Escape}
#'   key. Defaults to TRUE.
#' @param leadingZero This options describes if entering 0 on the far left of
#'   the numbers is allowed, and if the superfluous zeroes should be kept when
#'   the input is blurred. One of c("allow", "deny", and "keep"). Defaults to
#'   "deny". See \href{http://autonumeric.org/guide}{AutoNumeric documentation}
#'   for full details.
#' @param maximumValue Defines the maximum possible value a user can enter.
#' @param minimumValue Defines the minimum possible value a user can enter.
#' @param modifyValueOnWheel Allows the user to increment or decrement the
#'   element value with the mouse wheel. The wheel behavior can be modified
#'   by the \code{wheelStep} option. Defaults to TRUE.
#' @param wheelOn Defines when the wheel event will increment or decrement
#' the element value. One of c("focus", "hover"). Defaults to "focus".
#' @param wheelStep Defines by how much the element value should be
#'   incremented/decremented on the wheel event. Can be a set value or the
#'   string "progressive" which determines the step from the size of the input.
#'   Defaults to "progressive".
#' @param negativeBracketsTypeOnBlur Adds brackets-like characters on negative
#'   values when unfocused. Those brackets are visible only when the field does
#'   not have the focus. The left and right symbols should be enclosed in
#'   quotes and separated by a comma.  Must be one of c("(,)", "[,]", "<,>",
#'   "{,}", "〈,〉", "｢,｣", "⸤,⸥", "⟦,⟧', "‹,›", "«,»", NULL) Defaults to NULL.
#' @param negativePositiveSignPlacement Placement of the negative/positive sign
#'   relative to the \code{currencySymbol} option. One of c("p", "s", "l",
#'   "r", NULL), defaults to NULL. See
#'   \href{http://autonumeric.org/guide}{AutoNumeric documentation} for further
#'   documentation.
#' @param negativeSignCharacter Defines the negative sign symbol to use. Must
#'   be a single character and be non-numeric. Defaults to "-".
#' @param positiveSignCharacter Defines the positive sign symbol to use. Must
#'   be a single character and be non-numeric. Defaults to "+".
#' @param showPositiveSign Allow the positive sign symbol
#'   \code{positiveSignCharacter} to be displayed for positive numbers.
#'   Defaults to FALSE.
#' @param onInvalidPaste Manage how autoNumeric react when the user tries to
#'   paste an invalid number. One of c("error", "ignore", "clamp",
#'   "truncate", "replace"). Defaults to "error".
#' @param overrideMinMaxLimits Override the minimum and maximum limits. Must
#'   be one of c("ceiling", "floor", "ignore", NULL). Defaults to "ceiling".
#' @param readOnly Defines if the element (<input> or another allowed html tag)
#'   should be set as read only on initialization. Defaults to FALSE.
#' @param roundingMethod Defines the rounding method to use. One of c("S", "A",
#'   "s", "a", "B", "U", "D", "C", "F", "N05", "CHF", "U05", "D05"). Defaults
#'   to "S".  See \href{http://autonumeric.org/guide}{AutoNumeric documentation}
#'   for further documentation.
#' @param saveValueToSessionStorage Set to TRUE to allow the
#'   \code{decimalPlacesShownOnFocus} value to be saved with sessionStorage.
#'   Defaults to FALSE.
#' @param serializeSpaces Defines how the serialize functions should treat the
#'   spaces.  Either "+" (default) or "\%20" (the older behavior).
#' @param showOnlyNumbersOnFocus Defines if the element value should be
#'   converted to the raw value on focus or mouseenter, (and back to the
#'   formatted on blur or mouseleave). Defaults to FALSE.
#' @param showWarnings Defines if warnings should be shown in the console.
#'   Defaults to TRUE.
#' @param styleRules Defines the rules that calculate the CSS class(es) to
#'   apply on the element, based on the raw unformatted value. Defaults to
#'   NULL.
#' @param suffixText Add a text on the right hand side of the element value.
#'   This suffix text can have any characters in its string, except numeric
#'   characters and the negative or positive sign. Defaults to NULL.
#' @param symbolWhenUnfocused Defines the symbol placed as a suffix when not
#'   in focus or hovered. Defaults to NULL.
#' @param unformatOnHover Defines if the element value should be unformatted
#'   when the user hover his mouse over it while holding the Alt key. Defaults
#'   to TRUE.
#' @param valuesToStrings Provides a way for automatically replacing the
#'   formatted value with a pre-defined string, when the raw value is equal
#'   to a specific value. Defaults to NULL.
#' @param watchExternalChanges Defines if the AutoNumeric element should watch
#'   external changes made without using \code{.set()}. Defaults to FALSE.
#'
#' @details
#' This function wraps the AutoNumeric.js library.  The parameter documentation
#' provided here should be sufficient for most users, but for those wishing to
#' use advanced configurations it is advised to look at the documentation on
#' the \href{http://autonumeric.org/guide}{AutoNumeric website}.  Alexandre
#' Bonneau has done a wonderful job of documenting all parameters and full
#' explanations of all parameters and their associated values can be found
#' there.
#'
#' @return An autonumericInput object to be used in the UI function of a Shiny
#'   App.
#' @export
#'
#' @references Bonneau, Alexandre. 2018. "AutoNumeric.js javascript Package".
#'   \url{http://autonumeric.org}
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyWidgets)
#'
#'   ui <- fluidPage(
#'     autonumericInput(
#'       inputId = "id1",
#'       label = "Autonumeric Input",
#'       value = 1234.56,
#'       align = "right",
#'       currencySymbol = "$",
#'       currencySymbolPlacement = "p",
#'       decimalCharacter = ".",
#'       digitGroupSeparator = ","
#'     ),
#'     verbatimTextOutput("res1")
#'   )
#'
#'   server <- function(input, output, session) {
#'     output$res1 <- renderPrint(input$id1)
#'   }
#'
#'   shinyApp(ui, server)
#' }
autonumericInput <- function(inputId, label, value,
                             width = NULL,
                             align = "center",
                             currencySymbol = "",
                             currencySymbolPlacement = "s",
                             decimalCharacter = ",",
                             digitGroupSeparator = ".",
                             allowDecimalPadding = TRUE,
                             decimalPlaces = 2,
                             decimalPlacesRawValue = NULL,
                             decimalPlacesShownOnBlur = NULL,
                             decimalPlacesShownOnFocus = NULL,
                             digitalGroupSpacing = 3,
                             alwaysAllowDecimalCharacter = FALSE,
                             createLocalList = TRUE,
                             decimalCharacterAlternative = NULL,
                             divisorWhenUnfocused = NULL,
                             rawValueDivisor = NULL,
                             emptyInputBehavior = "focus",
                             selectNumberOnly = TRUE,
                             selectOnFocus = TRUE,
                             eventBubbles = TRUE,
                             eventIsCancelable = TRUE,
                             formatOnPageLoad = TRUE,
                             formulaMode = FALSE,
                             historySize = 20,
                             isCancellable = TRUE,
                             leadingZero = "deny",
                             maximumValue = 1000000000000,
                             minimumValue = -1000000000000,
                             modifyValueOnWheel = TRUE,
                             wheelOn = "focus",
                             wheelStep = "progressive",
                             negativeBracketsTypeOnBlur = NULL,
                             negativePositiveSignPlacement = NULL,
                             negativeSignCharacter = "-",
                             positiveSignCharacter = "+",
                             showPositiveSign = FALSE,
                             onInvalidPaste = "error",
                             overrideMinMaxLimits = "ceiling",
                             readOnly = FALSE,
                             roundingMethod = "S",
                             saveValueToSessionStorage = FALSE,
                             serializeSpaces = "+",
                             showOnlyNumbersOnFocus = FALSE,
                             showWarnings = TRUE,
                             styleRules = NULL,
                             suffixText = NULL,
                             symbolWhenUnfocused = "",
                             unformatOnHover = TRUE,
                             valuesToStrings = NULL,
                             watchExternalChanges = FALSE) {
  value <- shiny::restoreInput(inputId, value)

  # Validate arguments
  if (!(currencySymbolPlacement %in% c("p", "s")))
    warning("parameter `currencySymbolPlacement` must be one of c('p', 's')")

  data <- jsonlite::toJSON(
    x = lapply(list(
      currencySymbol = currencySymbol,
      currencySymbolPlacement = currencySymbolPlacement,
      decimalCharacter = decimalCharacter,
      digitGroupSeparator = digitGroupSeparator,
      allowDecimalPadding = allowDecimalPadding,
      decimalPlaces = decimalPlaces,
      decimalPlacesRawValue = decimalPlacesRawValue,
      decimalPlacesShownOnBlur = decimalPlacesShownOnBlur,
      decimalPlacesShownOnFocus = decimalPlacesShownOnFocus,
      digitalGroupSpacing = digitalGroupSpacing,
      alwaysAllowDecimalCharacter = alwaysAllowDecimalCharacter,
      createLocalList = createLocalList,
      decimalCharacterAlternative = decimalCharacterAlternative,
      divisorWhenUnfocused = divisorWhenUnfocused,
      rawValueDivisor = rawValueDivisor,
      emptyInputBehavior = emptyInputBehavior,
      selectNumberOnly = selectNumberOnly,
      selectOnFocus = selectOnFocus,
      eventBubbles = eventBubbles,
      eventIsCancelable = eventIsCancelable,
      formatOnPageLoad = formatOnPageLoad,
      formulaMode = formulaMode,
      historySize = historySize,
      isCancellable = isCancellable,
      leadingZero = leadingZero,
      maximumValue = maximumValue,
      minimumValue = minimumValue,
      modifyValueOnWheel = modifyValueOnWheel,
      wheelOn = wheelOn,
      wheelStep = wheelStep,
      negativeBracketsTypeOnBlur = negativeBracketsTypeOnBlur,
      negativePositiveSignPlacement = negativePositiveSignPlacement,
      negativeSignCharacter = negativeSignCharacter,
      positiveSignCharacter = positiveSignCharacter,
      showPositiveSign = showPositiveSign,
      onInvalidPaste = onInvalidPaste,
      overrideMinMaxLimits = overrideMinMaxLimits,
      readOnly = readOnly,
      roundingMethod = roundingMethod,
      saveValueToSessionStorage = saveValueToSessionStorage,
      serializeSpaces = serializeSpaces,
      showOnlyNumbersOnFocus = showOnlyNumbersOnFocus,
      showWarnings = showWarnings,
      styleRules = styleRules,
      suffixText = suffixText,
      symbolWhenUnfocused = symbolWhenUnfocused,
      unformatOnHover = unformatOnHover,
      valuesToStrings = valuesToStrings,
      watchExternalChanges = watchExternalChanges
    ), function(x) {
      if (identical(x, TRUE))
        "true"
      else if (identical(x, FALSE))
        "false"
      else x
    }),
    auto_unbox = TRUE,
    json_verbatim = TRUE,
    null = "null",
    na = "null"
  )
  tags$div(
    class = "form-group shiny-input-container",
    style = if (!is.null(width)) paste0("width: ", validateCssUnit(width), ";"),
    if (!is.null(label)) tags$label(`for` = inputId, label),
    tags$input(
      type = "text",
      style = paste0("text-align: ", align, "; font-size: 1.5rem;"),
      value = value,
      id = inputId,
      class = "form-control autonumeric-input"
    ),
    tags$script(
      type = "application/json",
      `data-for` = inputId,
      data
    ),
    html_dependency_autonumeric()
  )
}
