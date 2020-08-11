// spectrumInput bindings //
// by VP 4 dreamRs //

var spectrumInputBinding = new Shiny.InputBinding();
$.extend(spectrumInputBinding, {
  find: function(scope) {
    return $(scope).find(".sw-spectrum");
  },
  getId: function(el) {
    return $(el).attr("id");
  },
  getValue: function(el) {
    //return el.value;
    return $(el)
      .spectrum("get")
      .toHexString();
  },
  setValue: function(el, value) {
    $(el).spectrum("set", value);
  },
  subscribe: function(el, callback) {
    //$(el).on('move.spectrum dragstop.spectrum', function(event) {
    //  callback();
    //});
    $(el).on("change", function(event) {
      callback();
    });
  },
  unsubscribe: function(el) {
    $(el).off(".spectrumInputBinding");
  },
  receiveMessage: function(el, data) {
    if (data.hasOwnProperty("value")) this.setValue(el, data.value);

    //if (data.hasOwnProperty('label'))
    //$(el).parent().find('label[for=' + el.id + ']').text(data.label);

    $(el).trigger("change");
  },
  getState: function(el) {
    return {
      //label: $(el).parent().find('label[for=' + el.id + ']').text(),
      value: this.getValue(el) //el.value
    };
  },
  initialize: function initialize(el) {
    var opts = {};
    var update_on = $(el).attr("data-update-on");
    $(el).removeAttr("data-update-on");
    if (update_on == "dragstop") {
      $(el).on("dragstop.spectrum", function(event) {
        $(el).trigger("change");
      });
    }
    if (update_on == "move") {
      opts.move = function() {
        $(el).trigger("change");
      };
    }
    if (update_on == "change") {
      opts.change = function() {
        $(el).trigger("change");
      };
    }
    $(el).spectrum(opts);
  },
  getRatePolicy: function getRatePolicy() {
    return {
      policy: "debounce",
      delay: 250
    };
  }
});
Shiny.inputBindings.register(spectrumInputBinding, "shinyWidgets.spectrumInput");

