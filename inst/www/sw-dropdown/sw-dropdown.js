
/* sw-dropdown js */

function swDrop(triggerId, swDropdownContentId, swDropdownId, animateIn, animateOut, animateDuration) {

    // $('#' + swDropdownContentId).addClass('sw-dropdown-content');
    $('#' + swDropdownContentId).css({"animation-duration" : animateDuration + "s"});


    // Toggle on trigger click
    $('#' + triggerId).on('click', function (e) {

      if ($('#' + swDropdownContentId).hasClass('sw-show')) {
        //$('.sw-dropdown-content').removeClass('fadeInDown');
        if (animateIn !== 'sw-none') {
          $('#' + swDropdownContentId).addClass(animateOut);
          $('#' + swDropdownContentId).one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
            $('#' + swDropdownContentId).removeClass('sw-show');
            $('#' + swDropdownContentId).hide().trigger('hidden');
            //$('#' + swDropdownContentId).css('display', 'none');
            $('#' + swDropdownContentId).removeClass(animateOut);
          });
        } else {
          $('#' + swDropdownContentId).removeClass('sw-show');
          $('#' + swDropdownContentId).hide().trigger('hidden');
          //$('#' + swDropdownContentId).css('display', 'none');
        }
      } else {
        //$('.sw-dropdown-content').removeClass('fadeOutUp);
        if (animateIn !== "sw-none") {
          $('#' + swDropdownContentId).addClass(animateIn);
          $('#' + swDropdownContentId).addClass('sw-show');
          $('#' + swDropdownContentId).show().trigger('shown');
          //$('#' + swDropdownContentId).css('display', 'block');
          $('#' + swDropdownContentId).one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
            $('#' + swDropdownContentId).removeClass(animateIn);
          });
        } else {
          $('#' + swDropdownContentId).addClass('sw-show');
          $('#' + swDropdownContentId).show().trigger('shown');
          //$('#' + swDropdownContentId).css('display', 'block');
        }
      }

    });


    // Close on click outside dropdown
    $('html').on('click', function (e) {
      //console.log( $(e.target) );
        if (!$('#' + swDropdownId).is(e.target)
            && $('#' + swDropdownId).has(e.target).length === 0
            && $('#' + swDropdownId).find(e.target).length === 0
            && !($(e.target).prop("tagName") === 'A' && $(e.target).attr('role') === 'option') // hack for bootstrap select
            && !($(e.target).prop("tagName") === 'SPAN' && $(e.target).attr('class') === 'text') // hack for bootstrap select
        ) {

          if($('#' + swDropdownContentId).hasClass('sw-show')) {
            if (animateIn !== 'sw-none') {
              $('#' + swDropdownContentId).removeClass(animateIn);
              $('#' + swDropdownContentId).addClass(animateOut);
              $('#' + swDropdownContentId).one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
                $('#' + swDropdownContentId).removeClass('sw-show');
                $('#' + swDropdownContentId).hide().trigger('hidden');
                //$('#' + swDropdownContentId).css('display', 'none');
                $('#' + swDropdownContentId).removeClass(animateOut);
              });
            } else {
              $('#' + swDropdownContentId).removeClass('sw-show');
              $('#' + swDropdownContentId).hide().trigger('hidden');
              //$('#' + swDropdownContentId).css('display', 'none');
            }
          }

        }
    });
}
