// searchInput bindings //
// by VP 4 dreamRs //

var searchInputBinding = new Shiny.InputBinding();
$.extend(searchInputBinding, {
  find: function(scope) {
    return $(scope).find(".search-text");
  },
  getId: function(el) {
    return $(el).attr("id");
  },
  getValue: function(el) {
    return $("#" + Shiny.$escape(el.id) + "_text").val();
  },
  setValue: function(el, value) {
    $("#" + Shiny.$escape(el.id) + "_text").val(value);
  },
  subscribe: function(el, callback) {
    $("#" + Shiny.$escape(el.id) + "_text").on(
      "keyup.searchInputBinding input.searchInputBinding",
      function(event) {
        if (event.keyCode == 13) {
          //if enter
          callback();
        }
      }
    );
    $("#" + Shiny.$escape(el.id) + "_search").on("click", function(event) {
      // on click
      callback();
    });
    $("#" + Shiny.$escape(el.id) + "_reset").on("click", function(event) {
      // on click
      var reset = $("#" + Shiny.$escape(el.id)).data("reset");
      if (reset == "TRUE") {
        var resetValue = $("#" + Shiny.$escape(el.id)).data("reset-value");
        $("#" + Shiny.$escape(el.id) + "_text").val(resetValue);
      }
      callback();
    });
  },
  unsubscribe: function(el) {
    $(el).off(".searchInputBinding");
  },
  receiveMessage: function(el, data) {
    if (data.hasOwnProperty("value")) this.setValue(el, data.value);

    if (data.hasOwnProperty("label")) {
      $(el)
        .parent()
        .find('label[for="' + el.id + '"]')
        .text(data.label);
    }

    if (data.hasOwnProperty("placeholder")) {
      $("#" + el.id + "_text")[0].placeholder = data.placeholder;
    }

    if (data.trigger) {
      $("#" + el.id + "_search").click();
    }

    $(el).trigger("change");
  },
  getState: function(el) {
    return {
      value: this.getValue(el) //el.value
    };
  },
  getRatePolicy: function() {
    return {
      policy: "debounce",
      delay: 250
    };
  }
});
Shiny.inputBindings.register(searchInputBinding, "shinyWidgets.searchInput");

