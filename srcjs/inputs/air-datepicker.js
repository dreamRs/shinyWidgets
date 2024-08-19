import $ from "jquery";
import "shiny";
import { updateLabel } from "../modules/utils";
import dayjs from "dayjs";
import utc from "dayjs/plugin/utc";
import timezone from "dayjs/plugin/timezone";
dayjs.extend(utc);
dayjs.extend(timezone);
import AirDatepicker from "air-datepicker";
import "air-datepicker/air-datepicker.css";
import "../css/air-datepicker.css";
import localeAR from "air-datepicker/locale/ar";
import localeBG from "air-datepicker/locale/bg";
import localeCS from "air-datepicker/locale/cs";
import localeDA from "air-datepicker/locale/da";
import localeDE from "air-datepicker/locale/de";
import localeEN from "air-datepicker/locale/en";
import localeES from "air-datepicker/locale/es";
import localeFI from "air-datepicker/locale/fi";
import localeFR from "air-datepicker/locale/fr";
import localeHR from "air-datepicker/locale/hr";
import localeHU from "air-datepicker/locale/hu";
import localeIT from "air-datepicker/locale/it";
import localeJA from "air-datepicker/locale/ja";
import localeKO from "air-datepicker/locale/ko";
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
  AR: localeAR,
  BG: localeBG,
  CS: localeCS,
  DA: localeDA,
  DE: localeDE,
  EN: localeEN,
  ES: localeES,
  FI: localeFI,
  FR: localeFR,
  HR: localeHR,
  HU: localeHU,
  IT: localeIT,
  JA: localeJA,
  KO: localeKO,
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



function format_date(date) {
  return dayjs(date).format('YYYY-MM-DD');
}

function as_date(options) {
  if (options.hasOwnProperty("tz") && options.tz !== undefined) {
    return dayjs(value).tz(options.tz).toDate();
  }
  return dayjs(options.date).toDate();
}

function get_config(el) {
  var config = $(el)
      .parent()
      .parent()
      .find('script[data-for="' + el.id + '"]');
  return JSON.parse(config.html());
}

function onRenderCell(disabledDates, disabledDaysOfWeek, highlightedDates) {
  return ({ date, cellType, datepicker }) => {
    if (cellType == "day") {
      var disabled = false,
        highlighted = 0,
        formatted = format_date(date);

      disabled = disabledDates.filter(function(date) {
        return date == formatted;
      }).length;

      if (disabledDaysOfWeek.includes(dayjs(date).day())) {
        disabled = true;
      }

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
    var config = get_config(el);
    var options = config.options;

    options.locale = locales[config.language];

    if (config.hasOwnProperty("value")) {
      var dateraw = config.value;
      var datedefault = [];
      for (var i = 0; i < dateraw.length; i++) {
        datedefault[i] = as_date({date: dateraw[i], tz: options.tz});
      }
      options.selectedDates = datedefault;
    }

    if (options.hasOwnProperty("minDate")) {
      options.minDate = as_date({date: options.minDate, tz: options.tz});
    }
    if (options.hasOwnProperty("maxDate")) {
      options.maxDate = as_date({date: options.maxDate, tz: options.tz});
    }
    if (options.hasOwnProperty("startDate")) {
      options.startDate = as_date({date: options.startDate, tz: options.tz});
    }
    if (config.todayButtonAsDate) {
      options.todayButton = as_date({date: options.todayButton, tz: options.tz});
    }

    // disable dates
    var disabledDates = [];
    if (config.hasOwnProperty("disabledDates")) {
      disabledDates = config.disabledDates;
    }
    var disabledDaysOfWeek = [];
    if (config.hasOwnProperty("disabledDaysOfWeek")) {
      disabledDaysOfWeek = config.disabledDaysOfWeek;
    }
    var highlightedDates = [];
    if (config.hasOwnProperty("highlightedDates")) {
      highlightedDates = config.highlightedDates;
    }
    options.onRenderCell = onRenderCell(disabledDates, disabledDaysOfWeek, highlightedDates);

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
    if (config.hasOwnProperty("startView")) {
      dp.date = as_date({date: config.startView, tz: options.tz});
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
    var config = get_config(el);
    if (config.options.timepicker) {
      return "air.datetime";
    } else {
      return "air.date";
    }
  },
  getValue: el => {
    var config = get_config(el);
    var dp = AirDatepickerBindings.store[el.id];
    var sd = dp.selectedDates;
    var timepicker = config.options.timepicker;
    var res;
    if (typeof sd != "undefined" && sd.length > 0) {
      res = sd.map(function(e) {
        return timepicker ? dayjs(e).format("YYYY-MM-DD HH:mm:ss") : dayjs(e).format("YYYY-MM-DD");
      });
      return {date: res, tz: config.tz};
    } else {
      return null;
    }
  },
  setValue: (el, options) => {
    var value = options.value;
    var newdate = [];
    for (var i = 0; i < value.length; i++) {
      newdate[i] = as_date({date: value[i], tz: options.tz});
    }
    var dp = AirDatepickerBindings.store[el.id];
    dp.selectDate(newdate);
  },
  subscribe: (el, callback) => {
    $(el).on("change.AirDatepickerBinding", function(event) {
      callback();
    });
  },
  unsubscribe: el => {
    $(el).off(".AirDatepickerBinding");
  },
  receiveMessage: (el, data) => {
    var dp = AirDatepickerBindings.store[el.id];
    //console.log(data);
    if (data.clear) {
      dp.clear();
    }
    if (data.show) {
      dp.show();
    }
    if (data.hide) {
      dp.hide();
    }

    if (data.hasOwnProperty("label")) {
      var label = $("#" + el.id + "-label");
      updateLabel(data.label, label);
    }

    if (data.config.hasOwnProperty("options")) {
      var options = data.config.options;

      if (options.hasOwnProperty("minDate")) {
        options.minDate = as_date({date: options.minDate, tz: options.tz});
      }
      if (options.hasOwnProperty("maxDate")) {
        options.maxDate = as_date({date: options.maxDate, tz: options.tz});
      }

      if (
        options.hasOwnProperty("disabledDates") |
        options.hasOwnProperty("disabledDaysOfWeek") |
        options.hasOwnProperty("highlightedDates")
      ) {
        var disabledDates = [];
        if (options.hasOwnProperty("disabledDates")) {
          disabledDates = options.disabledDates;
        }
        var disabledDaysOfWeek = [];
        if (options.hasOwnProperty("disabledDaysOfWeek")) {
          disabledDaysOfWeek = options.disabledDaysOfWeek;
        }
        var highlightedDates = [];
        if (options.hasOwnProperty("highlightedDates")) {
          highlightedDates = options.highlightedDates;
        }
        options.onRenderCell = onRenderCell(disabledDates, disabledDaysOfWeek, highlightedDates);
      }

      dp.update(options);

      if (options.hasOwnProperty("startView")) {
        dp.date = as_date({date: options.startView, tz: options.tz});
      }
    }

    if (data.hasOwnProperty("placeholder")) {
      $("#" + data.id)[0].placeholder = data.placeholder;
    }

    if (data.config.hasOwnProperty("value")) {
      AirDatepickerBindings.setValue(el, data.config.value);
    }

    $(el).trigger("change");
  }
});
Shiny.inputBindings.register(
  AirDatepickerBindings,
  "shinyWidgets.AirDatepicker"
);

