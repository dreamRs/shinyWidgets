
// Sweet-Alert Bindings

Shiny.addCustomMessageHandler('sweetalert-sw', function(data) {
  if (data.as_html) {
    var elsw = document.createElement("span");
    elsw.innerHTML = data.text;
    // data.text = "elsw";
    swal({
      title: data.title,
      content: elsw,
      icon: data.icon,
      buttons: data.buttons,
      closeOnClickOutside: data.closeOnClickOutside
    })
    .then(function(value){
      var els = $("#" + data.sw_id);
      els.each(function (i, el) {
        window.Shiny.unbindAll(el, true);
        $(el).remove();
        return true;
      });
    });
  } else {
    swal(data);
  }
});


Shiny.addCustomMessageHandler('sweetalert-sw-confirm', function(data) {
  //var id = data.id;
  //data.id = null;
  Shiny.onInputChange(data.id, null);
  if (!data.as_html) {
    swal(data).then(function(value) {
      if (value) {
        Shiny.onInputChange(data.id, true);
      } else {
        Shiny.onInputChange(data.id, false);
      }
    });
  } else {
    var elsw = document.createElement("span");
    elsw.innerHTML = data.text;
    swal({
      title: data.title,
      content: elsw,
      icon: data.icon,
      buttons: data.buttons,
      dangerMode: data.dangerMode,
      closeOnClickOutside: data.closeOnClickOutside
    })
    .then(function(value){
      if (value) {
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
  //var id = data.id;
  //data.id = null;
  swal(data).then(function(value) {
    if (value) {
      Shiny.onInputChange(data.id, value);
    } else {
      Shiny.onInputChange(data.id, value);
    }
  });
});


Shiny.addCustomMessageHandler('sweetalert-sw-progress', function(data) {
  var itm = document.getElementById(data.idel);
  itm.style.display = "block";
  data.content = itm;
  //document.getElementById(data.idel).remove();
  swal(data);
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
  swal.close();
});
