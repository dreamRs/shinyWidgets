import $ from "jquery";
import "shiny";
import Tree from "@widgetjs/tree";

var treeWidgetBinding = new Shiny.InputBinding();

$.extend(treeWidgetBinding, {
  store: [],
  updateStore: (el, instance) => {
    treeWidgetBinding.store[el.id] = instance;
  },
  find: scope => {
    return $(scope).find(".tree-widget");
  },
  getType: el => {
    return "sw.tree";
  },
  getValue: el => {
    var tree = treeWidgetBinding.store[el.id];
    return tree.selectedNodes;
  },
  setValue: (el, value) => {
    var tree = treeWidgetBinding.store[el.id];
    tree.values = value;
  },
  subscribe: (el, callback) => {
    $(el).on("change.treeWidgetBinding", function(e) {
      callback();
    });
  },
  unsubscribe: el => {
    $(el).off(".treeWidgetBinding");
  },
  receiveMessage: (el, data) => {
    if (data.hasOwnProperty("label")) {
      var label = document.getElementById(el.id + "-label");
      label.innerHTML = data.label;
    }
  },
  initialize: el => {
    var data = el.querySelector('script[data-for="' + el.id + '"]');
    var config = JSON.parse(data.text);
    console.log(config);
    config.onChange = function() {
      $(el).trigger("change");
    };
    const tree = new Tree("#" + el.id, config);
    treeWidgetBinding.updateStore(el, tree);
  }
});

Shiny.inputBindings.register(
  treeWidgetBinding,
  "shinyWidgets.treeWidgetBinding"
);

