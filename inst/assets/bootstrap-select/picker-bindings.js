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
    var callback = $(el).data("callback");
    var shinyInputBinding = $(el).data("shinyInputBinding");
    $(el).selectpicker("destroy");
    $(el).val(value);
    $(el).data("callback", callback);
    $(el).data("shinyInputBinding", shinyInputBinding);
    this.initialize(el);
    $(el).on("changed.bs.select.pickerInput", function(event) {
      callback();
    });
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
    var callback = $(el).data("callback");
    var shinyInputBinding = $(el).data("shinyInputBinding");

    if (data.hasOwnProperty("options")) {
      $(el).selectpicker("destroy");
      if (data.clearOptions) {
        $(el).removeData();
        $(el).data("callback", callback);
        $(el).data("shinyInputBinding", shinyInputBinding);
      }
      $(el).data(data.options);
      this.initialize(el);
      $(el).on("changed.bs.select.pickerInput", function(event) {
        callback();
      });
    }

    // This will replace all the choices
    if (data.hasOwnProperty("choices")) {
      $(el).selectpicker("destroy");
      $el.empty().append(data.choices);
      $(el).data("callback", callback);
      $(el).data("shinyInputBinding", shinyInputBinding);
      this.initialize(el);
      $(el).on("changed.bs.select.pickerInput", function(event) {
        callback();
      });
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

    //$(el).selectpicker("refresh");
    $(el).trigger("change");
  },
  subscribe: function subscribe(el, callback) {
    $(el).data("callback", callback);
    $(el).on("changed.bs.select.pickerInput", function(event) {
      callback();
    });
  },
  unsubscribe: function unsubscribe(el) {
    $(el).off(".pickerInput");
  },
  initialize: function initialize(el) {
    $(el).selectpicker();
    $(el).on("shown.bs.select", function(e) {
      Shiny.setInputValue(el.id + "_open", true);
    });
    $(el).on("hidden.bs.select", function(e) {
      Shiny.setInputValue(el.id + "_open", false);
    });
    // TEMPORARY FIX FOR SHINY V1.6.0
    $(document).off("focusout.dropdown.data-api");
  }
});
Shiny.inputBindings.register(pickerInputBinding, "shinyWidgets.pickerInput");

