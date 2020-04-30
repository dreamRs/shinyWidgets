var dropMenuInputBinding = new Shiny.InputBinding();
$.extend(dropMenuInputBinding, {
  find: function(scope) {
    return scope.querySelectorAll(".drop-menu-input");
  },
  getId: function(el) {
    return el.id;
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

    var config = menu.querySelector('script[data-for="' + el.id + '"]');
    config = JSON.parse(config.innerHTML);
    var target = document.getElementById(menu.dataset.target);

    config.options.interactive = true;

    // On Show we move the template
    config.options.onShow = function(instance) {
      var template = document.getElementById(menu.dataset.template);
      template.style.display = "block";
      Shiny.bindAll(template, true);
      instance.setContent(template);
    };
    // On Hide we put back the template
    config.options.onHide = function(instance) {
      var cntnt = instance.props.content;
      cntnt.style.display = "none";
      menu.appendChild(cntnt);
      instance.setContent("");
    };
    this["instance" + el.id] = tippy(target, config.options);
  }
});
Shiny.inputBindings.register(dropMenuInputBinding, "shiny.dropMenuInput");

