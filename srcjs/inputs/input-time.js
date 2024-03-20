import $ from "jquery";
import "shiny";
import { updateLabel } from "../modules/utils";

var timeInputBinding = new Shiny.InputBinding();
$.extend(timeInputBinding, {
  find: function find(scope) {
    return $(scope).find(".sw-time-input");
  },
  getValue: function getValue(el) {
    return el.value;
  },
  setValue: function setValue(el, value) {
    el.value = value;
  },
  subscribe: function subscribe(el, callback) {
    $(el).on("change.timeInputBinding", function(event) {
      callback();
    });
  },
  unsubscribe: function unsubscribe(el) {
    $(el).off(".timeInputBinding");
  },
  receiveMessage: function receiveMessage(el, data) {
    if (data.hasOwnProperty("label")) {
      var label = $("#" + el.id + "-label");
      updateLabel(data.label, label);
    }
    if (data.hasOwnProperty("value")) this.setValue(el, data.value);
    if (data.hasOwnProperty("min")) el.min = data.min;
    if (data.hasOwnProperty("max")) el.max = data.max;
    if (data.hasOwnProperty("step")) el.step = data.step;
    $(el).trigger("change");
  },
  getState: function getState(el) {
    return {
      label: this._getLabelNode(el).text(),
      value: el.value,
      placeholder: el.placeholder
    };
  },
  getRatePolicy: function getRatePolicy() {
    return {
      policy: "debounce",
      delay: 250
    };
  },
  _getLabelNode: function _getLabelNode(el) {
    return $(el)
      .parent()
      .find('label[for="' + Shiny.$escape(el.id) + '"]');
  }
});
Shiny.inputBindings.register(timeInputBinding, "shinyWidgets.timeInput");
