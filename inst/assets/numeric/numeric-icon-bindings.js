function updateLabel(labelTxt, labelNode) {
  // Only update if label was specified in the update method
  if (typeof labelTxt === "undefined") return;

  if (labelNode.length !== 1) {
    throw new Error("labelNode must be of length 1");
  } // Should the label be empty?

  var emptyLabel = $.isArray(labelTxt) && labelTxt.length === 0;

  if (emptyLabel) {
    labelNode.addClass("shiny-label-null");
  } else {
    labelNode.text(labelTxt);
    labelNode.removeClass("shiny-label-null");
  }
}
function addError(element) {
  $(element)
    .parent()
    .parent()
    .addClass("has-error");
}
function removeError(element) {
  $(element)
    .parent()
    .parent()
    .removeClass("has-error");
}
function showHelp(element) {
  $(element)
    .parent()
    .parent()
    .find(".help-block")
    .removeClass("hidden")
    .addClass("show");
}
function hideHelp(element) {
  $(element)
    .parent()
    .parent()
    .find(".help-block")
    .removeClass("show")
    .addClass("hidden");
}
var numericInputIconBinding = new Shiny.InputBinding();
$.extend(numericInputIconBinding, {
  find: function find(scope) {
    return $(scope).find(".shinywidgets-numeric");
  },
  getValue: function getValue(el) {
    var numberVal = $(el).val();
    var min = $(el).attr("min");
    var has_min = typeof min !== typeof undefined && min !== false;
    if (has_min) {
      min = +min;
    } else {
      min = -Infinity;
    }
    var max = $(el).attr("max");
    var has_max = typeof max !== typeof undefined && max !== false;
    if (has_max) {
      max = +max;
    } else {
      max = Infinity;
    }
    if (/^\s*$/.test(numberVal)) {
      // Return null if all whitespace
      return null;
    } else if (!isNaN(numberVal)) {
      // If valid Javascript number string, coerce to number
      numberVal = +numberVal;
    }
    if (numberVal > max) {
      addError(el);
      showHelp(el);
      numberVal = max;
    } else if (numberVal < min) {
      addError(el);
      showHelp(el);
      numberVal = min;
    } else {
      hideHelp(el);
      removeError(el);
    }
    return numberVal;
  },
  setValue: function setValue(el, value) {
    el.value = value;
  },
  subscribe: function subscribe(el, callback) {
    $(el).on(
      "keyup.numericInputIconBinding input.numericInputIconBinding",
      function(event) {
        callback(true);
      }
    );
    $(el).on("change.numericInputIconBinding", function(event) {
      callback(false);
    });
  },
  unsubscribe: function unsubscribe(el) {
    $(el).off(".textInputBinding");
  },
  getType: function getType(el) {
    return "shiny.number";
  },
  receiveMessage: function receiveMessage(el, data) {
    if (data.hasOwnProperty("value")) el.value = data.value;
    if (data.hasOwnProperty("min")) el.min = data.min;
    if (data.hasOwnProperty("max")) el.max = data.max;
    if (data.hasOwnProperty("step")) el.step = data.step;
    updateLabel(data.label, this._getLabelNode(el));
    $(el).trigger("change");
  },
  getState: function getState(el) {
    return {
      label: this._getLabelNode(el).text(),
      value: this.getValue(el),
      min: Number(el.min),
      max: Number(el.max),
      step: Number(el.step)
    };
  },
  _getLabelNode: function _getLabelNode(el) {
    return $(el)
      .parent()
      .find('label[for="' + Shiny.$escape(el.id) + '"]');
  }
});
Shiny.inputBindings.register(
  numericInputIconBinding,
  "shinyWidgets.numericInputIcon"
);

