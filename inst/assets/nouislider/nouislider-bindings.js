/*jshint
  jquery:true
*/
/*global noUiSlider, wNumb, Shiny */

// noUiSlider bindings by VP //

var noUiSliderBinding = new Shiny.InputBinding();
$.extend(noUiSliderBinding, {
  find: function find(scope) {
    return $(scope).find(".sw-no-ui-slider");
  },
  getId: function getId(el) {
    return el.id;
  },
  getType: function getType(el) {
    var dataType = $(el).data("data-type");
    if (dataType === "date") return "shiny.date";
    else if (dataType === "datetime") return "shiny.datetime";
    else return false;
  },
  getValue: function getValue(el) {
    var slider = document.getElementById(el.id);
    var values = slider.noUiSlider.get();
    var result;

    var $el = $(el);
    var config = $el
      .parent()
      .find('script[data-for="' + Shiny.$escape(el.id) + '"]');
    config = JSON.parse(config.html());
    if (typeof config.format !== "undefined") {
      var numformat = wNumb(config.format);
      if (Array.isArray(values)) {
        result = values.map(numformat.from);
      } else {
        result = numformat.from(values);
      }
    } else {
      if (Array.isArray(values)) {
        result = values.map(Number);
      } else {
        result = Number(values);
      }
    }
    //var result = values.map(Number);
    return result;
  },
  setValue: function setValue(el, value) {
    var slider = document.getElementById(el.id);
    slider.noUiSlider.set(value);
  },
  subscribe: function subscribe(el, callback) {
    var slider = document.getElementById(el.id);
    var update_on = $("#" + el.id).data("update");
    if (update_on == "end") {
      slider.noUiSlider.on("change", function(event) {
        callback();
      });
      slider.noUiSlider.on("set", function(event) {
        callback();
      });
    } else {
      slider.noUiSlider.on("slide", function(event) {
        callback();
      });
      slider.noUiSlider.on("set", function(event) {
        callback();
      });
    }
  },
  unsubscribe: function unsubscribe(el) {
    $(el).off(".noUiSliderBinding");
  },
  receiveMessage: function receiveMessage(el, data) {
    var slider = document.getElementById(el.id);
    if (data.disable) {
      slider.setAttribute("disabled", true);
    } else {
      slider.removeAttribute("disabled");
    }
    if (data.hasOwnProperty("range")) {
      slider.noUiSlider.updateOptions({
        range: {
          min: data.range[0],
          max: data.range[1]
        }
      });
    }
    slider.noUiSlider.set(data.value);
    $(el).trigger("change");
  },
  getRatePolicy: function getRatePolicy() {
    return {
      policy: "debounce",
      delay: 250
    };
  },
  getState: function getState(el) {},
  initialize: function initialize(el) {
    var $el = $(el);
    var config = $el
      .parent()
      .find('script[data-for="' + Shiny.$escape(el.id) + '"]');
    config = JSON.parse(config.html());
    if (config.hasOwnProperty("format")) {
      config.format = wNumb(config.format);
    }
    if (config.hasOwnProperty("pips")) {
      if (config.pips.hasOwnProperty("format")) {
        config.pips.format = wNumb(config.pips.format);
      }
      if (config.pips.hasOwnProperty("size")) {
        config.pips.filter = function(value, type) {
          if (type > 0) {
            return config.pips.size;
          } else {
            return type;
          }
        };
      }
    }
    var slider = document.getElementById(el.id);
    if (config.orientation === "vertical") {
      slider.style.margin = "0 auto 30px";
    }
    noUiSlider.create(slider, config);
  }
});

Shiny.inputBindings.register(noUiSliderBinding, "shinyWidgets.noUiSlider");

