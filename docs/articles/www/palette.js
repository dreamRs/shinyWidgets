

// Select Picker

$("#col_palette").on('changed.bs.select', function (event) {
  var pal = $("#col_palette").val();
  $("#image_pal").attr('src', 'images/pal_' + pal + ".png");
});

