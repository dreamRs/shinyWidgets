
/* Vertical tab panel CSS */
/* By Septian-Bhoechie */
/* Source: https://bootsnipp.com/snippets/featured/simple-vertical-tab */

$(document).ready(function() {
    $("div.bhoechie-tab-menu>div.list-group").on('click', '> *', function(e) {
        e.preventDefault();
        $(this).siblings('a.active').removeClass("active");
        $(this).addClass("active");
        $(this).css("display", "");
        var index = $(this).index();
        $(this).parents('.bhoechie-tab-container').find("div.bhoechie-tab>div.bhoechie-tab-content").removeClass("active");
        $(this).parents('.bhoechie-tab-container').find("div.bhoechie-tab>div.bhoechie-tab-content").eq(index).addClass("active");
    });
});
