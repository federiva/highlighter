# highlighter
<!-- badges: start -->
[![R-CMD-check](https://github.com/federiva/highlighter/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/federiva/highlighter/actions/workflows/R-CMD-check.yaml)
[![CRAN status](https://www.r-pkg.org/badges/version/highlighter)](https://CRAN.R-project.org/package=highlighter)
<!-- badges: end -->

highlighter is a package used for code syntax highlighting. This package is a  wrapper for the 
[Prism.js](https://prismjs.com/index.html) library implemented using [htmlwidgets](https://www.htmlwidgets.org/).
## Installation

* Using remotes
```R
remotes::install_github("federiva/highlighter")
```

* Using renv
```R
renv::install("federiva/highlighter")
```

## Usage
See the vignettes for more examples.

**Using `highlighter`**
  
We can use the `highglighter` function in order to render and highlight code. By default the function will highlight the 
syntax of R code.

```R
highlighter("some_variable <- 3")
```

If we want we can specify the language using the `language` parameter.

```R
highlighter("const someVariable = 3;", language = "js")
```

**Using `highlight_file`**
  
We can pass the path to a local file using the `highlight_file` function

```R
highlight_file("<path_to_your_file>", language = "r")
```
