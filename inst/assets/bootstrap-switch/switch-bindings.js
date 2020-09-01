// Transform each tag with class 'sw-switchInput' to bootstrap switch
$(function() {
  $(".sw-switchInput").each(function() {
    $(this).bootstrapSwitch();
  });
});

// switch input binding
var switchInputBinding = new Shiny.InputBinding();
$.extend(switchInputBinding, {
  find: function(scope) {
    return $(scope).find(".sw-switchInput");
  },
  getId: function(el) {
    return el.id;
  },
  getValue: function(el) {
    return el.checked;
  },
  setValue: function(el, value) {
    el.checked = value;
  },
  subscribe: function(el, callback) {
    $(el).on("switchChange.bootstrapSwitch", function(event) {
      callback(false);
    });
  },
  unsubscribe: function(el) {
    $(el).off(".switchInputBinding");
  },
  getState: function(el) {
    return {
      //label: $(el).parent().find('span').text(),
      value: el.checked
    };
  },
  receiveMessage: function(el, data) {
    if (data.hasOwnProperty("value")) el.checked = data.value;

    if (data.hasOwnProperty("label"))
      $(el).bootstrapSwitch("labelText", data.label);

    if (data.hasOwnProperty("offLabel"))
      $(el).bootstrapSwitch("offText", data.offLabel);

    if (data.hasOwnProperty("onLabel"))
      $(el).bootstrapSwitch("onText", data.onLabel);

    if (data.hasOwnProperty("onStatus"))
      $(el).bootstrapSwitch("onColor", data.onStatus);

    if (data.hasOwnProperty("offStatus"))
      $(el).bootstrapSwitch("offColor", data.offStatus);

    if (data.hasOwnProperty("disabled"))
      $(el).bootstrapSwitch("disabled", data.disabled, data.disabled);

    $(el).trigger("change");
  },
  initialize: function initialize(el) {
    $(el).bootstrapSwitch();
  }
});

Shiny.inputBindings.register(switchInputBinding, "shinyWidgets.switchInput");

