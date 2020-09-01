/*jshint
  jquery:true,
  browser:true,
  devel: true
*/

function forceIonSliderTextUpdate(slider) {
  if (slider.$cache && slider.$cache.input)
    slider.$cache.input.trigger("change");
  else console.log("Couldn't force ion slider to update");
}

var sliderTextBinding = new Shiny.InputBinding();
$.extend(sliderTextBinding, {
  find: function find(scope) {
    // Check if ionRangeSlider plugin is loaded
    if (!$.fn.ionRangeSlider) return [];

    return $(scope).find(".sw-slider-text");
  },
  getType: function getType(el) {
    var dataType = $(el).data("data-type");
    if (dataType === "date") return "shiny.date";
    else if (dataType === "datetime") return "shiny.datetime";
    else return false;
  },
  getValue: function getValue(el) {
    var slider = $(el).data("ionRangeSlider");
    var result = slider.result;
    var options = slider.options;

    ////var values = $(el).data("values").split(",");
    //var values = $(el).data("swvalues");
    var values = options.values;

    if (this._numValues(el) === 2) {
      return [values[result.from], values[result.to]];
    } else {
      return values[result.from];
    }
  },
  setValue: function setValue(el, value) {
    var $el = $(el);
    var slider = $el.data("ionRangeSlider");

    $el.data("immediate", true);
    try {
      if (this._numValues(el) === 2 && value instanceof Array) {
        slider.update({ from: value[0], to: value[1] });
      } else {
        slider.update({ from: value });
      }

      forceIonSliderTextUpdate(slider);
    } finally {
      $el.data("immediate", false);
    }
  },
  subscribe: function subscribe(el, callback) {
    $(el).on("change.sliderInputBinding", function(event) {
      callback(!$(el).data("immediate") && !$(el).data("animating"));
    });
  },
  unsubscribe: function unsubscribe(el) {
    $(el).off(".sliderInputBinding");
  },
  receiveMessage: function receiveMessage(el, data) {
    var $el = $(el);
    var slider = $el.data("ionRangeSlider");
    var options = slider.options;
    var msg = {};

    ////var values = $(el).data("values").split(",");
    //var values = $(el).data("swvalues");
    var values = options.values;

    if (data.hasOwnProperty("choices")) {
      msg.values = data.choices;
      values = data.choices;
    }

    if (data.hasOwnProperty("selected")) {
      if (this._numValues(el) === 2 && data.selected instanceof Array) {
        msg.from = values.indexOf(data.selected[0]);
        msg.to = values.indexOf(data.selected[1]);
      } else {
        msg.from = values.indexOf(data.selected);
      }
    }

    if (data.hasOwnProperty("from_fixed")) msg.from_fixed = data.from_fixed;
    if (data.hasOwnProperty("to_fixed")) msg.to_fixed = data.to_fixed;

    if (data.hasOwnProperty("label"))
      $el
        .parent()
        .find('label[for="' + Shiny.$escape(el.id) + '"]')
        .text(data.label);

    $el.data("immediate", true);
    try {
      slider.update(msg);
      forceIonSliderTextUpdate(slider);
    } finally {
      $el.data("immediate", false);
    }
  },
  getRatePolicy: function getRatePolicy() {
    return {
      policy: "debounce",
      delay: 250
    };
  },
  getState: function getState(el) {},
  initialize: function initialize(el) {
    var opts = {};
    var $el = $(el);

    var values = $(el).data("swvalues");
    //console.log(values);
    opts.values = values;

    $el.ionRangeSlider(opts);
  },

  // Number of values; 1 for single slider, 2 for range slider
  _numValues: function _numValues(el) {
    if ($(el).data("ionRangeSlider").options.type === "double") return 2;
    else return 1;
  }
});

Shiny.inputBindings.register(sliderTextBinding, "shiny.sliderText");

