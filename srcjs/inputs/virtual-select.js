import $ from "jquery";
import "shiny";
import "virtual-select-plugin/dist/virtual-select.min.css";
import "virtual-select-plugin/dist/virtual-select.min.js";

function transpose(data) {
  var res = [];
  var key, i;
  for (key in data) {
    for (i = 0; i < data[key].length; i++) {
      res[i] = res[i] || {};
      if (data[key][i] !== undefined) res[i][key] = data[key][i];
    }
  }
  return res;
}

function makeOptions(options) {
  var newOptions;
  if (options.type == "vector") {
    newOptions = options.choices.map(x => {
      return { label: x, value: x };
    });
  } else if (options.type == "transpose") {
    newOptions = transpose(options.choices);
  } else if (options.type == "transpose_group") {
    var choices = options.choices;
    for (var i = 0; i < choices.length; i++) {
      choices[i].options = transpose(choices[i].options);
    }
    newOptions = choices;
  } else {
    newOptions = options.choices;
  }
  return newOptions;
}

var virtualSelectBinding = new Shiny.InputBinding();

$.extend(virtualSelectBinding, {
  find: scope => {
    return $(scope).find(".virtual-select");
  },
  getValue: el => {
    return el.value;
  },
  setValue: (el, value) => {
    el.setValue(value);
  },
  subscribe: (el, callback) => {
    $(el).on("change.virtualSelectBinding", function(e) {
      callback();
    });
  },
  unsubscribe: el => {
    $(el).off(".virtualSelectBinding");
  },
  receiveMessage: (el, data) => {
    if (data.hasOwnProperty("label")) {
      var label = document.getElementById(el.id + "-label");
      label.innerHTML = data.label;
    }

    if (data.hasOwnProperty("options")) {
      var newOptions = makeOptions(data.options);
      el.setOptions(newOptions);
    }

    if (data.hasOwnProperty("value")) {
      el.setValue(data.value);
    }

    if (data.hasOwnProperty("disable")) {
      if (data.disable) {
        el.disable();
      } else {
        el.enable();
      }
    }

    if (data.hasOwnProperty("disabledChoices")) {
      el.setDisabledOptions(data.disabledChoices, true);
    }
  },
  initialize: el => {
    var data = el.querySelector('script[data-for="' + el.id + '"]');
    data = JSON.parse(data.text);
    var config = data.config;
    config.options = makeOptions(data.options);
    config.ele = el;
    VirtualSelect.init(config);
    if (data.stateInput) {
      $(el).on("afterOpen", function(e) {
        Shiny.setInputValue(el.id + "_open", true);
      });
      $(el).on("afterClose", function(e) {
        Shiny.setInputValue(el.id + "_open", false);
      });
    }
  }
});

Shiny.inputBindings.register(
  virtualSelectBinding,
  "shinyWidgets.virtualSelectBinding"
);

