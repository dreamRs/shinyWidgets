import $ from "jquery";
import "shiny";
import { updateLabel } from "../modules/utils";

import "../css/checkboxGroupButtons.css";
import "../css/radioGroupButtons.css";



// checkboxGroupButtons input binding ----------------------------------------------------

var checkboxGroupButtonsBinding = new Shiny.InputBinding();
$.extend(checkboxGroupButtonsBinding, {
  find: function(scope) {
    return $(scope).find(".checkbox-group-buttons");
  },
  getId: function(el) {
    return el.id;
  },
  getValue: function(el) {
    // Select the checkbox objects that have name equal to the grouping div's id
    var $objs = $(
      'input:checkbox[name="' + Shiny.$escape(el.id) + '"]:checked'
    );
    var values = new Array($objs.length);
    for (var i = 0; i < $objs.length; i++) {
      values[i] = $objs[i].value;
    }
    return values;
  },
  setValue: function(el, value) {
    $('input:checkbox[name="' + Shiny.$escape(el.id) + '"]').prop(
      "checked",
      false
    );
    $('input:checkbox[name="' + Shiny.$escape(el.id) + '"]')
      .parent()
      .removeClass("active");
    $('input:checkbox[name="' + Shiny.$escape(el.id) + '"]')
      .parent()
      .blur();
    // Accept array
    if (value instanceof Array) {
      for (var i = 0; i < value.length; i++) {
        $(
          'input:checkbox[name="' +
            Shiny.$escape(el.id) +
            '"][value="' +
            Shiny.$escape(value[i]) +
            '"]'
        )
          .parent()
          .addClass("active");
        $(
          'input:checkbox[name="' +
            Shiny.$escape(el.id) +
            '"][value="' +
            Shiny.$escape(value[i]) +
            '"]'
        ).prop("checked", true);
      }
      // Else assume it's a single value
    } else {
      $(
        'input:checkbox[name="' +
          Shiny.$escape(el.id) +
          '"][value="' +
          Shiny.$escape(value) +
          '"]'
      )
        .parent()
        .addClass("active");
      $(
        'input:checkbox[name="' +
          Shiny.$escape(el.id) +
          '"][value="' +
          Shiny.$escape(value) +
          '"]'
      ).prop("checked", true);
    }
  },
  subscribe: function(el, callback) {
    $(el).on("change.checkboxGroupButtonsBinding", function(event) {
      callback();
    });
  },
  unsubscribe: function(el) {
    $(el).off(".checkboxGroupButtonsBinding");
  },
  getState: function getState(el) {
    var $objs = $('input:checkbox[name="' + Shiny.$escape(el.id) + '"]');

    // Store options in an array of objects, each with with value and label
    var options = new Array($objs.length);
    for (var i = 0; i < options.length; i++) {
      options[i] = { value: $objs[i].value };
    }

    return { value: this.getValue(el), options: options };
  },
  receiveMessage: function receiveMessage(el, data) {

    if (data.hasOwnProperty("label")) {
      var label = $("#" + el.id + "-label");
      updateLabel(data.label, label);
    }

    var $el = $(el);

    // This will replace all the options
    if (data.hasOwnProperty("options")) {
      $el.find("div.btn-group-container-sw").empty();
      $el.find("div.btn-group-container-sw").append(data.options);
    }

    if (data.hasOwnProperty("selected")) this.setValue(el, data.selected);

    if (data.disabled) {
      // bs3
      $el.find("button").attr("disabled", "disabled");
      $el.find("button").addClass("disabled");
      // bs5
      $el.find("label").addClass("disabled");
    } else {
      // bs3
      $el.find("button").removeAttr("disabled");
      $el.find("button").removeClass("disabled");
      // bs5
      $el.find("label").removeClass("disabled");
    }
    if (data.hasOwnProperty("disabledChoices")) {
      for (var i = 0; i < data.disabledChoices.length; i++) {
        var toDisable = $(
          'input:checkbox[name="' +
            Shiny.$escape(el.id) +
            '"][value="' +
            Shiny.$escape(data.disabledChoices[i]) +
            '"]'
        );
        // bs5
        toDisable.next("label").addClass("disabled");
        // bs3
        toDisable
          .parent()
          .attr("disabled", "disabled")
          .addClass("disabled");
      }
    }

    $(el).trigger("change");
  }
});

Shiny.inputBindings.register(
  checkboxGroupButtonsBinding,
  "shinyWidgets.checkboxGroupButtonsInput"
);








// radioGroupButtons input binding -------------------------------------------------------

var radioGroupButtonsBinding = new Shiny.InputBinding();
$.extend(radioGroupButtonsBinding, {
  find: function(scope) {
    return $(scope).find(".radio-group-buttons");
  },
  getId: function(el) {
    return el.id;
  },
  getValue: function(el) {
    var value = $(
      'input:radio[name="' + Shiny.$escape(el.id) + '"]:checked'
    ).val();
    return typeof value == "undefined" ? null : value;
  },
  setValue: function(el, value) {
    $('input:radio[name="' + Shiny.$escape(el.id) + '"]')
      .parent()
      .removeClass("active");
    $('input:radio[name="' + Shiny.$escape(el.id) + '"]').prop(
      "checked",
      false
    );
    if (value.length > 0) {
      $(
        'input:radio[name="' +
          Shiny.$escape(el.id) +
          '"][value="' +
          Shiny.$escape(value) +
          '"]'
      ).prop("checked", true);
      $(
        'input:radio[name="' +
          Shiny.$escape(el.id) +
          '"][value="' +
          Shiny.$escape(value) +
          '"]'
      )
        .parent()
        .addClass("active");
    }
  },
  subscribe: function(el, callback) {
    $(el).on("change.radioGroupButtonsBinding", function(event) {
      callback();
    });
  },
  unsubscribe: function(el) {
    $(el).off(".radioGroupButtonsBinding");
  },
  getState: function getState(el) {
    var $objs = $('input:radio[name="' + Shiny.$escape(el.id) + '"]');

    // Store options in an array of objects, each with with value and label
    var options = new Array($objs.length);
    for (var i = 0; i < options.length; i++) {
      options[i] = { value: $objs[i].value, label: this._getLabel($objs[i]) };
    }

    return {
      label: $(el)
        .parent()
        .find('label[for="' + Shiny.$escape(el.id) + '"]')
        .text(),
      value: this.getValue(el),
      options: options
    };
  },
  receiveMessage: function receiveMessage(el, data) {

    if (data.hasOwnProperty("label")) {
      var label = $("#" + el.id + "-label");
      updateLabel(data.label, label);
    }

    var $el = $(el);

    // This will replace all the options
    if (data.hasOwnProperty("options")) {
      $el.find("div.btn-group-container-sw").empty();
      $el.find("div.btn-group-container-sw").append(data.options);
    }

    if (data.hasOwnProperty("selected")) {
      this.setValue(el, data.selected);
    }

    if (data.disabled) {
      // bs3
      $el.find("button").attr("disabled", "disabled");
      $el.find("button").addClass("disabled");
      // bs5
      $el.find("label").addClass("disabled");
    } else {
      // bs3
      $el.find("button").removeAttr("disabled");
      $el.find("button").removeClass("disabled");
      // bs5
      $el.find("label").removeClass("disabled");
    }
    if (data.hasOwnProperty("disabledChoices")) {
      for (var i = 0; i < data.disabledChoices.length; i++) {
        var toDisable = $(
          'input:radio[name="' +
            Shiny.$escape(el.id) +
            '"][value="' +
            Shiny.$escape(data.disabledChoices[i]) +
            '"]'
        );
        // bs5
        toDisable
          .next("label")
          .addClass("disabled");
        // bs3
        toDisable
          .parent()
          .attr("disabled", "disabled")
          .addClass("disabled");
      }
    }

    $(el).trigger("change");
  }
});

Shiny.inputBindings.register(
  radioGroupButtonsBinding,
  "shinyWidgets.radioGroupButtonsInput"
);


