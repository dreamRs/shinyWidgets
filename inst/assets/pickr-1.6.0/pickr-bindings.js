// colorPickr bindings //

/*jshint
  jquery:true
*/
/*global Shiny,Pickr */
Shiny.InputBinding.prototype.store = [];
Shiny.InputBinding.prototype.updateStore = function(el, instance) {
  this.store[el.id] = instance;
};
var pickrColorBinding = new Shiny.InputBinding();
$.extend(pickrColorBinding, {
  find: function(scope) {
    return $(scope).find(".pickr-color");
  },
  getId: function(el) {
    return $(el).attr("id");
  },
  getValue: function(el) {
    var pickr = this.getPickr(el);
    return pickr
      .getColor()
      .toHEXA()
      .toString(0);
  },
  setValue: function(el, value) {
    this.getPickr(el).setColor(value);
  },
  subscribe: function(el, callback) {
    var pickr = this.getPickr(el);
    pickr.on("init", function(color, instance) {
      callback();
    });
    var event = this.getUpdate(el);
    var hideOnSave = this.getHideOnSave(el);
    if (event == "change") {
      pickr.on(event, function(color, source, instance) {
        callback();
      });
    } else {
      pickr.on(event, function(color, instance) {
        if ((hideOnSave === true) & (event != "changestop")) {
          instance.hide();
        }
        callback();
      });
      if (event == "changestop") {
        pickr.on("swatchselect", function(color, instance) {
          callback();
        });
      }
    }
  },
  unsubscribe: function(el) {
    //$(el).off(".pickrColorBinding");
  },
  receiveMessage: function(el, data) {
    var pickr = this.getPickr(el);
    if (data.hasOwnProperty("value")) {
      pickr.setColor(data.value);
    }
    if (data.hasOwnProperty("action")) {
      if (data.action == "enable") {
        pickr.enable();
      }
      if (data.action == "disable") {
        pickr.disable();
      }
      if (data.action == "show") {
        pickr.show();
      }
      if (data.action == "hide") {
        pickr.hide();
      }
    }
  },
  getState: function(el) {},
  initialize: function initialize(el) {
    var config = $(el)
      .parent()
      .find('script[data-for="' + el.id + '"]');
    config = JSON.parse(config.html());
    var options = config.options;

    options.el = el;
    el.value = options.default;
    options.appClass = "pickr-color";
    var pickr = new Pickr(options);
    pickr.setColor(options.default);
    var root = pickr.getRoot();
    if (config.hasOwnProperty("width")) {
      root.app.style.width = config.width;
    }
    if (options.useAsButton === false) {
      root.button.parentNode.style.display = "inline";
      root.button.id = el.id;
      root.button.classList.add("pickr-color");
      if (config.inline) {
        root.button.style.display = "none";
      }
    } else {
      el.style.backgroundColor = options.default;
      el.style.color = getCorrectTextColor(options.default);
      if (config.update == "changestop") {
        pickr.on(config.update, function(source, instance) {
          var color = instance.getColor();
          el.value = color.toHEXA().toString(0);
          el.style.backgroundColor = color.toHEXA().toString(0);
          el.style.color = getCorrectTextColor(color.toHEXA().toString(0));
        });
      } else {
        pickr.on(config.update, function(color) {
          el.value = color.toHEXA().toString(0);
          el.style.backgroundColor = color.toHEXA().toString(0);
          el.style.color = getCorrectTextColor(color.toHEXA().toString(0));
        });
      }
    }
    pickr.options.color = options.default;
    pickr.options.inline = config.inline;
    pickr.options.update = config.update;
    pickr.options.hideOnSave = config.hideOnSave;
    this.updateStore(el, pickr);
  },
  getPickr: function getPickr(el) {
    return this.store[el.id];
  },
  getUpdate: function getUpdate(el) {
    return this.store[el.id].options.update;
  },
  getHideOnSave: function getHideOnSave(el) {
    return this.store[el.id].options.hideOnSave;
  },
  getColor: function getHideOnSave(el) {
    return this.store[el.id].options.color;
  },
  isInline: function getHideOnSave(el) {
    return this.store[el.id].options.inline;
  }
});
Shiny.inputBindings.register(pickrColorBinding, "shinyWidgets.colorPickr");

// By David Halford : https://codepen.io/davidhalford/pen/ywEva
function getCorrectTextColor(hex) {
  var threshold = 130;

  function hexToR(h) {
    return parseInt(cutHex(h).substring(0, 2), 16);
  }
  function hexToG(h) {
    return parseInt(cutHex(h).substring(2, 4), 16);
  }
  function hexToB(h) {
    return parseInt(cutHex(h).substring(4, 6), 16);
  }
  function cutHex(h) {
    return h.charAt(0) == "#" ? h.substring(1, 7) : h;
  }

  var hRed = hexToR(hex);
  var hGreen = hexToG(hex);
  var hBlue = hexToB(hex);

  var cBrightness = (hRed * 299 + hGreen * 587 + hBlue * 114) / 1000;
  if (cBrightness > threshold) {
    return "#000000";
  } else {
    return "#ffffff";
  }
}

