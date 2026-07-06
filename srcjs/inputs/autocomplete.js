import $ from "jquery";
import "shiny";
import autoComplete from "@tarekraafat/autocomplete.js";

const bindings = new WeakMap();

function parseConfig(el) {
  const b64 = el.getAttribute("data-config");
  if (!b64) return {};
  try {
    return JSON.parse(atob(b64));
  } catch (e) {
    console.error("Invalid autocomplete config", e);
    return {};
  }
}

function initAutocomplete(el) {
  const cfg = parseConfig(el);
  const input = el.querySelector("input");
  if (!input) return null;

  const existing = bindings.get(el);
  if (existing && existing.ac && typeof existing.ac.unInit === "function") {
    existing.ac.unInit();
  }

  // état interne: valeur "commitée" uniquement lors d'une sélection
  const state = {
    ac: null,
    committedValue: existing ? existing.committedValue : input.value || "",
  };

  const ac = new autoComplete({
    selector: () => input,
    placeHolder: cfg.placeholder || "",
    data: { src: cfg.choices || [] },
    resultItem: { highlight: true },
    resultsList: cfg.resultsList,
    events: {
      input: {
        selection: function (event) {
          const v = event.detail.selection.value;
          input.value = v;
          state.committedValue = v;

          // notifier Shiny UNIQUEMENT ici
          $(el).trigger("autocompletejs:selected");
        },
      },
    },
  });

  state.ac = ac;
  bindings.set(el, state);
  return state;
}

const AutocompleteBinding = new Shiny.InputBinding();
$.extend(AutocompleteBinding, {
  find: function (scope) {
    return $(scope).find(".sw-autocomplete");
  },

  initialize: function (el) {
    initAutocomplete(el);
  },

  getValue: function (el) {
    const state = bindings.get(el);
    return state ? state.committedValue : null;
  },

  setValue: function (el, value) {
    const input = el.querySelector("input");
    const state = bindings.get(el);
    const v = value == null ? "" : String(value);

    if (input) input.value = v;
    if (state) state.committedValue = v;

    // setValue = update programmatique => on notifie
    $(el).trigger("autocompletejs:selected");
  },

  subscribe: function (el, callback) {
    $(el).on("autocompletejs:selected.autocompletejs", function () {
      callback(true);
    });
  },

  unsubscribe: function (el) {
    $(el).off(".autocompletejs");
  },

  receiveMessage: function (el, data) {
    const input = el.querySelector("input");
    const state = bindings.get(el);

    if (data.hasOwnProperty("value")) {
      const v = data.value == null ? "" : String(data.value);
      if (input) input.value = v;
      if (state) state.committedValue = v;
      $(el).trigger("autocompletejs:selected");
    }

    if (data.hasOwnProperty("choices") || data.hasOwnProperty("placeholder")) {
      const current = parseConfig(el);
      const next = Object.assign({}, current, data);
      el.setAttribute("data-config", btoa(JSON.stringify(next)));
      initAutocomplete(el);
    }
  },
});

Shiny.inputBindings.register(AutocompleteBinding, "shinyWidgets.autocompletejs");
