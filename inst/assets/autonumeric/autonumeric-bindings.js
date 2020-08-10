// Currency Input Binding
var currencyInputBinding = new Shiny.InputBinding();
$.extend(currencyInputBinding, {

  find: function(scope) {
    return $(scope).find(".currency-input");
  },

  initialize: function(el) {
    var config = $(el)
      .parent()
      .find('script[data-for="' + el.id + '"]');
    config = JSON.parse(config.html());
    this[el.id] = new AutoNumeric(el, config.format);
  },

  getValue: function(el) {
    return this[el.id].getNumber();
  },

  subscribe: function(el, callback) {
    $(el).on("change keyup input", function(event) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".currencyInputBinding");
  },

  receiveMessage: function(el, data) {
    if (data.hasOwnProperty("value")) {
      this[el.id].set(data.value);
    }

    if (data.hasOwnProperty("format")) {
      this[el.id].update(data.format);
    }

    if (data.hasOwnProperty("label"))
      $(el)
        .parent()
        .parent()
        .find('label[for="' + Shiny.$escape(el.id) + '"]')
        .text(data.label);

    $(el).trigger("change");
  },

  getState: function(el) {

  },

  getRatePolicy: function() {
    return {
      policy: "debounce",
      delay: 500
    };
  }
});

Shiny.inputBindings.register(currencyInputBinding, "shinyWidgets.currencyInput");

// Autonumeric input binding

var autonumericInputBinding = new Shiny.InputBinding();
$.extend(autonumericInputBinding, {

  find: function(scope) {
    return $(scope).find(".autonumeric-input");
  },

  initialize: function(el) {
    var config = $(el)
      .parent()
      .find('script[data-for="' + el.id + '"]');
    config = JSON.parse(config.html());

    console.log(config);
    this[el.id] = new AutoNumeric(el, {
      currencySymbol : config.currencySymbol,
      currencySymbolPlacement : config.currencySymbolPlacement,
      decimalCharacter : config.decimalCharacter,
      digitGroupSeparator : config.digitGroupSeparator,
      allowDecimalPadding : config.allowDecimalPadding,
      decimalPlaces : config.decimalPlaces,
      decimalPlacesRawValue : config.decimalPlacesRawValue,
      decimalPlacesShownOnBlur : config.decimalPlacesShownOnBlur,
      decimalPlacesShownOnFocus : config.decimalPlacesShownOnFocus,
      digitalGroupSpacing : config.digitalGroupSpacing,
      alwaysAllowDecimalCharacter : config.alwaysAllowDecimalCharacter,
      createLocalList : config.createLocalList,
      decimalCharacterAlternative : config.decimalCharacterAlternative,
      divisorWhenUnfocused : config.divisorWhenUnfocused,
      rawValueDivisor : config.rawValueDivisor,
      emptyInputBehavior : config.emptyInputBehavior,
      selectNumberOnly : config.selectNumberOnly,
      selectOnFocus : config.selectOnFocus,
      eventBubbles : config.eventBubbles,
      eventIsCancelable : config.eventIsCancelable,
      formatOnPageLoad : config.formatOnPageLoad,
      formulaMode : config.formulaMode,
      historySize : config.historySize,
      isCancellable : config.isCancellable,
      leadingZero : config.leadingZero,
      maximumValue : config.maximumValue,
      minimumValue : config.minimumValue,
      modifyValueOnWheel : config.modifyValueOnWheel,
      wheelOn : config.wheelOn,
      wheelStep : config.wheelStep,
      negativeBracketsTypeOnBlur : config.negativeBracketsTypeOnBlur,
      negativePositiveSignPlacement : config.negativePositiveSignPlacement,
      negativeSignCharacter : config.negativeSignCharacter,
      positiveSignCharacter : config.positiveSignCharacter,
      showPositiveSign : config.showPositiveSign,
      onInvalidPaste : config.onInvalidPaste,
      overrideMinMaxLimits : config.overrideMinMaxLimits,
      readOnly : config.readOnly,
      roundingMethod : config.roundingMethod,
      saveValueToSessionStorage : config.saveValueToSessionStorage,
      serializeSpaces : config.serializeSpaces,
      showOnlyNumbersOnFocus : config.showOnlyNumbersOnFocus,
      showWarnings : config.showWarnings,
      styleRules : config.styleRules,
      //suffixText : config.suffixText,
      symbolWhenUnfocused : config.symbolWhenUnfocused,
      unformatOnHover : config.unformatOnHover,
      valuesToStrings : config.valuesToStrings,
      watchExternalChanges : config.watchExternalChanges
    });
  },

  getValue: function(el) {
    return this[el.id].getNumber();
  },

  subscribe: function(el, callback) {
    var config = $(el)
      .parent()
      .find('script[data-for="' + el.id + '"]');
    config = JSON.parse(config.html());
    if (config.immediate) {
      $(el).on("keyup.autonumericInputBinding change.autonumericInputBinding", function(event) {
      callback();
    });
    } else {
      $(el).on("input.autonumericInputBinding", function(event) {
      callback();
    });
    }
  },

  unsubscribe: function(el) {
    $(el).off(".autonumericInputBinding");
  },

  receiveMessage: function(el, data) {
    if (data.hasOwnProperty("value")) {
      this[el.id].set(data.value);
    }

    if (data.hasOwnProperty("options")) {
      this[el.id].update(data.options);
    }

    if (data.hasOwnProperty("label"))
      $(el)
        .parent()
        .parent()
        .find('label[for="' + Shiny.$escape(el.id) + '"]')
        .text(data.label);

    $(el).trigger("change");
  },

  getState: function(el) {

  },

  getRatePolicy: function() {
    return {
      policy: "debounce",
      delay: 500
    };
  }
});

Shiny.inputBindings.register(autonumericInputBinding, "shinyWidgets.autonumericInput");


