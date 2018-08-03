// multi input binding
var exportsVerticalTab = window.Shiny = window.Shiny || {};
var $escapeVerticalTab = exportsVerticalTab.$escape = function(val) {
  return val.replace(/([!"#$%&'()*+,.\/:;<=>?@\[\\\]^`{|}~])/g, '\\$1');
};

var VerticalTabInputBinding = new Shiny.InputBinding();
  $.extend(VerticalTabInputBinding, {
    find: function(scope) {
      return $(scope).find('.vertical-tab-panel');
    },
    getId: function(el) {
      return el.id;
    },
    getValue: function(el) {
      return $(el).find(".active").attr("data-value");
    },
    setValue: function setValue(el, value) {

    },
    receiveMessage: function(el, data) {
      var $el = $(el);

      if (data.hasOwnProperty('value')) {
        $el.find("[data-value='" + data.value + "']").click();
      }

    },
    subscribe: function(el, callback) {
      $(el).on('click', function (event) {
        callback();
      });
    },
    unsubscribe: function(el) {
      $(el).off('.VerticalTabInputBinding');
    }
});
Shiny.inputBindings.register(VerticalTabInputBinding, 'shiny.VerticalTabInput');

