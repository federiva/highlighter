import Prism from '../inst/htmlwidgets/lib/prism/prism.js';
// Script to output the current available languages
const languages = Object.keys(Prism.languages).join("\n");
console.log(languages);