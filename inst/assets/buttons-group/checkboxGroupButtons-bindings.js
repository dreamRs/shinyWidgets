// ------------------------------------------------------------------------ //
//
// Descriptif : Checkbox Group Buttons : javascript bindings
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

// Prevent focus on button after click
document.addEventListener("click", function(e) {
  if (
    (document.activeElement.toString() == "[object HTMLButtonElement]") &
    document.activeElement.classList.contains("checkbtn")
  ) {
    document.activeElement.blur();
  }
});

// checkboxGroupButtons input binding
var checkboxGroupButtonsBinding = new Shiny.InputBinding();
$.extend(checkboxGroupButtonsBinding, {
  find: function(scope) {
    return $(scope).find(".checkboxGroupButtons");
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
    var $el = $(el);

    // This will replace all the options
    if (data.hasOwnProperty("options")) {
      $el.find("div.btn-group-container-sw").empty();
      $el.find("div.btn-group-container-sw").append(data.options);
    }

    if (data.hasOwnProperty("selected")) this.setValue(el, data.selected);

    if (data.hasOwnProperty("label"))
      $el.find('label[for="' + Shiny.$escape(el.id) + '"]').text(data.label);

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
          'input:checkbox[name="' +
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
  checkboxGroupButtonsBinding,
  "shiny.checkboxGroupButtonsInput"
);

