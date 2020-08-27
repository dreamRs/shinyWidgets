// ------------------------------------------------------------------------ //
//
// Descriptif : Radio Group Buttons : javascript bindings
//     Detail : http://getbootstrap.com/javascript/#buttons-checkbox-radio
//
//
// Auteur : Victor PERRIER
//
// Date creation : 01/07/2016
// Date modification : 01/07/2016
//
// Version 1.0
//
// ------------------------------------------------------------------------ //

// radioGroupButtons input binding
var radioGroupButtonsBinding = new Shiny.InputBinding();
$.extend(radioGroupButtonsBinding, {
  find: function(scope) {
    return $(scope).find(".radioGroupButtons");
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
    var $el = $(el);

    // This will replace all the options
    if (data.hasOwnProperty("options")) {
      $el.find("div.btn-group-container-sw").empty();
      $el.find("div.btn-group-container-sw").append(data.options);
    }

    if (data.hasOwnProperty("selected")) {
      this.setValue(el, data.selected);
    }

    if (data.hasOwnProperty("label"))
      $(el)
        .parent()
        .find('label[for="' + Shiny.$escape(el.id) + '"]')
        .text(data.label);

    if (data.disabled) {
      $el.find("button").attr("disabled", "disabled");
      $el.find("button").addClass("disabled");
    } else {
      $el.find("button").removeAttr("disabled");
      $el.find("button").removeClass("disabled");
    }
    if (data.hasOwnProperty("disabledChoices")) {
      for (var i = 0; i < data.disabledChoices.length; i++) {
        $(
          'input:radio[name="' +
            Shiny.$escape(el.id) +
            '"][value="' +
            Shiny.$escape(data.disabledChoices[i]) +
            '"]'
        )
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

