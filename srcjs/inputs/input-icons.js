import $ from "jquery";
import "shiny";
import { updateLabel } from "../modules/utils";

// search input bindings ------------------------------------------------------------------

var searchInputBinding = new Shiny.InputBinding();
$.extend(searchInputBinding, {
  find: function(scope) {
    return $(scope).find(".search-text");
  },
  getId: function(el) {
    return $(el).attr("id");
  },
  getValue: function(el) {
    return $("#" + Shiny.$escape(el.id) + "_text").val();
  },
  setValue: function(el, value) {
    $("#" + Shiny.$escape(el.id) + "_text").val(value);
  },
  subscribe: function(el, callback) {
    $("#" + Shiny.$escape(el.id) + "_text").on(
      "keyup.searchInputBinding input.searchInputBinding",
      function(event) {
        if (event.keyCode == 13) {
          //if enter
          callback();
        }
      }
    );
    $("#" + Shiny.$escape(el.id) + "_search").on("click", function(event) {
      // on click
      callback();
    });
    $("#" + Shiny.$escape(el.id) + "_reset").on("click", function(event) {
      // on click
      var reset = $("#" + Shiny.$escape(el.id)).data("reset");
      if (reset == "TRUE") {
        var resetValue = $("#" + Shiny.$escape(el.id)).data("reset-value");
        $("#" + Shiny.$escape(el.id) + "_text").val(resetValue);
      }
      callback();
    });
  },
  unsubscribe: function(el) {
    $(el).off(".searchInputBinding");
  },
  receiveMessage: function(el, data) {
    if (data.hasOwnProperty("value")) this.setValue(el, data.value);

    if (data.hasOwnProperty("label")) {
      var label = $("#" + el.id + "-label");
      updateLabel(data.label, label);
    }

    if (data.hasOwnProperty("placeholder")) {
      $("#" + el.id + "_text")[0].placeholder = data.placeholder;
    }

    if (data.trigger) {
      $("#" + el.id + "_search").click();
    }

    $(el).trigger("change");
  },
  getState: function(el) {
    return {
      value: this.getValue(el) //el.value
    };
  },
  getRatePolicy: function() {
    return {
      policy: "debounce",
      delay: 250
    };
  }
});
Shiny.inputBindings.register(searchInputBinding, "shinyWidgets.searchInput");




// numeric icon input --------------------------------------------------------------------

function addError(element) {
  $(element)
    .parent()
    .parent()
    .addClass("has-error");
  $(element).addClass("is-invalid");
}
function removeError(element) {
  $(element)
    .parent()
    .parent()
    .removeClass("has-error is-invalid");
  $(element).removeClass("is-invalid");
}
function showHelp(element) {
  $(element)
    .parent()
    .parent()
    .find(".help-block")
    .removeClass("hidden d-none")
    .addClass("show d-block");
}
function hideHelp(element) {
  $(element)
    .parent()
    .parent()
    .find(".help-block")
    .removeClass("show d-block")
    .addClass("hidden d-none");
}

var numericInputIconBinding = new Shiny.InputBinding();
$.extend(numericInputIconBinding, {
  find: function(scope) {
    return $(scope).find(".numeric-input-icon");
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
  setValue: function(el, value) {
    el.value = value;
  },
  subscribe: function(el, callback) {
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
  unsubscribe: function(el) {
    $(el).off(".numericInputIconBinding");
  },
  getType: function(el) {
    return "shiny.number";
  },
  receiveMessage: function(el, data) {
    if (data.hasOwnProperty("label")) {
      var label = $("#" + el.id + "-label");
      updateLabel(data.label, label);
    }
    if (data.hasOwnProperty("value")) el.value = data.value;
    if (data.hasOwnProperty("min")) el.min = data.min;
    if (data.hasOwnProperty("max")) el.max = data.max;
    if (data.hasOwnProperty("step")) el.step = data.step;
    if (data.hasOwnProperty("left")) {
      $(el).prev(".sw-input-icon").replaceWith(data.left);
    }
    if (data.hasOwnProperty("right")) {
      $(el).next(".sw-input-icon").replaceWith(data.right);
    }
    $(el).trigger("change");
  },
  getState: function(el) {
    return {
      label: this._getLabelNode(el).text(),
      value: this.getValue(el),
      min: Number(el.min),
      max: Number(el.max),
      step: Number(el.step)
    };
  },
  _getLabelNode: function(el) {
    return $(el)
      .parent()
      .find('label[for="' + Shiny.$escape(el.id) + '"]');
  }
});
Shiny.inputBindings.register(
  numericInputIconBinding,
  "shinyWidgets.numericInputIcon"
);




// text icon input -----------------------------------------------------------------------

var textInputIconBinding = new Shiny.InputBinding();
$.extend(textInputIconBinding, {
  find: function find(scope) {
    return $(scope).find(".text-input-icon");
  },
  getValue: function getValue(el) {
    return el.value;
  },
  setValue: function setValue(el, value) {
    el.value = value;
  },
  subscribe: function subscribe(el, callback) {
    $(el).on("keyup.textInputIconBinding input.textInputIconBinding", function(
      event
    ) {
      callback(true);
    });
    $(el).on("change.textInputIconBinding", function(event) {
      callback(false);
    });
  },
  unsubscribe: function unsubscribe(el) {
    $(el).off(".textInputIconBinding");
  },
  receiveMessage: function receiveMessage(el, data) {
    if (data.hasOwnProperty("label")) {
      var label = $("#" + el.id + "-label");
      updateLabel(data.label, label);
    }
    if (data.hasOwnProperty("value")) this.setValue(el, data.value);
    if (data.hasOwnProperty("placeholder")) el.placeholder = data.placeholder;
    if (data.hasOwnProperty("left")) {
      $(el).prev(".sw-input-icon").replaceWith(data.left);
    }
    if (data.hasOwnProperty("right")) {
      $(el).next(".sw-input-icon").replaceWith(data.right);
    }
    $(el).trigger("change");
  },
  getState: function getState(el) {
    return {
      label: this._getLabelNode(el).text(),
      value: el.value,
      placeholder: el.placeholder
    };
  },
  getRatePolicy: function getRatePolicy() {
    return {
      policy: "debounce",
      delay: 250
    };
  },
  _getLabelNode: function _getLabelNode(el) {
    return $(el)
      .parent()
      .find('label[for="' + Shiny.$escape(el.id) + '"]');
  }
});
Shiny.inputBindings.register(textInputIconBinding, "shinyWidgets.textInputIcon");


