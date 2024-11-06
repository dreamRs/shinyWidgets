import $ from "jquery";
import "shiny";
import { updateLabel } from "../modules/utils";
import VanillaCalendar from "vanilla-calendar-pro";
import "vanilla-calendar-pro/build/vanilla-calendar.min.css";


function changeToInputSingle(e, self) {
  if (!self.HTMLInputElement) return;
  if (self.selectedDates[0]) {
    self.HTMLInputElement.value = self.selectedDates[0];
    // if you want to hide the calendar after picking a date
    //self.hide();
  } else {
    self.HTMLInputElement.value = "";
  }
}

function changeToInputMultiple(e, self) {
  if (!self.HTMLInputElement) return;
  if (self.selectedDates[1]) {
    self.selectedDates.sort((a, b) => +new Date(a) - +new Date(b));
    self.HTMLInputElement.value = `${self.selectedDates[0]} — ${self.selectedDates[self.selectedDates.length - 1]}`;
  } else if (self.selectedDates[0]) {
    self.HTMLInputElement.value = self.selectedDates[0];
  } else {
    self.HTMLInputElement.value = "";
  }
}

var calendarProBinding = new Shiny.InputBinding();
$.extend(calendarProBinding, {
  store: [],
  updateStore: (el, instance) => {
    calendarProBinding.store[el.id] = instance;
  },
  value: [],
  updateValue: (el, instance) => {
    calendarProBinding.value[el.id] = instance;
  },
  find: scope => {
    return $(scope).find(".vanilla-calendar-pro");
  },
  getValue: el => {
    return calendarProBinding.value[el.id];
  },
  setValue: (el, value) => {

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
    config.actions.clickDay = function(event, self) {
      calendarProBinding.updateValue(el, self.selectedDates);
      $(el).trigger("change");
    };
    if (config.weekNumbersSelect) {
      config.actions.clickWeekNumber = function(event, number, days, year, self) {
        self.settings.selected.dates = days.map((day) => day.dataset.calendarDay);
        self.update({ dates: true });
        calendarProBinding.updateValue(el, self.selectedDates);
        $(el).trigger("change");
      };
    }
    if (config.type == "multiple") {
      config.actions.changeToInput = changeToInputMultiple;
    } else {
      config.actions.changeToInput = changeToInputSingle;
    }
    const calendar = new VanillaCalendar(input, config);
    calendar.init();
    calendarProBinding.updateStore(el, calendar);
    calendarProBinding.updateValue(el, config?.settings?.selected?.dates);
    $(el).trigger("change");
  }
});

Shiny.inputBindings.register(
  calendarProBinding,
  "shinyWidgets.calendarProBinding"
);

