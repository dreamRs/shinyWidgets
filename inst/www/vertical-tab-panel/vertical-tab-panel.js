
/* Vertical tab panel CSS */
/* By Septian-Bhoechie */
/* Source: https://bootsnipp.com/snippets/featured/simple-vertical-tab */

$(document).ready(function() {
  $("div.vrtc-tab-panel-menu>div.list-group").on("click", "> *", function(e) {
    e.preventDefault();
    $(this)
      .siblings("a.active")
      .removeClass("active");
    $(this).addClass("active");
    $(this).css("display", "");
    var index = $(this).index();
    $(this)
      .parents(".vrtc-tab-panel-container")
      .find("div.vrtc-tab-panel>div.vrtc-tab-panel-content")
      .removeClass("active");
    $(this)
      .parents(".vrtc-tab-panel-container")
      .find("div.vrtc-tab-panel>div.vrtc-tab-panel-content")
      .eq(index)
      .addClass("active");
  });
});

