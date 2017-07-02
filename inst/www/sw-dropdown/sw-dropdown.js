
/* sw-dropdown js */

function swDrop(triggerId, swDropdownContentId, swDropdownId, animateIn, animateOut, animateDuration = 1) {

    $('#' + swDropdownContentId).css({"animation-duration" : animateDuration + "s"});


    // Toggle on trigger click
    $('#' + triggerId).on('click', function (e) {

      if ($('#' + swDropdownId).hasClass('sw-show')) {
        //$('.sw-dropdown-content').removeClass('fadeInDown');
        if (animateIn !== "sw-none") {
          $('#' + swDropdownContentId).addClass(animateOut);
          $('#' + swDropdownContentId).one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
            $('#' + swDropdownId).removeClass('sw-show');
            //$('#' + swDropdownContentId).css('display', 'none');
            $('#' + swDropdownContentId).removeClass(animateOut);
          });
        } else {
          $('#' + swDropdownContentId).removeClass('sw-show');
          //$('#' + swDropdownContentId).css('display', 'none');
        }
      } else {
        //$('.sw-dropdown-content').removeClass('fadeOutUp);
        if (animateIn !== "sw-none") {
          $('#' + swDropdownContentId).addClass(animateIn);
          $('#' + swDropdownId).addClass('sw-show');
          //$('#' + swDropdownContentId).css('display', 'block');
          $('#' + swDropdownContentId).one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
            $('#' + swDropdownContentId).removeClass(animateIn);
          });
        } else {
          $('#' + swDropdownId).addClass('sw-show');
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

          if($('#' + swDropdownId).hasClass('sw-show')) {
            if (animateIn !== "sw-none") {
              $('#' + swDropdownContentId).removeClass(animateIn);
              $('#' + swDropdownContentId).addClass(animateOut);
              $('#' + swDropdownContentId).one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
                $('#' + swDropdownId).removeClass('sw-show');
                //$('#' + swDropdownContentId).css('display', 'none');
                $('#' + swDropdownContentId).removeClass(animateOut);
              });
            } else {
              $('#' + swDropdownId).removeClass('sw-show');
              //$('#' + swDropdownContentId).css('display', 'none');
            }
          }

        }
    });
}
