HTMLWidgets.widget({
  name: 'highlighter',
  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {
        this.element = el;
        this.remove();
        this.createCodeElement(x)
      },

      resize: function(width, height) {
        // TODO: code to re-render the widget with a new size
      },

      remove: function() {
        this.element.childNodes.forEach(el => {
          el.remove()
        })
      },

      createCodeElement: function(x) {
        let preEl = document.createElement("pre");
        const codeEl = document.createElement("code");
        codeEl.classList.add(`language-${x.language}`);
        preEl.appendChild(codeEl);
        this.element.appendChild(preEl);
        codeEl.textContent = x.code;
        preEl = parsePlugins(preEl, x.plugins);
        // Highlight
        setTimeout( () => {
          Prism.highlightElement(codeEl);
        }, 50);
      }

    };
  }
});

/**
 * Removes CSS dependencies from the head element.
 *
 * @param {object} params - an object containing parameters for the removal process
 * @return {void}
 */
removeCSSDependencies = (params) => {
  $("head link[href*='highlighter-css']").remove();
}

Shiny.addCustomMessageHandler("remove_css_dependencies", removeCSSDependencies);
