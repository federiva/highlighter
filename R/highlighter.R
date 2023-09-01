#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
highlighter <- function(message, width = NULL, height = NULL, elementId = NULL) {

  # forward options using x
  x = list(
    message = message
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'highlighter',
    x,
    width = width,
    height = height,
    package = 'highlighter',
    elementId = elementId,
    dependencies = highlighter_js_dependencies()
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
highlighterOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'highlighter', width, height, package = 'highlighter')
}

#' @rdname highlighter-shiny
#' @export
renderHighlighter <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, highlighterOutput, env, quoted = TRUE)
}


#' Highlighter dependencies
#' @noRd
highlighter_dependencies <- function(theme = "default") {
  htmltools::htmlDependency(
    name = "highlighter",
    version = "0.1.0",
    package = "highlighter",
    src = "htmlwidgets/lib/prism",
    script = "prism.js",
    stylesheet = "prism.css"
  )
}


#' Asserts that a file exists
#' @noRd
assert_file_exists <- function(file_path) {
  TRUE
}


#' Highlights the content of a given file
#' @param file_path The path to the file to be highlighted
#' @export
highlight_file <- function(file_path) {
  assert_file_exists(file_path)
  text <- paste(
    readLines(file_path),
    collapse = "\n"
  )
  highlighter(text)
}
