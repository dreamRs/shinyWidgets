// Stati Cards bindings

/*jshint
  jquery:true
*/
/*global bounty, Shiny */

var shinyMode =
  typeof window.Shiny !== "undefined" && !!window.Shiny.inputBindings;

var statiUtils = {
  forEach: function(values, callback, thisArg) {
    if (values.forEach) {
      values.forEach(callback, thisArg);
    } else {
      for (var i = 0; i < values.length; i++) {
        callback.call(thisArg, values[i], i, values);
      }
    }
  },
  escapeRegExp: function(str) {
    return str.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&");
  },
  hasClass: function(el, className) {
    var re = new RegExp("\\b" + statiUtils.escapeRegExp(className) + "\\b");
    return re.test(el.className);
  },
  respondToVisibility: function(element, callback) {
    var options = {
      root: document.documentElement
    };

    var observer = new IntersectionObserver(function(entries, observer) {
      entries.forEach(function(entry) {
        callback(entry.intersectionRatio > 0);
      });
    }, options);

    observer.observe(element);
  }
};

function statiInit(el) {
  if (!statiUtils.hasClass(el, "stati-card-animated")) return;
  if (statiUtils.hasClass(el, "stati-card-animated-rendered")) return;
  var animation = bounty.default({
    el: "#" + el.id,
    value: el.dataset.value,
    lineHeight: 1.35,
    duration: el.dataset.duration
  });
  statiUtils.respondToVisibility(el, function(visible) {
    if (!visible) {
      animation.pause();
    } else {
      animation.resume();
    }
  });
  el.className = el.className + " stati-card-animated-rendered";
}

function statiInitAll() {
  var cards = document.querySelectorAll(".stati-card-animated");
  statiUtils.forEach(cards, statiInit);
}

if (shinyMode) {
  var statiCardBinding = new Shiny.InputBinding();
  $.extend(statiCardBinding, {
    initialize: function(el) {
      statiInit(el);
    },
    find: function(scope) {
      return $(scope).find(".stati-value");
    },
    getId: function(el) {
      return el.id;
    },
    getValue: function(el) {
      return;
    },
    setValue: function setValue(el, value) {},
    receiveMessage: function(el, data) {
      if (statiUtils.hasClass(el, "stati-card-animated")) {
        bounty.default({
          el: "#" + el.id,
          value: data.value,
          initialValue: el.dataset.value,
          lineHeight: 1.35,
          duration: data.duration
        });
        el.dataset.value = data.value;
      } else {
        el.innerHTML = data.value;
      }
    },
    subscribe: function(el, callback) {
      $(el).on("click", function(event) {
        callback();
      });
    },
    unsubscribe: function(el) {
      $(el).off(".statiCardBinding");
    }
  });
  Shiny.inputBindings.register(statiCardBinding, "shinyWidgets.statiCard");
} else {
  if (document.addEventListener) {
    document.addEventListener(
      "DOMContentLoaded",
      function() {
        document.removeEventListener(
          "DOMContentLoaded",
          arguments.callee,
          false
        );
        statiInitAll();
      },
      false
    );
  } else if (document.attachEvent) {
    document.attachEvent("onreadystatechange", function() {
      if (document.readyState === "complete") {
        document.detachEvent("onreadystatechange", arguments.callee);
        statiInitAll();
      }
    });
  }
}

