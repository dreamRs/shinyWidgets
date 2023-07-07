import { easepick, RangePlugin, AmpPlugin, LockPlugin, PresetPlugin } from '@easepick/bundle';
window.RangePlugin = RangePlugin;
var datepickerInputBinding = new Shiny.InputBinding();
$.extend(datepickerInputBinding, {
  store: [],
  updateStore: function(el, picker, type = "single") {
    this.store[el.id] = {picker: picker, type: type}
  },
  find: function(scope) {
    return $(scope).find(".easepick-input");
  },
  getId: function(el) {
    return el.id;
  },
  getValue: function(el) {
     var picker = this.store[el.id].picker;
     var type = this.store[el.id].type;
     var date;
     if (type == "single") {
       date = [picker.getDate()];
     } else if (type == "range") {
       date = [picker.getStartDate(), picker.getEndDate()];
     }
     date = date.map(function(x) {
       if (x !== null)
        x = x.format("YYYY-MM-DD");
      return x;
     });
     return date;
  },
  setValue: function(el, value) {},
  subscribe: function(el, callback) {
    $(el).on("change", function(event) {
      callback();
    });
  },
  unsubscribe: function(el) {
    $(el).off(".datepickerInputBinding");
  },
  receiveMessage: function(el, data) {
    var picker = this.store[el.id].picker;
    var type = this.store[el.id].type;
    var rangePlugin = picker.PluginManager.getInstance("RangePlugin");
    if (data.hasOwnProperty("range")) {
      if (data.range === true & type == "single") {
        picker.clear();
        rangePlugin = picker.PluginManager.addInstance("RangePlugin");
        type = "range";
      }
      if (data.range === false & type == "range") {
        picker.clear();
        picker.PluginManager.removeInstance("RangePlugin");
        type = "single";
      }
    }
    if (data.hasOwnProperty("lockOptions")) {
      var lockOptions = data.lockOptions;
      var lockPlugin = picker.PluginManager.getInstance("LockPlugin");
      if (lockOptions.hasOwnProperty("minDate"))
        lockPlugin.options.minDate = lockOptions.minDate;
      if (lockOptions.hasOwnProperty("maxDate"))
        lockPlugin.options.maxDate = lockOptions.maxDate;
      if (lockOptions.hasOwnProperty("minDays"))
        lockPlugin.options.minDays = lockOptions.minDays;
      if (lockOptions.hasOwnProperty("maxDays"))
        lockPlugin.options.maxDays = lockOptions.maxDays;
      if (lockOptions.hasOwnProperty("filter")) {
        lockPlugin.options.filter = eval("(" + lockOptions.filter + ")");
      }
    }
    if (data.hasOwnProperty("value")) {
      var value = data.value;
      console.log(value);
      if (value.length < 1) {
        picker.clear();
      }
      if (value.length == 1) {
        picker.setDate(value[0]);
      }
      if (value.length == 2) {
        rangePlugin.setStartDate(value[0]);
        rangePlugin.setEndDate(value[1]);
      }
    }
    picker.renderAll();
    this.updateStore(el, picker, type);
    $(el).trigger("change");
  },
  getState: function(el) {},
  initialize: function(el) {
    var data = el.parentNode.querySelector('script[data-for="' + el.id + '"]');
    data = JSON.parse(data.innerHTML);

    var type = data.range === true ? "range" : "single";

    var config = data.easepick;
    config.element = el;
    config.css = [
      'https://cdn.jsdelivr.net/npm/@easepick/bundle@1.2.1/dist/index.css',
    ];

    config.setup = function(picker) {
      picker.on("select", function(e) {
        $(el).trigger("change");
      });
    };

    if (config.hasOwnProperty("LockPlugin") && config.LockPlugin.hasOwnProperty("filter")) {
      config.LockPlugin.filter = eval("(" + config.LockPlugin.filter + ")");
    }

    console.log(config);
    var plgs = config.plugins;
    config.plugins = [LockPlugin];
    if (plgs.includes("AmpPlugin")) {
      config.plugins.push(AmpPlugin);
    }
    if (plgs.includes("RangePlugin")) {
      config.plugins.push(RangePlugin);
    }
    if (plgs.includes("PresetPlugin")) {
      config.plugins.push(PresetPlugin);
    }
    //config.plugins = [RangePlugin, AmpPlugin, LockPlugin, PresetPlugin];
    //config.plugins = config.plugins.map(function(x) {
    //  return eval("(" + x + ")");
    //});
    const picker = new easepick.create(config);
    console.log(picker);

    if (data.hasOwnProperty("startView")) {
      picker.gotoDate(data.startView);
    }

    if (data.hasOwnProperty("triggerId")) {
      document.getElementById(data.triggerId).addEventListener("click", (evt) => {
      	picker.show(evt);
      });
    }

    this.updateStore(el, picker, type);
  }
});
Shiny.inputBindings.register(datepickerInputBinding, "shinyWidgets.datepickerInput");
