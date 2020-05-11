/**
 * knobInput Shiny bindings
 *
 * by D. Granjon & V .Perrier
 *
 */

function tron_skin() {
  // "tron" case
  if (this.$.data("skin") == "tron") {
    this.cursorExt = 0.3;
    var a = this.arc(this.cv), // Arc
      pa, // Previous arc
      r = 1;
    this.g.lineWidth = this.lineWidth;
    if (this.o.displayPrevious) {
      pa = this.arc(this.v);
      this.g.beginPath();
      this.g.strokeStyle = this.pColor;
      this.g.arc(
        this.xy,
        this.xy,
        this.radius - this.lineWidth,
        pa.s,
        pa.e,
        pa.d
      );
      this.g.stroke();
    }
    this.g.beginPath();
    this.g.strokeStyle = r ? this.o.fgColor : this.fgColor;
    this.g.arc(this.xy, this.xy, this.radius - this.lineWidth, a.s, a.e, a.d);
    this.g.stroke();
    this.g.lineWidth = 2;
    this.g.beginPath();
    this.g.strokeStyle = this.o.fgColor;
    this.g.arc(
      this.xy,
      this.xy,
      this.radius - this.lineWidth + 1 + (this.lineWidth * 2) / 3,
      0,
      2 * Math.PI,
      false
    );
    this.g.stroke();
    return false;
  }
}

var knobInputBinding = new Shiny.InputBinding();
$.extend(knobInputBinding, {
  find: function(scope) {
    return $(scope).find(".knob-input");
  },
  initialize: function(el) {
    // extract the value from el
    // note here our knobInput does not yet exist
    var value = $(el).data("value");

    var post = $(el).data("post");
    post = typeof post == "undefined" ? "" : post;

    var pre = $(el).data("pre");
    pre = typeof pre == "undefined" ? "" : pre;

    // initialize our knob based on the extracted state
    el.value = value;

    // skin
    var skin = $(el).data("skin");
    var draw;
    if (skin === "tron") {
      draw = tron_skin;
    } else {
      draw = function() {
        this.i.val(pre + this.cv + post);
      };
    }

    // Initialize knob
    $(el).knob({
      draw: draw,
      format: function(v) {
        return pre + v + post;
      }
    });
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    var value = el.value;
    var pre = $(el).data("pre");
    if (typeof pre !== "undefined") {
      var regexPre = new RegExp("^" + pre);
      value = value.replace(regexPre, "");
    }
    var post = $(el).data("post");
    if (typeof post !== "undefined") {
      var regexPost = new RegExp(post + "$");
      value = value.replace(regexPost, "");
    }
    return parseFloat(value);
  },

  // Set up the event listeners so that interactions with the
  // input will result in data being sent to server.
  // callback is a function that queues data to be sent to
  // the server.
  subscribe: function(el, callback) {
    var immediate = $(el).data("immediate");
    if (immediate) {
      $(el).on("keyup.knobInputBinding", function(event) {
        callback(true);
        // When called with true, it will use the rate policy,
        // which in this case is to debounce at 500ms.
      });

      $(el).trigger("configure", {
        change: function(v) {
          callback(true);
        },
        release: function(v) {
          callback(false);
        }
      });

      $(el).on("change.knobInputBinding", function(event) {
        callback(true);
        // When called with false, it will NOT use the rate policy,
        // so changes will be sent immediately
      });
    } else {
      $(el).on("keyup.knobInputBinding", function(event) {
        callback(true);
        // When called with true, it will use the rate policy,
        // which in this case is to debounce at 500ms.
      });
      $(el).trigger("configure", {
        release: function(v) {
          callback(false);
        }
      });
    }
  },

  // Remove the event listeners
  unsubscribe: function(el) {
    $(el).off(".knobInputBinding");
  },

  // Receive messages from the server.
  // Messages sent by updateknobInput() are received by this function.
  receiveMessage: function(el, data) {
    if (data.hasOwnProperty("value")) {
      $(el)
        .val(data.value)
        .trigger("change");
    }

    if (data.hasOwnProperty("readOnly")) {
      $(el).trigger("configure", {
        readOnly: data.readOnly
      });
    }

    if (data.hasOwnProperty("options")) {
      $(el).trigger("configure", data.options);
    }

    if (data.hasOwnProperty("label"))
      $(el)
        .parent()
        .parent()
        .find('label[for="' + Shiny.$escape(el.id) + '"]')
        .text(data.label);

    $(el).trigger("change");
  },

  // This returns a full description of the input's state.
  // Note that some inputs may be too complex for a full description of the
  // state to be feasible.
  getState: function(el) {
    return {
      label: $(el)
        .parent()
        .parent()
        .find('label[for="' + Shiny.$escape(el.id) + '"]')
        .text(),
      value: el.value
    };
  },

  // The input rate limiting policy
  getRatePolicy: function() {
    return {
      // Can be 'debounce' or 'throttle'
      policy: "debounce",
      delay: 500
    };
  }
});

Shiny.inputBindings.register(knobInputBinding, "shinyWidgets.knobInput");

