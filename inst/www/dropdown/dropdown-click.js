

// dropdown input binding
var exportsDropdown = window.Shiny = window.Shiny || {};
var $escapeDropdown = exportsDropdown.$escape = function(val) {
  return val.replace(/([!"#$%&'()*+,.\/:;<=>?@\[\\\]^`{|}~])/g, '\\$1');
};

var dropdownInputBinding = new Shiny.InputBinding();
  $.extend(dropdownInputBinding, {
    initialize: function initialize(el) {
      $(el).on('click', function(event){
        var events = $._data(document, 'events') || {};
        events = events.click || [];
        for(var i = 0; i < events.length; i++) {
            if(events[i].selector) {

                //Check if the clicked element matches the event selector
                if($(event.target).is(events[i].selector)) {
                    events[i].handler.call(event.target, event);
                }

                // Check if any of the clicked element parents matches the
                // delegated event selector (Emulating propagation)
                $(event.target).parents(events[i].selector).each(function(){
                    events[i].handler.call(this, event);
                });
            }
        }
        event.stopPropagation(); //Always stop propagation
      });
    },
    find: function(scope) {
      return $(scope).find('.btn-dropdown-input');
    },
    getId: function(el) {
      return el.id;
    },
    getValue: function(el) {
      return '';
    },
    subscribe: function(el, callback) {
      $(el).on('change', function (event) {
        callback();
      });
    },
    unsubscribe: function(el) {
      $(el).off('.dropdownInputBinding');
    }
});
Shiny.inputBindings.register(dropdownInputBinding, 'shiny.dropdownInput');

function dropBtn(id, easyClose) {
  if (easyClose) {
    $(id).on('click', function(event){
      var events = $._data(document, 'events') || {};
      events = events.click || [];
      for(var i = 0; i < events.length; i++) {
          if(events[i].selector) {

              //Check if the clicked element matches the event selector
              if($(event.target).is(events[i].selector)) {
                  events[i].handler.call(event.target, event);
              }

              // Check if any of the clicked element parents matches the
              // delegated event selector (Emulating propagation)
              $(event.target).parents(events[i].selector).each(function(){
                  events[i].handler.call(this, event);
              });
          }
      }
      event.stopPropagation(); //Always stop propagation
    });
  } else {
    $(id).on({
      "shown.bs.dropdown": function() { this.closable = false; },
      "click":             function() { return true; },
      "hide.bs.dropdown":  function() { return false; }
    });
  }
}


Shiny.addCustomMessageHandler('toggle-dropdown-button', function(data) {
  var elpar = $('#' + data.id).parent();
  //if (!elpar.is("open")) {
    $('#' + data.id).dropdown('toggle');
  //}
  //$('#' + data.id).trigger('click.bs.dropdown');
});

