

$("#checkBtn").on("click", function() {
  var $objs = $('input:checkbox[name="checkBtn"]:checked');
  var values = new Array($objs.length);
  for (var i = 0; i < $objs.length; i++) {
    values[i] = $objs[i].value;
  }
});

    