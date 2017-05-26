

// ProgressBars bindings
Shiny.addCustomMessageHandler('update-progressBar-shinyWidgets', function(data) {
  var id = data.id;
  var total = typeof data.total !== null ? data.total : -1;
  var value = data.value;
  //console.log(data.statusp);
  //var statusp = typeof data.statusp !== 'undefined' ? data.statusp : "none";
  var pct;
  if (total > 0) {
    pct = Math.round(value / total * 100);
    $('#' + id + '-value').text(value);
    $('#' + id + '-total').text(total);
  } else {
    pct = Math.round(value);
  }
  $('#' + id).css('width', pct + '%');
  var txt = $('#' + id).text();
  if (txt !== "") { //value.display_pct !== undefined
    $('#' + id).text(pct + '%');
  }
  if (data.status !== null) {
    $('#' + id).removeClass();
    $('#' + id).addClass("progress-bar progress-bar-" + data.status);
  }
});



