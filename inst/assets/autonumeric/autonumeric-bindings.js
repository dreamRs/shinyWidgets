
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
    console.log(this[el.id].getNumber());
    return this[el.id].getNumber();
  },

  subscribe: function(el, callback) {
    $(el).on("change", function(event) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".currencyInputBinding");
  },

  receiveMessage: function(el, data) {

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

