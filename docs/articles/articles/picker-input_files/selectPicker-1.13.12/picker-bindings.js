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
    $(el.id).selectpicker("refresh");
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
      //this.picker.selectpicker('destroy');
      $(el).attr(data.options);
      this.picker.selectpicker("render");
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

    //$(el).selectpicker('refresh');
    $(el).trigger("change");
  },
  subscribe: function subscribe(el, callback) {
    $(el).on("changed.bs.select", function(event) {
      //$(el).selectpicker('refresh');
      callback();
    });
  },
  unsubscribe: function unsubscribe(el) {
    $(el).off(".pickerInputBinding");
  },
  initialize: function initialize(el) {
    this.picker = $(el).selectpicker();
  }
});
Shiny.inputBindings.register(pickerInputBinding, "shiny.pickerInput");

