// airDatepicker bindings //
// by Vic //

var AirPickerInputBinding = new Shiny.InputBinding();
$.extend(AirPickerInputBinding, {
  initialize: function initialize(el) {
    var config = $(el)
      .parent()
      .parent()
      .find('script[data-for="' + el.id + '"]');

    config = JSON.parse(config.html());
    var options = config.options;

    if (config.hasOwnProperty("value")) {
      var dateraw = config.value;
      var datedefault = [];
      for (var i = 0; i < dateraw.length; i++) {
        datedefault[i] = new Date(dateraw[i]);
      }
      config.value = datedefault;
    }

    if (options.hasOwnProperty("minDate")) {
      options.minDate = new Date(options.minDate);
    }
    if (options.hasOwnProperty("maxDate")) {
      options.maxDate = new Date(options.maxDate);
    }
    if (options.hasOwnProperty("startDate")) {
      options.startDate = new Date(options.startDate);
    }
    if (config.todayButtonAsDate) {
      options.todayButton = new Date(options.todayButton);
    }

    // disable dates
    if (config.hasOwnProperty("disabledDates")) {
      var disabledDates = config.disabledDates;
      options.onRenderCell = function(d, type) {
        if (type == "day") {
          var disabled = false,
            formatted = getFormattedDate(d);

          disabled = disabledDates.filter(function(date) {
            return date == formatted;
          }).length;

          return {
            disabled: disabled
          };
        }
      };
    }

    if (config.updateOn == "close") {
      options.onHide = function(inst, animationCompleted) {
        if (animationCompleted) {
          $(el).trigger("change");
        }
      };
    } else {
      options.onSelect = function(formattedDate, date, inst) {
        $(el).trigger("change");
      };
    }

    var dp = $(el)
          .datepicker(options)
          .data("datepicker");
    dp.selectDate(config.value);
    if (config.hasOwnProperty("startView")) {
      dp.date = new Date(config.startView);
    }
  },
  find: function(scope) {
    return $(scope).find(".sw-air-picker");
  },
  getId: function(el) {
    return $(el).attr("id");
  },
  getType: function(el) {
    // console.log($(el).attr('data-timepicker') === 'false');
    if ($(el).attr("data-timepicker") !== "false") {
      return "air.datetime";
    } else {
      return "air.date";
    }
  },
  getValue: function(el) {
    //return el.value;

    var sd = $(el)
      .datepicker()
      .data("datepicker").selectedDates;
    var timepicker = $(el).attr("data-timepicker");
    var res;

    function padZeros(n, digits) {
      var str = n.toString();
      while (str.length < digits) {
        str = "0" + str;
      }
      return str;
    }
    function formatDate(date) {
      if (date instanceof Date) {
        return (
          date.getFullYear() +
          "-" +
          padZeros(date.getMonth() + 1, 2) +
          "-" +
          padZeros(date.getDate(), 2)
        );
      } else {
        return null;
      }
    }

    if (sd.length > 0) {
      if (timepicker === "false") {
        res = sd.map(function(e) {
          //console.log(e);
          return formatDate(e);
        });
      } else {
        //var tz = new Date().toString().match(/([-\+][0-9]+)\s/)[1];
        res = sd.map(function(e) {
          return e.valueOf(); //toISOString() + tz;
        });
        //res = sd ;
      }
      return res;
    } else {
      return null;
    }
  },
  setValue: function(el, value) {
    value = JSON.parse(value);
    var newdate = [];
    for (var i = 0; i < value.length; i++) {
      newdate[i] = new Date(value[i]);
    }
    var datepicker = $(el)
      .datepicker()
      .data("datepicker");
    datepicker.selectDate(newdate);
    //datepicker.date = newdate[0];
  },
  subscribe: function(el, callback) {
    $(el).on("change", function(event) {
      callback();
    });
  },
  unsubscribe: function(el) {
    $(el).off(".AirPickerInputBinding");
  },
  receiveMessage: function(el, data) {
    if (data.clear) {
      $(el)
        .datepicker()
        .data("datepicker")
        .clear();
    }
    if (data.hasOwnProperty("value")) this.setValue(el, data.value);

    if (data.hasOwnProperty("label")) {
      // console.log(el);
      $(el)
        .parent()
        .parent()
        .find('label[for="' + data.id + '"]')
        .text(data.label);
    }

    if (data.hasOwnProperty("options")) {
      if (data.options.hasOwnProperty("minDate")) {
        data.options.minDate = new Date(data.options.minDate);
      }
      if (data.options.hasOwnProperty("maxDate")) {
        data.options.maxDate = new Date(data.options.maxDate);
      }
      $(el)
        .datepicker()
        .data("datepicker")
        .update(data.options);

      if (data.options.hasOwnProperty("startView")) {
        var dp = $(el).datepicker().data("datepicker");
        dp.date = new Date(data.options.startView);
      }
    }


    if (data.hasOwnProperty("placeholder")) {
      $("#" + data.id)[0].placeholder = data.placeholder;
    }

    $(el).trigger("change");
  }
});
Shiny.inputBindings.register(AirPickerInputBinding, "shinyWidgets.AirPickerInput");

/*
function parse_date(date) {
  return date.getUTCFullYear() + '-' + date.getUTCMonth() + '-' + date.getUTCDate();
}
*/

Date.prototype.yyyymmdd = function() {
  var mm = this.getMonth() + 1; // getMonth() is zero-based
  var dd = this.getDate();

  return [
    this.getFullYear(),
    (mm > 9 ? "" : "0") + mm,
    (dd > 9 ? "" : "0") + dd
  ].join("-");
};

function getFormattedDate(date) {
  var year = date.getFullYear(),
    month = date.getMonth() + 1,
    day = date.getDate();

  if (month > 9) {
    if (day > 9) {
      return year + "-" + month + "-" + day;
    } else {
      return year + "-" + month + "-0" + day;
    }
  } else {
    if (day > 9) {
      return year + "-0" + month + "-" + day;
    } else {
      return year + "-0" + month + "-0" + day;
    }
  }
}

