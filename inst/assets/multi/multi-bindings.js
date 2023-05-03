// multi input binding

var multiInputBinding = new Shiny.InputBinding();
$.extend(multiInputBinding, {
  initialize: function initialize(el) {
    var config = $(el)
      .parent()
      .find('script[data-for="' + Shiny.$escape(el.id) + '"]');
    config = JSON.parse(config.html());
    $(el).multi(config);
    $(el).trigger("change");
  },
  find: function(scope) {
    return $(scope).find(".multijs");
  },
  getId: function(el) {
    return el.id;
  },
  getValue: function(el) {
    return $(el).val();
  },
  setValue: function setValue(el, value) {
    $(el).val(value);
    $(el).multi();
    $(el).trigger("change");
  },
  getState: function(el) {
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
  receiveMessage: function(el, data) {
    var $el = $(el);

    // This will replace all the options
    if (data.hasOwnProperty("options")) {
      // Clear existing options and add each new one
      $el.empty().append(data.options);
      //$(el).trigger( 'change' );
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

    var event = new Event("change");

    //$(el.id).trigger( 'change' );
    $(el).multi();
    $el.get(0).dispatchEvent(event);
    $el.trigger("change");

    // $(el).siblings(".multi-wrapper").find(".search-input").get(0).dispatchEvent(event); //
  },
  subscribe: function(el, callback) {
    $(el).on("change", function(event) {
      callback();
    });
  },
  unsubscribe: function(el) {
    $(el).off(".multiInputBinding");
  }
});
Shiny.inputBindings.register(multiInputBinding, "shinyWidgets.multiInput");

