var dropMenuInputBinding = new Shiny.InputBinding();
$.extend(dropMenuInputBinding, {
  find: function(scope) {
    return $(scope).find(".drop-menu-input");
  },
  getId: function(el) {
    return $(el).attr("id");
  },
  getValue: function(el) {
    return this["instance" + el.id].state.isShown;
  },
  setValue: function(el, value) {},
  subscribe: function(el, callback) {
    this["instance" + el.id].setProps({
      onShown: function(instance) {
        callback();
      },
      onHidden: function(instance) {
        callback();
      }
    });
  },
  unsubscribe: function(el) {
    $(el).off(".dropMenuInputBinding");
  },
  receiveMessage: function(el, data) {
    if (data.hasOwnProperty("action")) {
      if (data.action == "enable") {
        this["instance" + el.id].enable();
      }
      if (data.action == "disable") {
        this["instance" + el.id].disable();
      }
      if (data.action == "show") {
        this["instance" + el.id].show();
      }
      if (data.action == "hide") {
        this["instance" + el.id].hide();
      }
    }
  },
  getState: function(el) {},
  initialize: function initialize(el) {
    var menu = document.getElementById(el.id);

    var config = $(el).find('script[data-for="' + el.id + '"]');
    config = JSON.parse(config.html());
    var target = document.getElementById(menu.dataset.target);
    //var content = document.getElementById(menu.dataset.content);
    var remove = document.getElementById(menu.dataset.remove);

    config.options.interactive = true;
    config.options.onMount = function(instance) {
      Shiny.unbindAll(remove, true);
      remove.innerHTML = "";
      var content = document.getElementById(menu.dataset.content);
      Shiny.initializeInputs(content);
      Shiny.bindAll(content, true);
    };

    this["instance" + el.id] = tippy(target, config.options);

  }
});
Shiny.inputBindings.register(dropMenuInputBinding, "shiny.dropMenuInput");

