import $ from "jquery";
import "shiny";
import AirDatepicker from "air-datepicker";
import "air-datepicker/air-datepicker.css";
import localeCS from "air-datepicker/locale/cs";
import localeDA from "air-datepicker/locale/da";
import localeDE from "air-datepicker/locale/de";
import localeEN from "air-datepicker/locale/en";
import localeES from "air-datepicker/locale/es";
import localeFI from "air-datepicker/locale/fi";
import localeFR from "air-datepicker/locale/fr";
import localeHU from "air-datepicker/locale/hu";
import localeNL from "air-datepicker/locale/nl";
import localePL from "air-datepicker/locale/pl";
import localePTBR from "air-datepicker/locale/pt-BR";
import localePT from "air-datepicker/locale/pt";
import localeRO from "air-datepicker/locale/ro";
import localeRU from "air-datepicker/locale/ru";
import localeSI from "air-datepicker/locale/si";
import localeSK from "air-datepicker/locale/sk";
import localeTH from "air-datepicker/locale/th";
import localeTR from "air-datepicker/locale/tr";
import localeUK from "air-datepicker/locale/uk";
import localeZH from "air-datepicker/locale/zh";

let locales = {
  CS: localeCS,
  DA: localeDA,
  DE: localeDE,
  EN: localeEN,
  ES: localeES,
  FI: localeFI,
  FR: localeFR,
  HU: localeHU,
  NL: localeNL,
  PL: localePL,
  "PT-BR": localePTBR,
  PT: localePT,
  RO: localeRO,
  RU: localeRU,
  SI: localeSI,
  SK: localeSK,
  TH: localeTH,
  TR: localeTR,
  UK: localeUK,
  ZH: localeZH
};

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

function onRenderCell(disabledDates, highlightedDates) {
  return ({ date, cellType, datepicker }) => {
    if (cellType == "day") {
      var disabled = false,
        highlighted = 0,
        formatted = getFormattedDate(date);

      disabled = disabledDates.filter(function(date) {
        return date == formatted;
      }).length;

      highlighted = highlightedDates.filter(function(date) {
        return date == formatted;
      }).length;

      var html = date.getDate();
      var classes = "";
      if (highlighted > 0) {
        html = date.getDate() + '<span class="dp-note"></span>';
        classes = "airdatepicker-highlighted";
      }

      return {
        html: html,
        classes: classes,
        disabled: disabled
      };
    }
  };
}

var AirDatepickerBindings = new Shiny.InputBinding();
$.extend(AirDatepickerBindings, {
  store: [],
  updateStore: (el, instance) => {
    AirDatepickerBindings.store[el.id] = instance;
  },
  initialize: el => {
    var config = $(el)
      .parent()
      .parent()
      .find('script[data-for="' + el.id + '"]');

    config = JSON.parse(config.html());
    var options = config.options;

    options.locale = locales[config.language];

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
    var disabledDates = [];
    if (config.hasOwnProperty("disabledDates")) {
      disabledDates = config.disabledDates;
    }
    var highlightedDates = [];
    if (config.hasOwnProperty("highlightedDates")) {
      highlightedDates = config.highlightedDates;
    }
    options.onRenderCell = onRenderCell(disabledDates, highlightedDates);

    if (config.updateOn == "close") {
      options.onHide = function(isFinished) {
        if (isFinished) {
          $(el).trigger("change");
        }
      };
    } else {
      options.onSelect = function(date, formattedDate, datepicker) {
        $(el).trigger("change");
      };
    }

    var dp = new AirDatepicker(el, options);
    dp.selectDate(config.value);
    if (config.hasOwnProperty("startView")) {
      dp.date = new Date(config.startView);
    }
    AirDatepickerBindings.updateStore(el, dp);
  },
  find: scope => {
    return $(scope).find(".sw-air-picker");
  },
  getId: el => {
    return $(el).attr("id");
  },
  getType: el => {
    if ($(el).attr("data-timepicker") !== "false") {
      return "air.datetime";
    } else {
      return "air.date";
    }
  },
  getValue: el => {
    var dp = AirDatepickerBindings.store[el.id];
    var sd = dp.selectedDates;
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

    if (typeof sd != "undefined" && sd.length > 0) {
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
  setValue: (el, value) => {
    value = JSON.parse(value);
    var newdate = [];
    for (var i = 0; i < value.length; i++) {
      newdate[i] = new Date(value[i]);
    }
    var dp = AirDatepickerBindings.store[el.id];
    dp.selectDate(newdate);
  },
  subscribe: (el, callback) => {
    $(el).on("change", function(event) {
      callback();
    });
  },
  unsubscribe: el => {
    $(el).off(".AirDatepickerBindings");
  },
  receiveMessage: (el, data) => {
    var dp = AirDatepickerBindings.store[el.id];
    if (data.clear) {
      dp.clear();
    }
    if (data.show) {
      dp.show();
    }
    if (data.hide) {
      dp.hide();
    }
    if (data.hasOwnProperty("value")) AirDatepickerBindings.setValue(el, data.value);

    if (data.hasOwnProperty("label")) {
      // console.log(el);
      $(el)
        .parent()
        .parent()
        .find('label[for="' + data.id + '"]')
        .text(data.label);
    }

    if (data.hasOwnProperty("options")) {
      var options = data.options;

      if (options.hasOwnProperty("minDate")) {
        options.minDate = new Date(options.minDate);
      }
      if (options.hasOwnProperty("maxDate")) {
        options.maxDate = new Date(options.maxDate);
      }

      if (
        options.hasOwnProperty("disabledDates") |
        options.hasOwnProperty("highlightedDates")
      ) {
        var disabledDates = [];
        if (options.hasOwnProperty("disabledDates")) {
          disabledDates = options.disabledDates;
        }
        var highlightedDates = [];
        if (options.hasOwnProperty("highlightedDates")) {
          highlightedDates = options.highlightedDates;
        }
        options.onRenderCell = onRenderCell(disabledDates, highlightedDates);
      }

      dp.update(options);

      if (options.hasOwnProperty("startView")) {
        dp.date = new Date(options.startView);
      }
    }

    if (data.hasOwnProperty("placeholder")) {
      $("#" + data.id)[0].placeholder = data.placeholder;
    }

    $(el).trigger("change");
  }
});
Shiny.inputBindings.register(
  AirDatepickerBindings,
  "shinyWidgets.AirDatepicker"
);

