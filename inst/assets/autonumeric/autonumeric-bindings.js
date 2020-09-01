/*jshint
  jquery:true
*/
/*global AutoNumeric, Shiny */

// Autonumeric Input Binding
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
    if (config.hasOwnProperty("format")) {
      this[el.id] = new AutoNumeric(el, config.format);
    } else {
      this[el.id] = new AutoNumeric(el, config.options);
    }
  },

  getValue: function(el) {
    return this[el.id].getNumber();
  },

  subscribe: function(el, callback) {
    $(el).on("change.autonumericInputBinding keyup.autonumericInputBinding input.autonumericInputBinding", function(event) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".autonumericInputBinding");
  },

  receiveMessage: function(el, data) {
    if (data.hasOwnProperty("value")) {
      this[el.id].set(data.value);
    }

    if (data.hasOwnProperty("format")) {
      this[el.id].update(data.format);
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
    return{
      label: $(el)
        .parent()
        .parent()
        .find('label[for="' + Shiny.$escape(el.id) + '"]')
        .text(),
      value: this[el.id].getNumber(),
      options: this[el.id].getSettings()
    };
  },

  getRatePolicy: function() {
    return {
      policy: "debounce",
      delay: 500
    };
  }
});

Shiny.inputBindings.register(autonumericInputBinding, "shinyWidgets.autonumericInput");

