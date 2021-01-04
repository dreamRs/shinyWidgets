// Bounty (animation) for Stati Cards

/*global bounty, Shiny */

(function() {
  var bountyUtils = {
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
      var re = new RegExp("\\b" + bountyUtils.escapeRegExp(className) + "\\b");
      return re.test(el.className);
    }
  };

  function bountyInit() {
    var bountys = document.querySelectorAll(".stati-card-bounty");
    bountyUtils.forEach(bountys, function(el) {
      if (bountyUtils.hasClass(el, "stati-card-bounty-rendered")) return;
      bounty.default({
        el: "#" + el.id,
        value: el.dataset.value,
        lineHeight: 1.35,
        duration: el.dataset.duration
      });
      el.className = el.className + " stati-card-bounty-rendered";
    });
    //setTimeout(bountyInit, 300);
  }
  //bountyInit();

  if (document.addEventListener) {
    document.addEventListener(
      "DOMContentLoaded",
      function() {
        document.removeEventListener(
          "DOMContentLoaded",
          arguments.callee,
          false
        );
        bountyInit();
      },
      false
    );
  } else if (document.attachEvent) {
    document.attachEvent("onreadystatechange", function() {
      if (document.readyState === "complete") {
        document.detachEvent("onreadystatechange", arguments.callee);
        bountyInit();
      }
    });
  }

  const callback = function(mutationsList, observer) {
    bountyInit();
  };
  const observer = new MutationObserver(callback);
  observer.observe(document, {
    attributes: false,
    childList: true,
    subtree: true
  });


  if (typeof window.Shiny !== "undefined") {

    Shiny.addCustomMessageHandler("update-stati-card", function(data) {
      var el = document.getElementById(data.id);
      if (bountyUtils.hasClass(el, "stati-card-bounty")) {
        bounty.default({
          el: "#" + data.id,
          value: data.value,
          initialValue: el.dataset.value,
          lineHeight: 1.35,
          duration: data.duration
        });
        el.dataset.value = data.value;
      } else {
        el.innerHTML = data.value;
      }
    });
  }
})();

