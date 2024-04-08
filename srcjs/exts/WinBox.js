import $ from "jquery";
import "shiny";
import WinBox from "winbox/src/js/winbox";
import "winbox/dist/css/winbox.min.css";

let winboxes = {};
let wb_index = 1055;

Shiny.addCustomMessageHandler("WinBox-show", msg => {
  var options = msg.options;
  options.html = `<div id="shiny-winbox-${options.id}"></div>`;
  options.onclose = function() {
    Shiny.unbindAll($content);
    delete winboxes[options.id];
  };
  options.onresize = function(width, height) {
    $("#shiny-winbox-" + options.id)
      .find(".html-widget, .shiny-plot-output")
      .trigger("resize");
  };
  if (winboxes.hasOwnProperty(options.id)) {
    winboxes[options.id].close();
  }
  if (!options.hasOwnProperty("index") && msg.auto_index) {
    var maxZ = Math.max.apply(null,
      $.map($(".winbox"), function(e,n) {
        if ($(e).css('position') != 'static')
          return parseInt($(e).css("z-index")) || 1;
    }));
    if (maxZ > 0) {
      options.index = maxZ;
    } else {
      options.index = wb_index;
    }
  }
  var winbox = new WinBox(options);
  var $content = $("#shiny-winbox-" + options.id);
  Shiny.renderContent($content, { html: msg.html, deps: msg.deps });
  if (!options.hasOwnProperty("height") && msg.auto_height) {
    setTimeout(function() {
      winbox.height = $content.height() + 45;
      winbox.resize();
    }, 100);
  }
  //winbox.focus();
  //winbox.body.innerHTML = msg.html;
  winboxes[winbox.id] = winbox;
});

Shiny.addCustomMessageHandler("WinBox-method", msg => {
  var wb = winboxes[msg.id];
  if (wb !== undefined) {
    //console.log(wb);
    if (msg.method == "resize") {
      wb.resize(msg.args[0], msg.args[1])
    } else if (msg.method == "move") {
      wb.move(msg.args[0], msg.args[1])
    } else {
      if (msg.hasOwnProperty("args")) {
        wb[msg.method](msg.args);
      } else {
        wb[msg.method]();
      }
    }
  }
});

Shiny.addCustomMessageHandler("WinBox-close", msg => {
  if (msg.hasOwnProperty("id")) {
    if (winboxes.hasOwnProperty(msg.id)) {
      winboxes[msg.id].close();
      delete winboxes[msg.id];
    }
  } else {
    var keys = Object.keys(winboxes);
    var last = keys.length - 1;
    if (last > -1) {
      winboxes[keys[last]].close();
      delete winboxes[keys[last]];
    }
  }
});

