import $ from "jquery";
import "shiny";
import { updateLabel } from "../modules/utils";
import SlimSelect from "slim-select";
import "slim-select/styles";

var slimSelectBinding = new Shiny.InputBinding();
$.extend(slimSelectBinding, {
  store: [],
  updateStore: (el, instance) => {
    slimSelectBinding.store[el.id] = instance;
  },
  find: scope => {
    return $(scope).find(".slim-select");
  },
  getValue: el => {
    var select = slimSelectBinding.store[el.id];
    return select.getSelected();
  },
  setValue: (el, value) => {
    el.setValue(value);
  },
  subscribe: (el, callback) => {
    $(el).on("change.slimSelectBinding", function(e) {
      callback();
    });
  },
  unsubscribe: el => {
    $(el).off(".slimSelectBinding");
  },
  receiveMessage: (el, data) => {
    if (data.hasOwnProperty("label")) {
      var label = $("#" + el.id + "-label");
      updateLabel(data.label, label);
    }

  },
  initialize: el => {
    var config = el.querySelector('script[data-for="' + el.id + '"]');
    config = JSON.parse(config.text);
    config.select = el;
    var select = new SlimSelect(config);
    slimSelectBinding.updateStore(el, select);
    if (config.hasOwnProperty("selected")) {
      select.setSelected(config.selected);
    }
  }
});

Shiny.inputBindings.register(
  slimSelectBinding,
  "shinyWidgets.slimSelectBinding"
);

