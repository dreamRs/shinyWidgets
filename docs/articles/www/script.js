
//////////////////// Custom JS to simulate shiny


// Bootstrap switch

$('#bsSwitch').on('switchChange.bootstrapSwitch', function(event, state) {
  if (state === true) {
    $('#bsSwitchTrue').css('display', 'block');
    $('#bsSwitchFalse').css('display', 'none');
  } else {
    $('#bsSwitchTrue').css('display', 'none');
    $('#bsSwitchFalse').css('display', 'block');
  }
});



// Material Switch

$("#maSwitch").on("change", function() {
  var ckd = $("#maSwitch").is(':checked');
  if (ckd) {
    $("#resMaSwitch").text("## [1] TRUE");
  } else {
    $("#resMaSwitch").text("## [1] FALSE");
  }
});



// Checkbox Btn 

$("#checkBtn").on("change", function() {
  var $objs = $('input:checkbox[name="checkBtn"]:checked');
  var values = new Array($objs.length);
  $("#resCheckBtn").text("## [1] ");
  if ($objs.length === 0) {
    $("#resCheckBtn").append("NULL");
  }
  for (var i = 0; i < $objs.length; i++) {
    //values[i] = $objs[i].value;
    $("#resCheckBtn").append("\"" + $objs[i].value + "\" ");
  }
});


// Radio btn

$("#radioBtn").on("change", function() {
  var rdo = $('input:radio[name="radioBtn"]:checked');
  $("#resRadioBtn").text("## [1] \"" + rdo.val() + "\"");
});



// Search Bar

$('#sesearchBar').on('keyup', function(event) {
   if(event.keyCode == 13) { //if enter
	  $("#resSearchBar").text("## [1] \"" + $('#sesearchBar').val() + "\"");
   }
 });
$('#searchsearchBar').on('click', function(event) { // on click
  $("#resSearchBar").text("## [1] \"" + $('#sesearchBar').val() + "\"");
});
$('#resetsearchBar').on('click', function(event) { // on click
  $('#sesearchBar').val('');
  $("#resSearchBar").text("## [1] \"\"");
});



// Select Picker

$("#picker").on('changed.bs.select', function (event) {
  var values = $("#picker").val();
  console.log(values);
  $("#resPicker").text("## [1] ");
  if (values === null) {
    $("#resPicker").append("NULL");
  } else {
    for (var i = 0; i < values.length; i++) {
      $("#resPicker").append("\"" + values[i] + "\" ");
    }
  }
});




// Progress bars

$("#slider1").bootstrapSlider();
$("#slider1").on("slide", function(slideEvt) {
  $('#progress01').css('width', slideEvt.value + '%');
});

$("#slider2").bootstrapSlider();
$("#slider2").on("slide", function(slideEvt) {
  $('#progress02').css('width', Math.round(slideEvt.value/50) + '%');
  $('#progress02').text(Math.round(slideEvt.value/50) + '%');
  $('#progress02-value').text(slideEvt.value);
});


