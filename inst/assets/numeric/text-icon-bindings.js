function updateLabel(labelTxt, labelNode) {
  // Only update if label was specified in the update method
  if (typeof labelTxt === "undefined") return;

  if (labelNode.length !== 1) {
    throw new Error("labelNode must be of length 1");
  } // Should the label be empty?

  var emptyLabel = $.isArray(labelTxt) && labelTxt.length === 0;

  if (emptyLabel) {
    labelNode.addClass("shiny-label-null");
  } else {
    labelNode.text(labelTxt);
    labelNode.removeClass("shiny-label-null");
  }
}

var textInputIconBinding = new Shiny.InputBinding();
$.extend(textInputIconBinding, {
  find: function find(scope) {
    return $(scope).find(".text-input-icon");
  },
  getValue: function getValue(el) {
    return el.value;
  },
  setValue: function setValue(el, value) {
    el.value = value;
  },
  subscribe: function subscribe(el, callback) {
    $(el).on("keyup.textInputIconBinding input.textInputIconBinding", function(
      event
    ) {
      callback(true);
    });
    $(el).on("change.textInputIconBinding", function(event) {
      callback(false);
    });
  },
  unsubscribe: function unsubscribe(el) {
    $(el).off(".textInputIconBinding");
  },
  receiveMessage: function receiveMessage(el, data) {
    if (data.hasOwnProperty("value")) this.setValue(el, data.value);
    updateLabel(data.label, this._getLabelNode(el));
    if (data.hasOwnProperty("placeholder")) el.placeholder = data.placeholder;
    if (data.hasOwnProperty("left")) {
      $(el).prev(".input-group-addon").replaceWith(data.left);
    }
    if (data.hasOwnProperty("right")) {
      $(el).next(".input-group-addon").replaceWith(data.right);
    }
    $(el).trigger("change");
  },
  getState: function getState(el) {
    return {
      label: this._getLabelNode(el).text(),
      value: el.value,
      placeholder: el.placeholder
    };
  },
  getRatePolicy: function getRatePolicy() {
    return {
      policy: "debounce",
      delay: 250
    };
  },
  _getLabelNode: function _getLabelNode(el) {
    return $(el)
      .parent()
      .find('label[for="' + Shiny.$escape(el.id) + '"]');
  }
});
Shiny.inputBindings.register(textInputIconBinding, "shinyWidgets.textInputIcon");

