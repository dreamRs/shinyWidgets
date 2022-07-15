/*jshint unused:false*/
// utilities functions
function updateLabel(labelTxt, labelNode) {
  if (typeof labelTxt === "undefined") return;
  if (labelNode.length !== 1) {
    throw new Error("labelNode must be of length 1");
  }
  var emptyLabel = Array.isArray(labelTxt) && labelTxt.length === 0;
  if (emptyLabel) {
    labelNode.addClass("shiny-label-null");
  } else {
    labelNode.text(labelTxt);
    labelNode.removeClass("shiny-label-null");
  }
}

