import $ from "jquery";
import "shiny";
import { updateLabel } from "../modules/utils";
import Treeview from "quercus.js";
import "quercus.js/src/treeview.css";

function findTextInTree(data, targetText) {
    for (const node of data) {
        // Vérifie si le "text" du nœud courant correspond au texte cible
        if (node.text === targetText) {
            return node; // Retourne le nœud si le text correspond
        }
        // Si le nœud a des enfants, recherche récursive
        if (node.children) {
            const result = findTextInTree(node.children, targetText);
            if (result) {
                return result; // Si trouvé dans les enfants, retourne le résultat
            }
        }
    }
    return null; // Retourne null si aucun match trouvé
}


var quercusWidgetBinding = new Shiny.InputBinding();

$.extend(quercusWidgetBinding, {
  store: [],
  updateStore: (el, instance) => {
    quercusWidgetBinding.store[el.id] = instance;
  },
  find: scope => {
    return $(scope).find(".quercus-widget");
  },
  getType: el => {
    if ($(el).attr("data-return") == "all") {
      return "sw.tree.all";
    }
    return "sw.tree";
  },
  getValue: el => {
    var tree = quercusWidgetBinding.store[el.id];
    var checked = tree.getSelectedNodes();
    if (checked.length < 1)
      return null;
    if ($(el).attr("data-return") != "all") {
      var key = $(el).attr("data-return");
      checked = checked.map((a) => {
        return a[key];
      });
    }
    return checked;
  },
  setValue: (el, values) => {
    var tree = quercusWidgetBinding.store[el.id];
    // clear values
    const selectedValues = tree.getSelectedNodes();
    selectedValues.forEach(value => {
      tree.selectNodeById(value.id, false);
    });
    // select the one provided
    for(let i in values) {
      var result = findTextInTree(tree.options.data, values[i]);
      console.log(result);
      if (result) {
        tree.selectNodeById(result.id, true);
      }
    }
  },
  subscribe: (el, callback) => {
    $(el).on("change.quercusWidgetBinding", function(e) {
      callback();
    });
  },
  unsubscribe: el => {
    $(el).off(".quercusWidgetBinding");
  },
  receiveMessage: (el, data) => {
    if (data.hasOwnProperty("label")) {
      var label = $("#" + el.id + "-label");
      updateLabel(data.label, label);
    }
    if (data.hasOwnProperty("data")) {
      var tree = quercusWidgetBinding.store[el.id];
      tree.setData(data.data);
    }
    if (data.hasOwnProperty("selected")) {
      quercusWidgetBinding.setValue(el, data.selected);
    }
    $(el).trigger("change");
  },
  initialize: el => {
    var data = el.querySelector('script[data-for="' + el.id + '"]');
    var config = JSON.parse(data.text);
    //console.log(config);
    config.onSelectionChange = function() {
      $(el).trigger("change");
    };
    const tree = new window.Treeview(config);
    quercusWidgetBinding.updateStore(el, tree);
    if (config.hasOwnProperty("selected")) {
      quercusWidgetBinding.setValue(el, config.selected);
    }
  }
});

Shiny.inputBindings.register(
  quercusWidgetBinding,
  "shinyWidgets.quercusWidgetBinding"
);

