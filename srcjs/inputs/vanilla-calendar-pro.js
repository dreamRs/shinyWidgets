import $ from "jquery";
import "shiny";
import { updateLabel } from "../modules/utils";
import { Calendar } from 'vanilla-calendar-pro';
import "vanilla-calendar-pro/styles/index.css";
import dayjs from "dayjs";


function changeToInputMonth(fmt) {
  return function(self) {
    if (!self.context.inputElement) return;
    if (self.context.selectedMonth) {
      var date = self.context.selectedYear + "-" + self.context.selectedMonth + "-01";
      self.context.inputElement.value = dayjs(date).format(fmt);
      //self.hide();
    } else {
      self.context.inputElement.value = "";
    }
  };
}

function changeToInputYear(fmt) {
  return function(self) {
    if (!self.context.inputElement) return;
    if (self.context.selectedYear) {
      var date = self.context.selectedYear + "01-01";
      self.context.inputElement.value = dayjs(date).format(fmt);
      //self.hide();
    } else {
      self.context.inputElement.value = "";
    }
  };
}

function changeToInputSingle(fmt) {
  return function(self) {
    if (!self.context.inputElement) return;
    if (self.context.selectedDates[0]) {
      var date = self.context.selectedDates[0];
      if (self.context?.selectedTime) {
        date = date + " " + self.context.selectedTime;
      }
      self.context.inputElement.value = dayjs(date).format(fmt);
      //self.hide();
    } else {
      self.context.inputElement.value = "";
    }
  };
}

function changeToInputRange(fmt) {
  return function(self) {
    if (!self.context.inputElement) return;
    if (self.context.selectedDates[1]) {
      self.context.selectedDates.sort((a, b) => +new Date(a) - +new Date(b));
      var fmtdates = self.context.selectedDates.map(x => {
        if (self.context?.selectedTime) {
          x = x + " " + self.context.selectedTime;
        }
        return dayjs(x).format(fmt);
      });
      self.context.inputElement.value = `${fmtdates[0]} \u2014 ${fmtdates[fmtdates.length - 1]}`;
    } else if (self.context.selectedDates[0]) {
      var date = self.context.selectedDates[0];
      if (self.context?.selectedTime) {
        date = date + " " + self.context.selectedTime;
      }
      self.context.inputElement.value = dayjs(date).format(fmt);
    } else {
      self.context.inputElement.value = "";
    }
  };
}

function changeToInputMultiple(fmt) {
  return function(self) {
    if (!self.context.inputElement) return;
    console.log(self);
    if (self.context.selectedDates[0]) {
      var fmtdates = self.context.selectedDates.map(x => {
        if (self.context?.selectedTime) {
          x = x + " " + self.context.selectedTime;
        }
        return dayjs(x).format(fmt);
      });
      self.context.inputElement.value = fmtdates.join(" \u2014 ");
      //self.hide();
    } else {
      self.context.inputElement.value = "";
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
    if (data.hasOwnProperty("options")) {
      var config = el.querySelector('script[data-for="' + el.id + '"]');
      config = JSON.parse(config.text);
      var options = data.options;
      var calendar = calendarProBinding.store[el.id];
      if (options.hasOwnProperty("selectionDatesMode")) {
        if (options.selectionDatesMode == "multiple-ranged") {
          options.onChangeToInput = changeToInputRange(config.format);
        } else if (options.selectionDatesMode == "multiple") {
          options.onChangeToInput = changeToInputMultiple(config.format);
        } else {
          options.onChangeToInput = changeToInputSingle(config.format);
        }
      }
      calendar.set(options, {dates: true});
      calendarProBinding.updateValue(el, {
        selectedDates: calendar?.selectedDates,
        selectedMonth: calendar?.selectedMonth,
        selectedYear: calendar?.selectedYear,
        selectedTime: calendar?.selectedTime
      });
      $(el).trigger("change");
      if (calendar.selectionDatesMode == "multiple-ranged") {
        changeToInputRange(config.format)(calendar);
      } else if (calendar.selectionDatesMode == "multiple") {
        changeToInputMultiple(config.format)(calendar);
      } else {
        changeToInputSingle(config.format)(calendar);
      }
    }
  },
  initialize: el => {
    var input = el.querySelector(".calendar-pro-element");
    var config = el.querySelector('script[data-for="' + el.id + '"]');
    config = JSON.parse(config.text);
    var options = config.options;
    function updateValueOnChange(self) {
      calendarProBinding.updateValue(
        el,
        pick(
          self.context,
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
    if (options.type == "month") {
      options.onClickMonth = function(self) {
        updateValueOnChange(self);
        changeToInputMonth(config.format)(self);
      };
    } else if (options.type == "year") {
      options.onClickYear = function(self) {
        updateValueOnChange(self);
        changeToInputYear(config.format)(self);
      };
    } else {
      options.onClickDate = updateValueOnChange;
      options.onChangeTime = updateValueOnChange;
    }
    if (config.selectWeekNumbers) {
      options.onClickWeekNumber = function(self, number, year, dateEls) {
        var selectedDates = dateEls.map((dateEl) => dateEl.dataset.vcDate);
        self.set({ selectedDates }, { dates: true });
        calendarProBinding.updateValue(
          el,
          pick(
            self.context,
            "selectedDates",
            "selectedHolidays",
            "selectedMonth",
            "selectedYear",
            "selectedHours",
            "selectedMinutes",
            "selectedTime",
            "selectedKeeping"
          )
        );
        $(el).trigger("change");
        changeToInputRange(config.format)(self);
      };
    }
    if (options.selectionDatesMode == "multiple-ranged") {
      options.onChangeToInput = changeToInputRange(config.format);
    } else if (options.selectionDatesMode == "multiple") {
      options.onChangeToInput = changeToInputMultiple(config.format);
    } else {
      options.onChangeToInput = changeToInputSingle(config.format);
    }
    const calendar = new Calendar(input, options);
    calendar.init();
    calendarProBinding.updateStore(el, calendar);
    calendarProBinding.updateValue(el, {
      selectedDates: options?.selectedDates,
      selectedMonth: options?.selectedMonth,
      selectedYear: options?.selectedYear,
      selectedTime: options?.selectedTime
    });
    calendarProBinding.updateType(el, config.parseValue);
    $(el).trigger("change");
  }
});

Shiny.inputBindings.register(
  calendarProBinding,
  "shinyWidgets.calendarProBinding"
);

