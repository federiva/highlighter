import Prism from '../inst/htmlwidgets/lib/prism/prism.js';

const languages = Object.keys(Prism.languages).join("\n");
console.log(languages);