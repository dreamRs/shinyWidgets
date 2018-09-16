
// airDatepicker bindings //
// by Vic //


var exportsAirPicker = window.Shiny = window.Shiny || {};
var $escapeAirPicker = exportsAirPicker.$escape = function(val) {
  return val.replace(/([!"#$%&'()*+,.\/:;<=>?@\[\\\]^`{|}~])/g, '\\$1');
};

var AirPickerInputBinding = new Shiny.InputBinding();
$.extend(AirPickerInputBinding, {
  initialize: function initialize(el) {
    var options = {};
    var opdefault = {};
		if ($(el).attr('data-start-date')) {
		  var dateraw = JSON.parse($(el).attr('data-start-date'));
		  //console.log(dateraw);
		  var datedefault = [];
		  for (var i=0; i<dateraw.length; i++) {
		    datedefault[i] = new Date(dateraw[i]); //new Date(dateraw[i]);
		  }
		  //console.log(datada);
			opdefault.startDate = datedefault;
			//console.log(options.startDate);
			$(el).removeAttr('data-start-date');
		}
		if ($(el).attr('data-min-date')) {
		  var minDate = parseFloat($(el).attr('data-min-date'));
		  options.minDate = new Date(minDate);
		  $(el).removeAttr('data-min-date');
		}
		if ($(el).attr('data-max-date')) {
		  var maxDate = parseFloat($(el).attr('data-max-date'));
		  options.maxDate = new Date(maxDate);
		  $(el).removeAttr('data-max-date');
		}

		// disable dates
		if ($(el).attr('data-disabled-dates')) {
		  var disabledDates = JSON.parse($(el).attr('data-disabled-dates'));
		  options.onRenderCell = function(d, type) {
        if (type == 'day') {
    			var disabled = false,
          formatted = getFormattedDate(d);

          disabled = disabledDates.filter(function(date){
            return date == formatted;
          }).length;

    			return {
            disabled: disabled
          };
        }
      };
		  $(el).removeAttr('data-disabled-dates');
		}

		// initialiaze
		var dp;

		if ($(el).attr('data-update-on') === 'close') {

		  options.onHide = function(inst, animationCompleted) {
		    if (animationCompleted){
		      $(el).trigger('change');
		    }
      };
      dp = $(el).datepicker(options).data('datepicker');
		} else {
		  //console.log(options);
		  options.onSelect = function(formattedDate, date, inst) {
        $(el).trigger('change');
      };
      dp = $(el).datepicker(options).data('datepicker');
		}
		$(el).removeAttr('data-update-on');

    dp.selectDate(opdefault.startDate);
  },
  find: function(scope) {
  	return $(scope).find('.sw-air-picker');
  },
  getId: function(el) {
  	return $(el).attr('id');
  },
  getType: function(el) {
    // console.log($(el).attr('data-timepicker') === 'false');
    if ($(el).attr('data-timepicker') !== 'false') {
      return 'air.datetime';
    } else {
      return 'air.date';
    }
  },
  getValue: function(el) {
  	//return el.value;

  	var sd = $(el).datepicker().data('datepicker').selectedDates;
  	var timepicker = $(el).attr('data-timepicker');
  	var res;

  	function padZeros(n, digits) {
      var str = n.toString();
      while (str.length < digits) {
        str = "0" + str;
      }return str;
    }
  	function formatDate(date) {
      if (date instanceof Date) {
        return date.getFullYear() + '-' + padZeros(date.getMonth() + 1, 2) + '-' + padZeros(date.getDate(), 2);
      } else {
        return null;
      }
    }


  	if (sd.length > 0) {
  	  // console.log(sd);
  	  if (timepicker === 'false') {
  	    res = sd.map(function(e) {
    	    //console.log(e);
          return formatDate(e);
        });
  	  } else {
  	    //var tz = new Date().toString().match(/([-\+][0-9]+)\s/)[1];
  	    res = sd.map(function(e) {
    	    //console.log(e);
          return e.valueOf();//toISOString() + tz;
        });
  	    //res = sd ;
  	  }
  	  return res;
  	} else {
  	  return null;
  	}
  },
  setValue: function(el, value) {
    value = JSON.parse(value);
    var newdate = [];
		for (var i=0; i<value.length; i++) {
		  newdate[i] =  new Date(value[i]);
		}

  	$(el).datepicker().data('datepicker').selectDate(newdate);
  },
  subscribe: function(el, callback) {
   $(el).on('change', function(event) {
     callback();
   });
  },
  unsubscribe: function(el) {
  	$(el).off('.AirPickerInputBinding');
  },
  receiveMessage: function(el, data) {
    if (data.clear) {
      $(el).datepicker().data('datepicker').clear();
    }
  	if (data.hasOwnProperty('value')) this.setValue(el, data.value);

    if (data.hasOwnProperty('label')) {
      // console.log(el);
      $(el).parent().parent().find('label[for="' + data.id + '"]').text(data.label);
    }

    if (data.hasOwnProperty('options')) {
      $(el).datepicker().data('datepicker').update(data.options);
    }

    if (data.hasOwnProperty('placeholder')) {
      // why [0] ??
      $('#' + data.id)[0].placeholder = data.placeholder;
    }

    $(el).trigger('change');
  }
});
Shiny.inputBindings.register(AirPickerInputBinding, 'shiny.AirPickerInput');

function parse_date(date) {
  return date.getUTCFullYear() + '-' + date.getUTCMonth() + '-' + date.getUTCDate();
}

Date.prototype.yyyymmdd = function() {
  var mm = this.getMonth() + 1; // getMonth() is zero-based
  var dd = this.getDate();

  return [this.getFullYear(),
          (mm>9 ? '' : '0') + mm,
          (dd>9 ? '' : '0') + dd
         ].join('-');
};

function getFormattedDate(date) {
  var year = date.getFullYear(),
    month = date.getMonth() + 1,
    day = date.getDate();

    if (month > 9) {
      if (day > 9) {
        return year + '-' + month + '-' + day;
      } else {
        return year + '-' + month + '-0' + day;
      }
    } else {
      if (day > 9) {
        return year + '-0' + month + '-' + day;
      } else {
        return year + '-0' + month + '-0' + day;
      }
    }
}

