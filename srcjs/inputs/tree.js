import $ from "jquery";
import "shiny";
import Tree from "@widgetjs/tree";
import { updateLabel } from "../modules/utils";

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
    if ($(el).attr("data-return") == "all") {
      return "sw.tree.all";
    }
    return "sw.tree";
  },
  getValue: el => {
    var tree = treeWidgetBinding.store[el.id];
    var checked = tree.selectedNodes;
    if (checked.length < 1)
      return null;
    if ($(el).attr("data-return") == "text") {
      checked = checked.map((a) => {
        if (a.status == 2) return a.text[0];
      });
    } else if ($(el).attr("data-return") == "id") {
      checked = checked.map((a) => {
        if (a.status == 2) return a.id[0];
      });
    }
    return checked;
  },
  setValue: (el, value) => {
    var tree = treeWidgetBinding.store[el.id];
    var nodesId = tree.nodesById;
    var checked = Object.entries(nodesId).map((a) => {
      if (value.includes(a[1].text[0])) {
        return a[1].id[0]
      } else {
        return null;
      }
    });
    checked = checked.filter(a => a !== null);
    tree.values = checked;
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
      var label = $("#" + el.id + "-label");
      updateLabel(data.label, label);
    }
    if (data.hasOwnProperty("values")) {
      treeWidgetBinding.setValue(el, data.values);
    }
  },
  initialize: el => {
    var data = el.querySelector('script[data-for="' + el.id + '"]');
    var config = JSON.parse(data.text);
    //console.log(config);
    config.onChange = function() {
      $(el).trigger("change");
    };
    config.loaded = function() {
      $(el).find(".treejs-nodes").first().css("padding-left", 0);
    };
    const tree = new Tree("#" + el.id, config);
    //console.log(tree);
    treeWidgetBinding.updateStore(el, tree);
    if (config.hasOwnProperty("values")) {
      treeWidgetBinding.setValue(el, config.values);
    }
  }
});

Shiny.inputBindings.register(
  treeWidgetBinding,
  "shinyWidgets.treeWidgetBinding"
);
