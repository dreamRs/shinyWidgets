

// ProgressBars bindings
Shiny.addCustomMessageHandler('update-progressBar-shinyWidgets', function(data) {
  var id = data.id;
  var total = data.total;
  var value = Math.round(data.value);
  //console.log(data.statusp);
  //var statusp = typeof data.statusp !== 'undefined' ? data.statusp : "none";
  var pct;
  if (total > 0) {
    pct = Math.round(value / total * 100);
    $('#' + id + '-value').text(value);
    $('#' + id + '-total').text(total);
    value = Math.round(value / total * 100);
  } else {
    pct = data.percent > 0 ? data.percent : value;
  }
  $('#' + id).css('width', pct + '%');
  var txt = $('#' + id).text();
  if (txt !== "") { //value.display_pct !== undefined
    $('#' + id).text(value + data.unit_mark);
  }
  if (data.status !== null) {
    $('#' + id).removeClass();
    $('#' + id).addClass("progress-bar progress-bar-" + data.status);
  }
  if (data.title !== null) {
    $('#' + id + '-title').text(data.title);
  }
});



