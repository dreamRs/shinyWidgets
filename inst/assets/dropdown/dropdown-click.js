// dropdown input binding
var dropdownInputBinding = new Shiny.InputBinding();
$.extend(dropdownInputBinding, {
  initialize: function initialize(el) {
    $(el).on("click", function(event) {
      var events = $._data(document, "events") || {};
      events = events.click || [];
      for (var i = 0; i < events.length; i++) {
        if (events[i].selector) {
          //Check if the clicked element matches the event selector
          if ($(event.target).is(events[i].selector)) {
            events[i].handler.call(event.target, event);
          }

          // Check if any of the clicked element parents matches the
          // delegated event selector (Emulating propagation)
          $(event.target)
            .parents(events[i].selector)
            .each(function() {
              events[i].handler.call(this, event);
            });
        }
      }
      event.stopPropagation(); //Always stop propagation
    });
  },
  find: function(scope) {
    return $(scope).find(".btn-dropdown-input");
  },
  getId: function(el) {
    return el.id;
  },
  getValue: function(el) {
    return $(el).data("value");
  },
  receiveMessage: function(el, data) {
    $(el)
      .children(":first")
      .dropdown("toggle");
  },
  subscribe: function(el, callback) {
    $(el).on("change", function(event) {
      callback();
    });
    $(el).on("shown.bs.dropdown", function() {
      $(el).data("value", true);
      callback();
    });
    $(el).on("hidden.bs.dropdown", function() {
      $(el).data("value", false);
      callback();
    });
  },
  unsubscribe: function(el) {
    $(el).off(".dropdownInputBinding");
  }
});
Shiny.inputBindings.register(dropdownInputBinding, "shiny.dropdownInput");

function dropBtn(id, easyClose) {
  if (easyClose) {
    $(id).on("click", function(event) {
      var events = $._data(document, "events") || {};
      events = events.click || [];
      for (var i = 0; i < events.length; i++) {
        if (events[i].selector) {
          //Check if the clicked element matches the event selector
          if ($(event.target).is(events[i].selector)) {
            events[i].handler.call(event.target, event);
          }

          // Check if any of the clicked element parents matches the
          // delegated event selector (Emulating propagation)
          $(event.target)
            .parents(events[i].selector)
            .each(function() {
              events[i].handler.call(this, event);
            });
        }
      }
      event.stopPropagation(); //Always stop propagation
    });
  } else {
    $(id).on({
      "shown.bs.dropdown": function() {
        this.closable = false;
      },
      click: function() {
        return true;
      },
      "hide.bs.dropdown": function() {
        return false;
      }
    });
  }
}

