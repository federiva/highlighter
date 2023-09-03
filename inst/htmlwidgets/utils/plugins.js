/**
 * Adds line numbers to a <pre> element based on a specified plugin definition.
 *
 * @param {HTMLElement} preEl - The <pre> element to which line numbers will be added.
 * @param {Object} pluginDefinition - The plugin definition containing configuration details.
 * @param {string} pluginDefinition.plugin_name - The name of the plugin, should be "line_number".
 * @param {string} pluginDefinition.class - The CSS class to apply to the <pre> element for styling.
 * @param {string} [pluginDefinition.data-start] - Optional attribute to specify the starting line number.
 * 
 * @returns {HTMLElement} The modified <pre> element with line numbers added.
 */
const useLineNumber = (preEl, pluginDefinition) => {
  if (pluginDefinition.plugin_name === "line_number") {
    preEl.classList.add(pluginDefinition.class);
    if (!!pluginDefinition["data-start"]) {
      preEl.setAttribute("data-start", pluginDefinition["data-start"]);
    }
  }
  return preEl
}

/**
 * Parses and applies a list of plugins to a <pre> element.
 *
 * @param {HTMLElement} preEl - The <pre> element to which plugins will be applied.
 * @param {Array} plugins - An array of plugin definitions to apply.
 * 
 * @returns {HTMLElement} The modified <pre> element with the specified plugins applied.
 */
const parsePlugins = (preEl, plugins) => {
  plugins.forEach(pluginDefinition => {
    preEl = useLineNumber(preEl, pluginDefinition)
  })
  return preEl
}
