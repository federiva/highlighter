#' Highlighter
#'
#' Highlights code
#'
#' @param code The code to be highlighted
#' @param language The programming language chosen to be highlighted
#' @param plugins Optional. A list of plugins to be used
#' @param width Optional. The width to be used by the widget
#' @param height Optional. The height to be used by the widget
#' @param elementId Optional. The DOM element id to be used by the widget
#' @import htmlwidgets
#'
#' @export
highlighter <- function(code, language = "r", plugins = NULL, width = "100%", height = "auto", elementId = NULL) {
  assert_language_is_available(language)
  assert_plugin_definitions(plugins)
  # forward options using x
  x = list(
    code = code,
    language = language,
    plugins = plugins
  )
  # create widget
  htmlwidgets::createWidget(
    name = 'highlighter',
    x,
    width = width,
    height = height,
    package = 'highlighter',
    elementId = digest::digest(Sys.time()),
    dependencies = highlighter_dependencies()
  )
}

#' Shiny bindings for highlighter
#'
#' Output and render functions for using highlighter within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a highlighter
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name highlighter-shiny
#'
#' @export
highlighterOutput <- function(outputId, width = '100%', height = 'auto'){
  htmlwidgets::shinyWidgetOutput(outputId, 'highlighter', width, height, package = 'highlighter')
}

#' @rdname highlighter-shiny
#' @export
renderHighlighter <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, highlighterOutput, env, quoted = TRUE)
}


#' Highlighter dependencies
#' @importFrom htmltools htmlDependency
#' @noRd
highlighter_dependencies <- function(theme = "default") {
  htmlDependency(
    name = "highlighter",
    version = "0.1.0",
    package = "highlighter",
    src = "htmlwidgets/lib/prism",
    script = "prism.js",
    stylesheet = "prism.css"
  )
}


#' Utility functions
#' @importFrom htmltools htmlDependency
#' @noRd
custom_utils_dependencies <- function() {
  htmlDependency(
    name = "highlighter",
    version = "0.1.0",
    package = "highlighter",
    src = "htmlwidgets/utils",
    script = "plugins.js"
  )
}


#' Asserts that a file exists
#' @noRd
assert_file_exists <- function(file_path) {
  if (!file.exists(file_path)) {
    rlang::abort(
      message = paste(file_path, "does not exist. Please select a valid file"),
      class = "FileDoesNotExist"
    )
  }
}


#' Highlights the content of a given file
#' @param file_path The path to the file to be highlighted
#' @param language The programming language chosen to be highlighted
#' @param plugins Optional. A list of plugins to be used
#' @export
highlight_file <- function(file_path, language = "r", plugins = NULL) {
  assert_file_exists(file_path)
  code <- paste(
    readLines(file_path),
    collapse = "\n"
  )
  highlighter(code, language, plugins)
}
