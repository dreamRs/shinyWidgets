import $ from "jquery";
import "shiny";
import { updateLabel } from "../modules/utils";
import VanillaCalendar from "vanilla-calendar-pro";
import "vanilla-calendar-pro/build/vanilla-calendar.min.css";
import dayjs from "dayjs";


function changeToInputSingle(fmt) {
  return function(e, self) {
    if (!self.HTMLInputElement) return;
    if (self.selectedDates[0]) {
      self.HTMLInputElement.value = dayjs(self.selectedDates[0]).format(fmt);
      //self.hide();
    } else {
      self.HTMLInputElement.value = "";
    }
  };
}

function changeToInputRange(fmt) {
  return function(e, self) {
    if (!self.HTMLInputElement) return;
    if (self.selectedDates[1]) {
      self.selectedDates.sort((a, b) => +new Date(a) - +new Date(b));
      var fmtdates = self.selectedDates.map(x => dayjs(x).format(fmt));
      self.HTMLInputElement.value = `${fmtdates[0]} \u2014 ${fmtdates[fmtdates.length - 1]}`;
    } else if (self.selectedDates[0]) {
      self.HTMLInputElement.value = dayjs(self.selectedDates[0]).format(fmt);
    } else {
      self.HTMLInputElement.value = "";
    }
  };
}

function changeToInputMultiple(fmt) {
  return function(e, self) {
    if (!self.HTMLInputElement) return;
    if (self.selectedDates[0]) {
      var fmtdates = self.selectedDates.map(x => dayjs(x).format(fmt));
      self.HTMLInputElement.value = fmtdates.join(" \u2014 ");
      //self.hide();
    } else {
      self.HTMLInputElement.value = "";
    }
  };
}


const pick = (obj, ...keys) => Object.fromEntries(
  keys
  .filter(key => key in obj)
  .map(key => [key, obj[key]])
);

var calendarProBinding = new Shiny.InputBinding();
$.extend(calendarProBinding, {
  store: [],
  updateStore: (el, instance) => {
    calendarProBinding.store[el.id] = instance;
  },
  value: [],
  updateValue: (el, value) => {
    calendarProBinding.value[el.id] = value;
  },
  type: [],
  updateType: (el, type) => {
    calendarProBinding.type[el.id] = type;
  },
  find: scope => {
    return $(scope).find(".vanilla-calendar-pro");
  },
  getValue: el => {
    return calendarProBinding.value[el.id];
  },
  setValue: (el, value) => {

  },
  getType: el => {
    return calendarProBinding.type[el.id];
  },
  subscribe: (el, callback) => {
    $(el).on("change.calendarProBinding", function(e) {
      callback();
    });
  },
  unsubscribe: el => {
    $(el).off(".calendarProBinding");
  },
  receiveMessage: (el, data) => {
    if (data.hasOwnProperty("label")) {
      var label = $("#" + el.id + "-label");
      updateLabel(data.label, label);
    }
  },
  initialize: el => {
    var input = el.querySelector(".calendar-pro-element");
    var config = el.querySelector('script[data-for="' + el.id + '"]');
    config = JSON.parse(config.text);
    if (!config.hasOwnProperty("actions"))
      config.actions = {};
    function updateValueOnChange(event, self) {
      calendarProBinding.updateValue(
        el,
        pick(
          self,
          "selectedDates",
          "selectedHolidays",
          "selectedMonth",
          "selectedYear",
          "selectedHours",
          "selectedMinutes",
          "selectedTime",
          "selectedKeeping",
        ),
      );
      $(el).trigger("change");
    }
    config.actions.clickDay = updateValueOnChange;
    config.actions.clickMonth = updateValueOnChange;
    config.actions.clickYear = updateValueOnChange;
    config.actions.changeTime = updateValueOnChange;
    if (config.weekNumbersSelect) {
      config.actions.clickWeekNumber = function(event, number, days, year, self) {
        self.settings.selected.dates = days.map((day) => day.dataset.calendarDay);
        self.update({ dates: true });
        calendarProBinding.updateValue(
          el,
          pick(
            self,
            "selectedDates", "selectedHolidays", "selectedMonth",
            "selectedYear", "selectedHours", "selectedMinutes",
            "selectedTime", "selectedKeeping"
          )
        );
        $(el).trigger("change");
        changeToInputRange(config.format)(event, self);
      };
    }
    if (config.type == "multiple") {
      if (config.settings.selection.day == "multiple-ranged") {
        config.actions.changeToInput = changeToInputRange(config.format);
      } else {
        config.actions.changeToInput = changeToInputMultiple(config.format);
      }
    } else {
      config.actions.changeToInput = changeToInputSingle(config.format);
    }
    const calendar = new VanillaCalendar(input, config);
    calendar.init();
    calendarProBinding.updateStore(el, calendar);
    calendarProBinding.updateValue(el, {
      selectedDates: config?.settings?.selected?.dates,
      selectedMonth: config?.settings?.selected?.month,
      selectedYear: config?.settings?.selected?.year,
      selectedTime: config?.settings?.selected?.time
    });
    calendarProBinding.updateType(el, config.parseValue);
    $(el).trigger("change");
  }
});

Shiny.inputBindings.register(
  calendarProBinding,
  "shinyWidgets.calendarProBinding"
);

