
#' Format Numeric Inputs
#'
#' Shiny widgets for as-you-type formatting of currency and numeric values. For
#' a more modifiable version see [autonumericInput()]. These two
#' functions do the exact same thing but are named differently for more
#' intuitive use (currency for money, formatNumeric for percentage or other).
#'
#' @rdname formatNumericInput
#'
#' @param inputId The `input` slot that will be used to access the value.
#' @param label Display label for the control, or NULL for no label.
#' @param value Initial value (unformatted).
#' @param format A character string specifying the currency format of the
#'   input.  See "Details" for possible values.
#' @param width The width of the input box, eg. `"200px"` or
#'   \code{"100\%"}.
#' @param align The alignment of the text inside the input box, one of
#'   "center", "left", "right". Defaults to "center".
#'
#' @details
#' In regards to `format`, there are currently 41 sets of predefined
#' options that can be used, most of which are variations of one another.
#' The most common are:
#'
#' * "French"
#' * "Spanish"
#' * "NorthAmerican"
#' * "British"
#' * "Swiss"
#' * "Japanese"
#' * "Chinese"
#' * "Brazilian"
#' * "Turkish"
#' * "euro" (same as "French")
#' * "dollar" (same as "NorthAmerican")
#' * "percentageEU2dec"
#' * "percentageUS2dec"
#' * "dotDecimalCharCommaSeparator"
#' * "commaDecimalCharDotSeparator"
#'
#' To see the full list please visit
#' [this section](https://github.com/autoNumeric/autoNumeric/#predefined-common-options)
#' of the AutoNumeric Github Page.
#'
#' @references Bonneau, Alexandre. 2018. "AutoNumeric.js javascript Package". http://autonumeric.org
#'
#' @return a currency input widget that can be added to the UI of a shiny app.
#' @export
#'
#' @family autonumeric
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyWidgets)
#'
#'   ui <- fluidPage(
#'     tags$h2("Currency Input"),
#'
#'     currencyInput("id1", "Euro:", value = 1234, format = "euro", width = 200, align = "right"),
#'     verbatimTextOutput("res1"),
#'
#'     currencyInput("id2", "Dollar:", value = 1234, format = "dollar", width = 200, align = "right"),
#'     verbatimTextOutput("res2"),
#'
#'     currencyInput("id3", "Yen:", value = 1234, format = "Japanese", width = 200, align = "right"),
#'     verbatimTextOutput("res3"),
#'
#'     br(),
#'     tags$h2("Formatted Numeric Input"),
#'
#'     formatNumericInput("id4", "Numeric:", value = 1234, width = 200),
#'     verbatimTextOutput("res4"),
#'
#'     formatNumericInput("id5", "Percent:", value = 1234, width = 200, format = "percentageEU2dec"),
#'     verbatimTextOutput("res5")
#'   )
#'
#'   server <- function(input, output, session) {
#'     output$res1 <- renderPrint(input$id1)
#'     output$res2 <- renderPrint(input$id2)
#'     output$res3 <- renderPrint(input$id3)
#'     output$res4 <- renderPrint(input$id4)
#'     output$res5 <- renderPrint(input$id5)
#'   }
#'
#'   shinyApp(ui, server)
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
      class = "form-control autonumeric-input"
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
    html_dependency_shinyWidgets(),
    html_dependency_autonumeric()
  )
}

#' @rdname formatNumericInput
#' @export
formatNumericInput <- function(inputId,
                               label,
                               value,
                               format = "commaDecimalCharDotSeparator",
                               width = NULL,
                               align = "center") {
  currencyInput(inputId, label, value, format, width, align)
}

#' Update a Formatted Numeric Input Widget
#'
#' @param session Standard shiny `session`.
#' @param inputId The id of the input object.
#' @param label The label to set for the input object.
#' @param value The value to set for the input object.
#' @param format The format to change the input object to.
#'
#' @export
#' @rdname formaNumericInputUpdate
#'
#' @family autonumeric
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyWidgets)
#'
#'   ui <- fluidPage(
#'     tags$h2("Currency Input"),
#'
#'     currencyInput("id1", "Euro:", value = 1234, format = "euro", width = 200, align = "right"),
#'     verbatimTextOutput("res1"),
#'     actionButton("bttn0", "Change Input to Euros"),
#'     actionButton("bttn1", "Change Input to Dollars"),
#'     actionButton("bttn2", "Change Input to Yen")
#'   )
#'
#'   server <- function(input, output, session) {
#'
#'     output$res1 <- renderPrint(input$id1)
#'
#'     observeEvent(input$bttn0, {
#'       updateCurrencyInput(
#'         session = session,
#'         inputId = "id1",
#'         label = "Euro:",
#'         format = "euro"
#'       )
#'     })
#'     observeEvent(input$bttn1, {
#'       updateCurrencyInput(
#'         session = session,
#'         inputId = "id1",
#'         label = "Dollar:",
#'         format = "dollar"
#'       )
#'     })
#'     observeEvent(input$bttn2, {
#'       updateCurrencyInput(
#'         session = session,
#'         inputId = "id1",
#'         label = "Yen:",
#'         format = "Japanese"
#'       )
#'     })
#'
#'
#'   }
#'
#'   shinyApp(ui, server)
#' }
updateCurrencyInput <- function(session = getDefaultReactiveDomain(),
                                inputId,
                                label = NULL,
                                value = NULL,
                                format = NULL) {
  message <- dropNulls(list(label = label, value = value, format = format))
  session$sendInputMessage(inputId, message)
}

#' @rdname formaNumericInputUpdate
updateFormatNumericInput <- function(session = getDefaultReactiveDomain(),
                                     inputId,
                                     label = NULL,
                                     value = NULL,
                                     format = NULL) {
  message <- dropNulls(list(label = label, value = value, format = format))
  session$sendInputMessage(inputId, message)
}

#' Autonumeric Input Widget
#'
#' An R wrapper over the javascript AutoNumeric library, for
#' formatting numeric inputs in shiny applications.
#'
#' @param inputId The `input` slot that will be used to access the value.
#' @param label Display label for the control, or NULL for no label.
#' @param value Initial value (unformatted).
#' @param width The width of the input box, eg. `"200px"` or
#'   \code{"100\%"}.
#' @param align The alignment of the text inside the input box, one of
#'   "center" (default), "left", "right".
#' @param currencySymbol Defines the currency symbol string. It can be a string
#'   of more than one character (allowing for instance to use a space on either
#'   side of it, example: '$ ' or ' $'). Defaults to "".
#' @param currencySymbolPlacement Defines where the currency symbol should be
#'   placed, "p" for prefix or "s" for suffix (default).
#' @param decimalCharacter Defines what decimal separator character is used.
#'   Defaults to ",".
#' @param digitGroupSeparator Defines what decimal separator character is used.
#'   Defaults to ".".
#' @param allowDecimalPadding Defines if decimal places should be padded with
#'   zeros.  Defaults to TRUE.
#' @param decimalPlaces Defines the default number of decimal places to show
#'   on the formatted value, and keep for the precision. Must be 0 or a
#'   positive integer. Defaults to 2.
#' @param divisorWhenUnfocused The number that divides the element value on
#'   blur.  On focus, the number is multiplied back in. Defaults to NULL.
#' @param rawValueDivisor Divides the formatted value shown in the AutoNumeric
#'   element and store the divided result in `rawValue`. Defaults to 1.
#' @param formatOnPageLoad Determine if the default value will be formatted on
#'   initialization. Defaults to TRUE.
#' @param maximumValue Defines the maximum possible value a user can enter.
#' @param minimumValue Defines the minimum possible value a user can enter.
#' @param modifyValueOnWheel Allows the user to increment or decrement the
#'   element value with the mouse wheel. The wheel behavior can be modified
#'   by the `wheelStep` option. Defaults to TRUE.
#' @param emptyInputBehavior Defines what should be displayed in the element if the raw value is an empty string ''.
#' @param ... Additional parameters that can be passed to AutoNumeric.  See
#'   details for more information.
#'
#' @details
#' This function wraps the AutoNumeric.js library.  The parameter documentation
#' provided here should be sufficient for most users, but for those wishing to
#' use advanced configurations it is advised to look at the documentation on
#' the [AutoNumeric GitHub repository](https://github.com/autoNumeric/autoNumeric). Alexandre
#' Bonneau has done a wonderful job of documenting all parameters and full
#' explanations of all parameters and their associated values can be found
#' there.
#'
#' The `...` parameter can take any of the arguments listed on the
#' [AutoNumeric GitHub repository](https://github.com/autoNumeric/autoNumeric). A quick reference
#' follows:
#'
#'  * decimalPlacesRawValue - Defines How many decimal places should be kept
#'   for the raw value. If set to NULL (default) then `decimalPlaces` is
#'   used.
#'   * decimalPlacesShownOnBlur - Defines how many decimal places should be
#'   visible when the element is unfocused. If NULL (default) then
#'   `decimalPlaces` is used.
#'   * decimalPlacesShownOnFocus - Defines how many decimal places should be
#'   visible when the element has the focus. If NULL (default) then
#'   `decimalPlaces` is used.
#'   * digitalGroupSpacing - Defines how many numbers should be grouped
#'   together for the thousands separator groupings.  Must be one of
#'   c("2", "2s", "3", "4"). Defaults to 3.
#'  * alwaysAllowDecimalCharacter - Defines if the decimal character or
#'   decimal character alternative should be accepted when there is already
#'   a decimal character shown in the element. If set to TRUE, any decimal
#'   character input will be accepted and will subsequently modify the decimal
#'   character position, as well as the rawValue. If set to FALSE, the decimal
#'   character and its alternative key will be dropped. This is the default
#'   setting.
#'   * createLocalList - Defines if a local list of AutoNumeric objects should
#'   be kept when initializing this object. Defaults to TRUE.
#'   * decimalCharacterAlternative - Allow to declare an alternative decimal
#'   separator which is automatically replaced by `decimalCharacter` when
#'   typed. This is useful for countries that use a comma ',' as the decimal
#'   character and have keyboards with numeric pads providing a period '.' as
#'   the decimal character (in France or Spain for instance). Must be NULL
#'   (default), ",", or ".".
#'   * emptyInputBehavior - Defines what should be displayed in the element if
#'   the raw value is missing. One of c(NULL, "focus", "press", "always", "min",
#'   "max", "zero") or a custom value. Defaults to NULL.  See
#'   [AutoNumeric GitHub repository](https://github.com/autoNumeric/autoNumeric) for full
#'   details.
#'   * selectNumberOnly - Determine if the select all keyboard command will
#'   select the complete input text, or only the input numeric value.
#'   Defaults to `TRUE`.
#'   * selectOnFocus - Defines if the element value should be selected on
#'   focus. Note: The selection is done using the `selectNumberOnly` option.
#'   Defaults to `TRUE`.
#'   * eventBubbles - Defines if the custom and native events triggered by
#'   AutoNumeric should bubble up or not. Defaults to TRUE.
#'   * eventIsCancelable - Defines if the custom and native events triggered
#'   by AutoNumeric should be cancelable. Defaults to TRUE.
#'   * formulaMode - Defines if the formula mode can be activated by the user.
#'   If set to true, then the user can enter the formula mode by entering the '='
#'   character. The user will then be allowed to enter any simple math formula
#'   using numeric characters as well as the following operators: +, -, *, /, (
#'   and ). The formula mode is exited when the user either validate their math
#'   expression using the Enter key, or when the element is blurred. Defaults to
#'   `FALSE`.
#'   * historySize - Set the undo/redo history table size. Defaults to 20.
#'   * isCancellable - Allow the user to cancel and undo the changes he made
#'   to the given autonumeric-managed element, by pressing the `Escape`
#'   key. Defaults to `TRUE`.
#'   * leadingZero - This options describes if entering 0 on the far left of
#'   the numbers is allowed, and if the superfluous zeroes should be kept when
#'   the input is blurred. One of c("allow", "deny", and "keep"). Defaults to
#'   "deny". See [AutoNumeric GitHub repository](https://github.com/autoNumeric/autoNumeric)
#'   for full details.
#'   * wheelOn - Defines when the wheel event will increment or decrement
#'   the element value. One of c("focus", "hover"). Defaults to "focus".
#'   * wheelStep - Defines by how much the element value should be
#'   incremented/decremented on the wheel event. Can be a set value or the
#'   string "progressive" which determines the step from the size of the input.
#'   Defaults to "progressive".
#'   * negativeBracketsTypeOnBlur - Adds brackets-like characters on negative
#'   values when unfocused. Those brackets are visible only when the field does
#'   not have the focus. The left and right symbols should be enclosed in
#'   quotes and separated by a comma. Defaults to NULL.
#'   * negativePositiveSignPlacement - Placement of the negative/positive sign
#'   relative to the `currencySymbol` option. One of c("p", "s", "l",
#'   "r", NULL), defaults to NULL. See
#'   [AutoNumeric GitHub repository](https://github.com/autoNumeric/autoNumeric) for further
#'   documentation.
#'   * negativeSignCharacter - Defines the negative sign symbol to use. Must
#'   be a single character and be non-numeric. Defaults to "-".
#'   * positiveSignCharacter - Defines the positive sign symbol to use. Must
#'   be a single character and be non-numeric. Defaults to "+".
#'   * showPositiveSign - Allow the positive sign symbol
#'   `positiveSignCharacter` to be displayed for positive numbers.
#'   Defaults to `FALSE`.
#'   * onInvalidPaste - Manage how autoNumeric react when the user tries to
#'   paste an invalid number. One of c("error", "ignore", "clamp",
#'   "truncate", "replace"). Defaults to "error".
#'   * overrideMinMaxLimits - Override the minimum and maximum limits. Must
#'   be one of c("ceiling", "floor", "ignore", NULL). Defaults to "ceiling".
#'   * readOnly - Defines if the element (`<input>` or another allowed html tag)
#'   should be set as read only on initialization. Defaults to `FALSE`.
#'   * roundingMethod - Defines the rounding method to use. One of c("S", "A",
#'   "s", "a", "B", "U", "D", "C", "F", "N05", "CHF", "U05", "D05"). Defaults
#'   to "S".  See [AutoNumeric GitHub repository](https://github.com/autoNumeric/autoNumeric)
#'   for further documentation.
#'   * saveValueToSessionStorage - Set to TRUE to allow the
#'   `decimalPlacesShownOnFocus` value to be saved with sessionStorage.
#'   Defaults to `FALSE`.
#'   * serializeSpaces - Defines how the serialize functions should treat the
#'   spaces.  Either "+" (default) or "\%20" (the older behavior).
#'   * showOnlyNumbersOnFocus - Defines if the element value should be
#'   converted to the raw value on focus or mouseenter, (and back to the
#'   formatted on blur or mouseleave). Defaults to `FALSE`.
#'   * showWarnings - Defines if warnings should be shown in the console.
#'   Defaults to `TRUE`.
#'   * styleRules - Defines the rules that calculate the CSS class(es) to
#'   apply on the element, based on the raw unformatted value. Defaults to
#'   NULL.
#'   * suffixText - Add a text on the right hand side of the element value.
#'   This suffix text can have any characters in its string, except numeric
#'   characters and the negative or positive sign. Defaults to `NULL`.
#'   * symbolWhenUnfocused - Defines the symbol placed as a suffix when not
#'   in focus or hovered. Defaults to `NULL`.
#'   * unformatOnHover - Defines if the element value should be unformatted
#'   when the user hover his mouse over it while holding the Alt key. Defaults
#'   to `TRUE`.
#'   * valuesToStrings - Provides a way for automatically replacing the
#'   formatted value with a pre-defined string, when the raw value is equal
#'   to a specific value. Defaults to NULL.
#'   * watchExternalChanges - Defines if the AutoNumeric element should watch
#'   external changes made without using `.set()`. Defaults to `FALSE`.
#'
#' @return An autonumericInput object to be used in the UI function of a Shiny
#'   App.
#' @export
#'
#' @encoding UTF-8
#'
#' @family autonumeric
#'
#' @references Bonneau, Alexandre. 2018. "AutoNumeric.js javascript Package". http://autonumeric.org
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyWidgets)
#'
#'   ui <- fluidPage(
#'     h1("Autonumeric Inputs"),
#'     br(),
#'     autonumericInput(
#'       inputId = "id1",
#'       label = "Default Input",
#'       value = 1234.56
#'     ),
#'     verbatimTextOutput("res1"),
#'
#'     autonumericInput(
#'       inputId = "id2",
#'       label = "Custom Thousands of Dollars Input",
#'       value = 1234.56,
#'       align = "right",
#'       currencySymbol = "$",
#'       currencySymbolPlacement = "p",
#'       decimalCharacter = ".",
#'       digitGroupSeparator = ",",
#'       divisorWhenUnfocused = 1000,
#'       symbolWhenUnfocused = "K"
#'     ),
#'     verbatimTextOutput("res2"),
#'
#'     autonumericInput(
#'       inputId = "id3",
#'       label = "Custom Millions of Euros Input with Positive Sign",
#'       value = 12345678910,
#'       align = "right",
#'       currencySymbol = "\u20ac",
#'       currencySymbolPlacement = "s",
#'       decimalCharacter = ",",
#'       digitGroupSeparator = ".",
#'       divisorWhenUnfocused = 1000000,
#'       symbolWhenUnfocused = " (millions)",
#'       showPositiveSign = TRUE
#'     ),
#'     verbatimTextOutput("res3")
#'   )
#'
#'   server <- function(input, output, session) {
#'     output$res1 <- renderPrint(input$id1)
#'     output$res2 <- renderPrint(input$id2)
#'     output$res3 <- renderPrint(input$id3)
#'   }
#'
#'   shinyApp(ui, server)
#' }
autonumericInput <- function(inputId, label, value,
                             width = NULL,
                             align = "center",
                             currencySymbol = NULL,
                             currencySymbolPlacement = NULL,
                             decimalCharacter = NULL,
                             digitGroupSeparator = NULL,
                             allowDecimalPadding = NULL,
                             decimalPlaces = NULL,
                             divisorWhenUnfocused = NULL,
                             rawValueDivisor = NULL,
                             formatOnPageLoad = NULL,
                             maximumValue = NULL,
                             minimumValue = NULL,
                             modifyValueOnWheel = NULL,
                             emptyInputBehavior = "null",
                             ...) {
  value <- shiny::restoreInput(inputId, value)

  # Validate arguments
  # if (!(currencySymbolPlacement %in% c("p", "s")))
  #   warning("parameter `currencySymbolPlacement` must be one of c('p', 's')")

  data <- jsonlite::toJSON(
    x = list(
      options = dropNulls(
        append(
          list(
            currencySymbol = currencySymbol,
            currencySymbolPlacement = currencySymbolPlacement,
            decimalCharacter = decimalCharacter,
            digitGroupSeparator = digitGroupSeparator,
            allowDecimalPadding = allowDecimalPadding,
            decimalPlaces = decimalPlaces,
            divisorWhenUnfocused = divisorWhenUnfocused,
            rawValueDivisor = rawValueDivisor,
            formatOnPageLoad = formatOnPageLoad,
            maximumValue = maximumValue,
            minimumValue = minimumValue,
            modifyValueOnWheel = modifyValueOnWheel,
            emptyInputBehavior = emptyInputBehavior
          ),
          list(...)
        )
      )
    ),
    auto_unbox = TRUE,
    json_verbatim = TRUE
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
    html_dependency_shinyWidgets(),
    html_dependency_autonumeric()
  )
}

#' Update an Autonumeric Input Object
#'
#' @param session Standard shiny \code{session}.
#' @param inputId The id of the input object.
#' @param label The label to set for the input object.
#' @param value The value to set for the input object.
#' @param options List of additional parameters to update, use
#'   \code{autonumericInput}'s arguments.
#'
#' @export
#'
#' @family autonumeric
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyWidgets)
#'
#'   ui <- fluidPage(
#'     h1("AutonumericInput Update Example"),
#'     br(),
#'     autonumericInput(
#'       inputId = "id1",
#'       label = "Autonumeric Input",
#'       value = 1234.56,
#'       align = "center",
#'       currencySymbol = "$ ",
#'       currencySymbolPlacement = "p",
#'       decimalCharacter = ".",
#'       digitGroupSeparator = ","
#'     ),
#'     verbatimTextOutput("res1"),
#'     actionButton("bttn1", "Change Input to Euros"),
#'     actionButton("bttn2", "Change Input to Dollars"),
#'     br(),
#'     br(),
#'     sliderInput("decimals", "Select Number of Decimal Places",
#'                 value = 2, step = 1, min = 0, max = 6),
#'     actionButton("bttn3", "Update Number of Decimal Places")
#'   )
#'
#'   server <- function(input, output, session) {
#'     output$res1 <- renderPrint(input$id1)
#'
#'     observeEvent(input$bttn1, {
#'       updateAutonumericInput(
#'         session = session,
#'         inputId = "id1",
#'         label = "Euros:",
#'         value = 6543.21,
#'         options = list(
#'           currencySymbol = "\u20ac",
#'           currencySymbolPlacement = "s",
#'           decimalCharacter = ",",
#'           digitGroupSeparator = "."
#'         )
#'       )
#'     })
#'     observeEvent(input$bttn2, {
#'       updateAutonumericInput(
#'         session = session,
#'         inputId = "id1",
#'         label = "Dollars:",
#'         value = 6543.21,
#'         options = list(
#'           currencySymbol = "$",
#'           currencySymbolPlacement = "p",
#'           decimalCharacter = ".",
#'           digitGroupSeparator = ","
#'         )
#'       )
#'     })
#'     observeEvent(input$bttn3, {
#'       updateAutonumericInput(
#'         session = session,
#'         inputId = "id1",
#'         options = list(
#'           decimalPlaces = input$decimals
#'         )
#'       )
#'     })
#'   }
#'
#'   shinyApp(ui, server)
#' }
updateAutonumericInput <- function(session = getDefaultReactiveDomain(),
                                   inputId,
                                   label = NULL,
                                   value = NULL,
                                   options = NULL) {
  message <- dropNulls(list(label = label, value = value, options = options))
  session$sendInputMessage(inputId, message)
}
