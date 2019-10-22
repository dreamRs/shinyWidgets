var numericRangeInputBinding = new Shiny.InputBinding();
$.extend(numericRangeInputBinding, {
  find: function(scope) {
    return $(scope).find('.shiny-numeric-range-input');
  },
  getValue: function(el) {

    var $inputs = $(el).find('input');
    var start = $inputs[0].value;
    var end   = $inputs[1].value;


    if (/^\s*$/.test(start))  // Return null if all whitespace
      start = null;
    else if (!isNaN(start))   // If valid Javascript number string, coerce to number
      start = +start;
    else
      start = start;

    if (/^\s*$/.test(end))  // Return null if all whitespace
      end = null;
    else if (!isNaN(end))   // If valid Javascript number string, coerce to number
      end = +end;
    else
      end = end;

    return [start, end];
  },
  setValue: function(el, value) {
    el.find('input')[0].value = value[0];
    el.find('input')[1].value = value[1];
  },
  subscribe: function(el, callback) {
    $(el).on("change.numericRangeInputBinding", function(e) {
      callback();
    });
  },
  receiveMessage: function(el, data) {
      var $el = $(el);

      //if (data.hasOwnProperty('label')) $el.find('label[for="' + $escape(el.id) + '"]').text(data.label);

      if (data.hasOwnProperty('value'))
        $el.find('input')[0].value = data.value[0];
        $el.find('input')[1].value = data.value[1];

      $(el).trigger('change');
    },
  unsubscribe: function(el) {
    $(el).off(".numericRangeInputBinding");
  }
});

Shiny.inputBindings.register(numericRangeInputBinding,"wd.numericRangeInputBin");
