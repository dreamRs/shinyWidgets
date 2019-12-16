// Vertical Tab Input binding

var shinyMode = typeof(window.Shiny) !== "undefined" && !!window.Shiny.inputBindings;

if (shinyMode) {
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
        } else if (data.hasOwnProperty('validate')) {
          if($el.children(".active").length === 0 && $el.children().length > 0) {
            $el.children().last().click();
          }
        } else if (data.hasOwnProperty('reorder')) {
          var items = $el.children();
          items.detach();
          $el.append( $.map(data.reorder, function(v) { return items[v - 1]; }) );
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
}
