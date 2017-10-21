
// Transform each tag with class 'sw-switchInput' to select picker
$(function() {
  $('.selectpicker').each(function() {
    $(this).selectpicker();
  });
});


// picker input binding
var exportsPicker = window.Shiny = window.Shiny || {};
var $escapePicker = exportsPicker.$escape = function(val) {
  return val.replace(/([!"#$%&'()*+,.\/:;<=>?@\[\\\]^`{|}~])/g, '\\$1');
};

var pickerInputBinding = new Shiny.InputBinding();
  $.extend(pickerInputBinding, {
    find: function find(scope) {
      return $(scope).find('.selectpicker');
    },
    getId: function getId(el) {
      return el.id;
    },
    getValue: function getValue(el) {
      return $(el).val();
    },
    setValue: function setValue(el, value) {
      $(el).val(value);
      $(el.id).selectpicker('refresh');
    },
    getState: function getState(el) {
      // Store options in an array of objects, each with with value and label
      var options = new Array(el.length);
      for (var i = 0; i < el.length; i++) {
        options[i] = { value: el[i].value,
          label: el[i].label };
      }

      return {
        label: $(el).parent().find('label[for="' + $escapePicker(el.id) + '"]').text(),
        value: this.getValue(el),
        options: options
      };
    },
    receiveMessage: function receiveMessage(el, data) {
      var $el = $(el);

      // This will replace all the options
      if (data.hasOwnProperty('options')) {
        // Clear existing options and add each new one
        $el.empty().append(data.options);
        $(el.id).selectpicker('refresh');
      }

      if (data.hasOwnProperty('value')) {
        this.setValue(el, data.value);
      }

      if (data.hasOwnProperty('label')) $(el).parent().parent().find('label[for="' + $escapePicker(el.id) + '"]').text(data.label);

      $(el.id).selectpicker('refresh');
      $(el).trigger('change');
    },
    subscribe: function subscribe(el, callback) {
      $(el).on('changed.bs.select', function (event) {
        $(el).selectpicker('refresh');
        callback();
      });
    },
    unsubscribe: function unsubscribe(el) {
      $(el).off('.pickerInputBinding');
    },
    initialize: function initialize(el) {
      $(el).selectpicker();
    }
});
Shiny.inputBindings.register(pickerInputBinding, 'shiny.pickerInput');
