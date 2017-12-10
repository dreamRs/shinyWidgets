
$(function () {
  $('.dropdown-shinyWidgets').on('click', function(event){
    var events = $._data(document, 'events') || {};
    events = events.click || [];
    for(var i = 0; i < events.length; i++) {
        if(events[i].selector) {

            //Check if the clicked element matches the event selector
            if($(event.target).is(events[i].selector)) {
                events[i].handler.call(event.target, event);
            }

            // Check if any of the clicked element parents matches the
            // delegated event selector (Emulating propagation)
            $(event.target).parents(events[i].selector).each(function(){
                events[i].handler.call(this, event);
            });
        }
    }
    event.stopPropagation(); //Always stop propagation
});
});


Shiny.addCustomMessageHandler('toggle-dropdown-button', function(data) {
  var elpar = $('#' + data.id).parent();
  //if (!elpar.is("open")) {
    $('#' + data.id).dropdown('toggle');
  //}
  //$('#' + data.id).trigger('click.bs.dropdown');
});

