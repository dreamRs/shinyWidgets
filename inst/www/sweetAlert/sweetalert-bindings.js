
// Sweet-Alert Bindings

Shiny.addCustomMessageHandler('sweetalert-sw', function(data) {swal(data)});


Shiny.addCustomMessageHandler('sweetalert-sw-confirm', function(data) {
  var id = data.id;
  data.id = null;
  swal(data).then(function(value) {
    if (value) {
      Shiny.onInputChange(data.id, true);
    } else {
      Shiny.onInputChange(data.id, false);
    }
  });
});

