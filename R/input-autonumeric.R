
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
#'
#' @seealso \code{\link{autonumericInput}}
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
#'     shinyWidgets:::currencyInput("id1", "Euro:", value = 1234, format = "euro", width = 200, align = "right"),
#'     verbatimTextOutput("res1"),
#'
#'     shinyWidgets:::currencyInput("id2", "Dollar:", value = 1234, format = "dollar", width = 200, align = "left"),
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
#' An `R` wrapper over the javascript `AutoNumeric` library, for
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
#' @param decimalCharacter Defines what decimal separator character is used,
#'   defaults to ",".
#' @param digitGroupSeparator Defines what decimal separator character is used.
#' @param allowDecimalPadding
#' @param decimalPlaces
#' @param decimalPlacesRawValue
#' @param decimalPlacesShownOnBlur
#' @param decimalPlacesShownOnFocus
#' @param defaultValueOverride
#' @param digitalGroupSpacing
#' @param alwaysAllowDecimalCharacter
#' @param caretPositionOnFocus
#' @param createLocalList
#' @param decimalCharacterAlternative
#' @param divisorWhenUnfocused
#' @param rawValueDivisor
#' @param emptyInputBehavior
#' @param selectNumberOnly
#' @param selectOnFocus
#' @param eventBubbles
#' @param eventIsCancelable
#' @param failOnUnknownOption
#' @param formatOnPageLoad
#' @param formulaMode
#' @param historySize
#' @param isCancellable
#' @param leadingZero
#' @param maximumValue
#' @param minimumValue
#' @param modifyValueOnWheel
#' @param wheelOn
#' @param wheelStep
#' @param negativeBracketsTypeOnBlur
#' @param negativePositiveSignPlacement
#' @param negativeSignCharacter
#' @param positiveSignCharacter
#' @param showPositiveSign
#' @param noEventListeners
#' @param onInvalidPaste
#' @param outputFormat
#' @param overrideMinMaxLimits
#' @param readOnly
#' @param roundingMethod
#' @param saveValueToSessionStorage
#' @param serializeSpaces
#' @param showOnlyNumbersOnFocus
#' @param showWarnings
#' @param styleRules
#' @param suffixText
#' @param symbolWhemUnfocused
#' @param unformatOnHover
#' @param unformatOnSubmit
#' @param valuesToStrings
#' @param watchExternalChanges
#'
#' @return
#' @export
#'
#' @examples
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
                             defaultValueOverride = NULL,
                             digitalGroupSpacing = 3,
                             alwaysAllowDecimalCharacter = FALSE,
                             caretPositionOnFocus = "focus",
                             createLocalList = TRUE,
                             decimalCharacterAlternative = NULL,
                             divisorWhenUnfocused = NULL,
                             rawValueDivisor = NULL,
                             emptyInputBehavior = "focus",
                             selectNumberOnly = TRUE,
                             selectOnFocus = TRUE,
                             eventBubbles = TRUE,
                             eventIsCancelable = TRUE,
                             failOnUnknownOption = FALSE,
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
                             noEventListeners = FALSE,
                             onInvalidPaste = "error",
                             outputFormat = "string",
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
                             unformatOnSubmit = FALSE,
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
      defaultValueOverride = defaultValueOverride,
      digitalGroupSpacing = digitalGroupSpacing,
      alwaysAllowDecimalCharacter = alwaysAllowDecimalCharacter,
      caretPositionOnFocus = jsonlite::unbox(caretPositionOnFocus),
      createLocalList = createLocalList,
      decimalCharacterAlternative = decimalCharacterAlternative,
      divisorWhenUnfocused = divisorWhenUnfocused,
      rawValueDivisor = rawValueDivisor,
      emptyInputBehavior = emptyInputBehavior,
      selectNumberOnly = selectNumberOnly,
      selectOnFocus = selectOnFocus,
      eventBubbles = eventBubbles,
      eventIsCancelable = eventIsCancelable,
      failOnUnknownOption = failOnUnknownOption,
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
      noEventListeners = noEventListeners,
      onInvalidPaste = onInvalidPaste,
      outputFormat = outputFormat,
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
      unformatOnSubmit = unformatOnSubmit,
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
