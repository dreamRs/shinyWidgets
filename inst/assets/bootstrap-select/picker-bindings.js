// picker input binding
var pickerInputBinding = new Shiny.InputBinding();
$.extend(pickerInputBinding, {
  find: function find(scope) {
    return $(scope).find(".selectpicker");
  },
  getId: function getId(el) {
    return el.id;
  },
  getValue: function getValue(el) {
    return $(el).val();
  },
  setValue: function setValue(el, value) {
    $(el).val(value);
    $(el).selectpicker("refresh");
  },
  getState: function getState(el) {
    // Store options in an array of objects, each with with value and label
    var options = new Array(el.length);
    for (var i = 0; i < el.length; i++) {
      options[i] = { value: el[i].value, label: el[i].label };
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

    if (data.hasOwnProperty("options")) {
      $(el).selectpicker("destroy");
      $(el).data(data.options);
      $(el).selectpicker();
      var callback = this["callback" + el.id];
      $(el).on("changed.bs.select.pickerInput", function(event) {
        callback();
      });
    }

    // This will replace all the choices
    if (data.hasOwnProperty("choices")) {
      // Clear existing choices and add each new one
      $el.empty().append(data.choices);
      $(el).selectpicker("refresh");
    }

    if (data.hasOwnProperty("value")) {
      this.setValue(el, data.value);
    }

    if (data.hasOwnProperty("label"))
      $(el)
        .parent()
        .parent()
        .find('label[for="' + Shiny.$escape(el.id) + '"]')
        .text(data.label);

    $(el).selectpicker("refresh");
    $(el).trigger("change");
  },
  subscribe: function subscribe(el, callback) {
    this["callback" + el.id] = callback;
    $(el).on("changed.bs.select.pickerInput", function(event) {
      callback();
    });
  },
  unsubscribe: function unsubscribe(el) {
    $(el).off(".pickerInput");
  },
  initialize: function initialize(el) {
    $(el).selectpicker();
    // TEMPORARY FIX FOR SHINY V1.6.0
    $(document).off("focusout.dropdown.data-api");
  }
});
Shiny.inputBindings.register(pickerInputBinding, "shinyWidgets.pickerInput");

