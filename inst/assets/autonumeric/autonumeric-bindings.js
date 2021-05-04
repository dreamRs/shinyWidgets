/*jshint
  jquery:true
*/
/*global AutoNumeric, Shiny */

// Autonumeric Input Binding
Shiny.InputBinding.prototype.store = [];
Shiny.InputBinding.prototype.updateStore = function(el, instance) {
  this.store[el.id] = instance;
};
var autonumericInputBinding = new Shiny.InputBinding();
$.extend(autonumericInputBinding, {

  find: function(scope) {
    return $(scope).find(".autonumeric-input");
  },

  initialize: function(el) {
    var autonum, emptyInputBehavior;
    var config = $(el)
      .parent()
      .find('script[data-for="' + el.id + '"]');
    config = JSON.parse(config.html());
    if (config.hasOwnProperty("format")) {
      autonum = new AutoNumeric(el, config.format);
      emptyInputBehavior = config.format.emptyInputBehavior;
    } else {
      autonum = new AutoNumeric(el, config.options);
      emptyInputBehavior = config.options.emptyInputBehavior;
    }
    if ($(el).val() === "" & emptyInputBehavior === "null") {
      autonum.set(null);
    }
    this.updateStore(el, autonum);
  },

  getValue: function(el) {
    var autonum = this.getAutonumeric(el);
    return autonum.getNumber();
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
    var autonum = this.getAutonumeric(el);
    if (data.hasOwnProperty("value")) {
      autonum.set(data.value);
    }

    if (data.hasOwnProperty("format")) {
      autonum.update(data.format);
    }

    if (data.hasOwnProperty("options")) {
      autonum.update(data.options);
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
    var autonum = this.getAutonumeric(el);
    return{
      label: $(el)
        .parent()
        .parent()
        .find('label[for="' + Shiny.$escape(el.id) + '"]')
        .text(),
      value: autonum.getNumber(),
      options: autonum.getSettings()
    };
  },

  getRatePolicy: function() {
    return {
      policy: "debounce",
      delay: 500
    };
  },
  getAutonumeric: function(el) {
    return this.store[el.id];
  }
});

Shiny.inputBindings.register(autonumericInputBinding, "shinyWidgets.autonumericInput");

