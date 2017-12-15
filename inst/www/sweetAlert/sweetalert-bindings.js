
// Sweet-Alert Bindings

Shiny.addCustomMessageHandler('sweetalert-sw', function(data) {swal(data)});


Shiny.addCustomMessageHandler('sweetalert-sw-confirm', function(data) {
  //var id = data.id;
  //data.id = null;
  swal(data).then(function(value) {
    if (value) {
      Shiny.onInputChange(data.id, true);
    } else {
      Shiny.onInputChange(data.id, false);
    }
  });
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
