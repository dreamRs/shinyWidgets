$('#bsSwitch').on('switchChange.bootstrapSwitch', function(event, state) {
  if (state === true) {
    $('#bsSwitchTrue').css('display', 'block');
    $('#bsSwitchFalse').css('display', 'none');
  } else {
    $('#bsSwitchTrue').css('display', 'none');
    $('#bsSwitchFalse').css('display', 'block');
  }
});