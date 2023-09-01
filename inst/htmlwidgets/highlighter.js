HTMLWidgets.widget({
  name: 'highlighter',
  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {

        // TODO: code to render the widget, e.g.
        window.coso = el;
        window.para = x;
        preEl = document.createElement("pre");
        codeEl = document.createElement("code");
        window.codeEl = codeEl;
        codeEl.classList.add("language-r");
        preEl.appendChild(codeEl);
        el.appendChild(preEl);
        codeEl.textContent = x.message;
        console.log("appendiodsadasng")
        Prism.highlightElement(codeEl)
      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});