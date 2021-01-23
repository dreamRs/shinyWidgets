(function() {

  $.initialize(".js-range-slider", function() {
    var skin = $(document).find('script[type="custom-slider-skin"]');
    skin = JSON.parse(skin.html());
    $(this).attr("data-skin", skin.name);
    var slider = $(this).data("ionRangeSlider");
    slider.update({skin: skin.name});
  });

})();
