// initialize the input binding
var dollarInputbinding = new Shiny.InputBinding();

// extend the default input binding
$.extend(dollarInputbinding, {

  find: function(scope) {
    return $(scope).find("input[type='dollar']");
  },

  getValue: function(el) {
    var value = Number(el.value.replace(/[\$,]/g,""));
    return value;
  },

  subscribe: function(el, callback) {
    $(el).on('keyup.urlInputBinding input.urlInputBinding', function(event) {
      var clean_input = el.value.replace(/[\D\s\._\-]+/g, "");
      var clean_input = "$" + clean_input.replace(/(.)(?=(\d{3})+$)/g,'$1,');
      el.value = clean_input;
      callback(true);
    });
  }

});

// register the input binding
Shiny.inputBindings.register(dollarInputbinding);
