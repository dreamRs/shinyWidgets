/* sw-dropdown js */

function swDrop(
  triggerId,
  swDropdownContentId,
  swDropdownId,
  animateIn,
  animateOut,
  animateDuration
) {
  // $('#' + swDropdownContentId).addClass('sw-dropdown-content');
  $("#" + swDropdownContentId).css({
    "animation-duration": animateDuration + "s"
  });

  // Toggle on trigger click
  $("#" + triggerId).on("click", function(e) {
    if ($("#" + swDropdownContentId).hasClass("sw-show")) {
      //$('.sw-dropdown-content').removeClass('fadeInDown');
      if (animateIn !== "sw-none") {
        $("#" + swDropdownContentId).addClass(animateOut);
        $("#" + swDropdownContentId).one(
          "webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend",
          function() {
            $("#" + swDropdownContentId).removeClass("sw-show");
            $("#" + swDropdownContentId)
              .hide()
              .trigger("hidden");
            //$('#' + swDropdownContentId).css('display', 'none');
            $("#" + swDropdownContentId).removeClass(animateOut);
          }
        );
      } else {
        $("#" + swDropdownContentId).removeClass("sw-show");
        $("#" + swDropdownContentId)
          .hide()
          .trigger("hidden");
        //$('#' + swDropdownContentId).css('display', 'none');
      }
    } else {
      //$('.sw-dropdown-content').removeClass('fadeOutUp);
      if (animateIn !== "sw-none") {
        $("#" + swDropdownContentId).addClass(animateIn);
        $("#" + swDropdownContentId).addClass("sw-show");
        $("#" + swDropdownContentId)
          .show()
          .trigger("shown");
        //$('#' + swDropdownContentId).css('display', 'block');
        $("#" + swDropdownContentId).one(
          "webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend",
          function() {
            $("#" + swDropdownContentId).removeClass(animateIn);
          }
        );
      } else {
        $("#" + swDropdownContentId).addClass("sw-show");
        $("#" + swDropdownContentId)
          .show()
          .trigger("shown");
        //$('#' + swDropdownContentId).css('display', 'block');
      }
    }
  });

  // Close on click outside dropdown
  $("html").on("click", function(e) {
    //console.log($(e.target).parents().end().attr('class').indexOf("datepicker"));
    //console.log( $(e.target) );
    var parentClass = $(e.target).parents().end().attr('class');
    if (typeof parentClass == "undefined") {
      parentClass = $(e.target).parents().attr('class');
    }
    if (typeof parentClass == "undefined") {
      parentClass = "";
    }
    if (
      //$(e.target).is("html") |
      !$("#" + swDropdownId).is(e.target) &&
      $("#" + swDropdownId).has(e.target).length === 0 &&
      $("#" + swDropdownId).find(e.target).length === 0 &&
      !(
        $(e.target).parents('.shiny-input-container').length
      ) && // hack for bootstrap select
      !(
        $(e.target).parents('.bootstrap-select').length
      ) && // hack for pickr color
      !(
        $(e.target).parents('.pcr-app').length
      ) && // hack for shinytree
      !(
        $(e.target).prop("tagName") === "I" &&
        $(e.target).attr("class") === "jstree-icon jstree-ocl"
      ) && // hack for DT
      !(
        $(e.target).prop("tagName") === "A" &&
        RegExp("paginate_button").test($(e.target).attr("class")) === true
      ) && // hack for airdatepicker
      (
        parentClass.indexOf("datepicker") < 0
      ) && // hack for airdatepicker2
      (
        parentClass.indexOf("airdatepicker") < 0
      ) && // hack for selectize
      !(
        $(e.target).parents('.selectize-input').length
      ) && // hack for selectize
      !(
        $(e.target).hasClass("remove")
      ) && // hack for selectize
      !(
        $(e.target).prop("tagName") === "DIV" &&
        $(e.target).attr("class") === "selectize-dropdown-content"
      ) &&
      !(
        $(e.target).prop("tagName") === "DIV" &&
        RegExp("option").test($(e.target).attr("class")) === true
      )
    ) {
      if ($("#" + swDropdownContentId).hasClass("sw-show")) {
        if (animateIn !== "sw-none") {
          $("#" + swDropdownContentId).removeClass(animateIn);
          $("#" + swDropdownContentId).addClass(animateOut);
          $("#" + swDropdownContentId).one(
            "webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend",
            function() {
              $("#" + swDropdownContentId).removeClass("sw-show");
              $("#" + swDropdownContentId)
                .hide()
                .trigger("hidden");
              //$('#' + swDropdownContentId).css('display', 'none');
              $("#" + swDropdownContentId).removeClass(animateOut);
            }
          );
        } else {
          $("#" + swDropdownContentId).removeClass("sw-show");
          $("#" + swDropdownContentId)
            .hide()
            .trigger("hidden");
          //$('#' + swDropdownContentId).css('display', 'none');
        }
      }
    }
  });
}

