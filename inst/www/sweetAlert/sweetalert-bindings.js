
// Sweet-Alert Bindings

Shiny.addCustomMessageHandler('sweetalert-sw', function(data) {
  if (data.as_html) {
    var elsw = document.createElement("span");
    elsw.innerHTML = data.text;
    data.html = elsw;
    Swal.fire(data)
      .then(function(value){
        var els = $("#" + data.sw_id);
        els.each(function (i, el) {
          window.Shiny.unbindAll(el, true);
          $(el).remove();
          return true;
        });
      });
  } else {
    Swal.fire(data);
  }
});


Shiny.addCustomMessageHandler('sweetalert-sw-confirm', function(data) {
  //var id = data.id;
  //data.id = null;
  Shiny.onInputChange(data.id, null);
  if (!data.as_html) {
    Swal.fire(data).then(function(result) {
      if (result.value) {
        Shiny.onInputChange(data.id, true);
      } else {
        Shiny.onInputChange(data.id, false);
      }
    });
  } else {
    var elsw = document.createElement("span");
    elsw.innerHTML = data.text;
    data.html = elsw;
    Swal.fire(data)
      .then(function(result) {
        if (result.value) {
          Shiny.onInputChange(data.id, true);
        } else {
          Shiny.onInputChange(data.id, false);
        }
        var els = $("#" + data.sw_id);
        els.each(function (i, el) {
          window.Shiny.unbindAll(el, true);
          $(el).remove();
          return true;
        });
      });
  }
});


Shiny.addCustomMessageHandler('sweetalert-sw-input', function(data) {
  Shiny.onInputChange(data.id, null);
  Swal.fire(data).then(function(result) {
    Shiny.onInputChange(data.id, result.value);
  });
});


Shiny.addCustomMessageHandler('sweetalert-sw-progress', function(data) {
  var itm = document.getElementById(data.idel);
  itm.style.display = "block";
  data.content = itm;
  //document.getElementById(data.idel).remove();
  Swal.fire(data);
});


Element.prototype.remove = function() {
    this.parentElement.removeChild(this);
};
NodeList.prototype.remove = HTMLCollection.prototype.remove = function() {
    for(var i = this.length - 1; i >= 0; i--) {
        if(this[i] && this[i].parentElement) {
            this[i].parentElement.removeChild(this[i]);
        }
    }
};





Shiny.addCustomMessageHandler('sweetalert-sw-close', function(data) {
  Swal.close();
});
