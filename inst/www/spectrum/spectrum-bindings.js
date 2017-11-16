
// spectrumInput bindings //
// by VP 4 dreamRs //


var exportsSpectrum = window.Shiny = window.Shiny || {};
var $escapeSearch = exportsSpectrum.$escape = function(val) {
  return val.replace(/([!"#$%&'()*+,.\/:;<=>?@\[\\\]^`{|}~])/g, '\\$1');
};

var spectrumInputBinding = new Shiny.InputBinding();
$.extend(spectrumInputBinding, {
  find: function(scope) {
  	return $(scope).find('.sw-spectrum');
  },
  getId: function(el) {
  	return $(el).attr('id');
  },
  getValue: function(el) {
  	//return el.value;
  	return $(el).spectrum("get").toHexString();
  },
  setValue: function(el, value) {
  	$(el).spectrum("set", value);
  },
  subscribe: function(el, callback) {
   $(el).on('change move.spectrum', function(event) {
     callback();
   });
  },
  unsubscribe: function(el) {
  	$(el).off('.spectrumInputBinding');
  },
  receiveMessage: function(el, data) {
  	if (data.hasOwnProperty('value'))
  	this.setValue(el, data.value);

  	//if (data.hasOwnProperty('label'))
  	//$(el).parent().find('label[for=' + el.id + ']').text(data.label);

  	$(el).trigger('change');
  },
  getState: function(el) {
  	return {
    	//label: $(el).parent().find('label[for=' + el.id + ']').text(),
    	value: this.getValue(el)//el.value
  	};
  },
  initialize: function initialize(el) {
    var opts = {};
    $(el).spectrum(opts);
  }
});
Shiny.inputBindings.register(spectrumInputBinding, 'shiny.spectrumInput');
