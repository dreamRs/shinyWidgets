// ProgressBars bindings
Shiny.addCustomMessageHandler("update-progressBar-shinyWidgets", function(
  data
) {
  var id = data.id;
  var el = document.getElementById(id);
  var elVal = document.getElementById(id + "-value");
  var elTot = document.getElementById(id + "-total");
  var elTitle = document.getElementById(id + "-title");
  var total = data.total;
  var value = Math.round(data.value);
  var pct;
  if (total > 0) {
    pct = Math.round((value / total) * 100);
    if (elVal !== null)
      elVal.innerText = value;
    if (elTot !== null)
      elTot.innerText = total;
    value = Math.round((value / total) * 100);
  } else {
    pct = data.percent > 0 ? data.percent : value;
  }
  el.style.width = pct + "%";
  var txt = el.innerText;
  if (txt !== "") {
    //value.display_pct !== undefined
    el.innerText = value + data.unit_mark;
  }
  if (data.status !== null) {
    el.className = "";
    el.classList.add("progress-bar");
    el.classList.add("progress-bar-" + data.status);
  }
  if (data.title !== null) {
    elTitle.innerText = data.title;
  }
});

