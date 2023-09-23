#' Highlighter
#'
#' Highlights code
#'
#' @param code The code to be highlighted
#' @param language The programming language chosen to be highlighted
#' @param theme A character. Indicating which theme will be used
#' @param plugins Optional. A list of plugins to be used
#' @param width Optional. The width to be used by the widget
#' @param height Optional. The height to be used by the widget
#' @param elementId Optional. The DOM element id to be used by the widget
#' @import htmlwidgets
#'
#' @seealso [get_available_languages()] for available languages,
#' [get_available_themes()] for available themes
#'
#' @return An object of class `highlighter`
#'
#' @export
#' @examples
#' # Highlight R code
#' if (interactive()) {
#'   highlighter("print('Hello, world!')", language = "r")
#' }
highlighter <- function(code, language = "r", theme = "default", plugins = NULL,
                        width = "100%", height = "auto", elementId = NULL) { # nolint object_name_linter
  assert_language_is_available(language)
  assert_plugin_definitions(plugins)
  assert_theme_is_available(theme)

  # forward options using x
  x <- list(
    code = code,
    language = language,
    plugins = plugins
  )
  # create widget
  htmlwidgets::createWidget(
    name = "highlighter",
    x,
    width = width,
    height = height,
    package = "highlighter",
    elementId = elementId,
    dependencies = highlighter_dependencies(get_theme(theme)),
    preRenderHook = pre_render_hook
  )
}

pre_render_hook <- function(instance) {
  instance
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
#' @name highlighterOutput
#'
#' @return An object of class `shiny.tag.list`
#'
#' @export
highlighterOutput <- function(outputId, width = "100%", height = "auto") { # nolint object_name_linter
  htmlwidgets::shinyWidgetOutput(
    outputId,
    "highlighter",
    width,
    height,
    package = "highlighter"
  )
}

#' @rdname highlighterOutput
#'
#' @return An object of class `shiny.render.function`
#'
#' @export
renderHighlighter <- function(expr, env = parent.frame(), quoted = FALSE) { # nolint object_name_linter
  if (!quoted) {
    expr <- substitute(expr)
  } # force quoted
  htmlwidgets::shinyRenderWidget(expr, highlighterOutput, env, quoted = TRUE)
}


#' Highlighter dependencies
#' @importFrom htmltools htmlDependency
#' @noRd
highlighter_dependencies <- function(theme) {
  htmlDependency(
    name = "highlighter",
    version = "0.1.0",
    package = "highlighter",
    src = "htmlwidgets",
    script = "highlighter.js",
    stylesheet = paste0("lib/prism/css/", theme),
    all_files = FALSE
  )
}


#' Highlight Syntax of a File
#'
#' @description Highlights the content of a given file according to the source
#' language, theme and plugins used.
#'
#' @param file_path The path to the file to be highlighted
#' @param language The programming language chosen to be highlighted
#' @param plugins Optional. A list of plugins to be used
#' @param theme A character. Indicating which theme will be used
#' @importFrom tools file_ext
#'
#' @return An object of class `highlighter`
#'
#' @seealso [get_available_languages()] for available languages,
#' [get_available_themes()] for available themes
#' @export
highlight_file <- function(file_path, language = NULL, plugins = NULL, theme = "default") {
  assert_file_exists(file_path)
  if (is.null(language)) {
    file_extension <- file_ext(file_path)
    language <- autoguess_language(file_extension)
  }

  code <- paste(
    readLines(file_path),
    collapse = "\n"
  )
  highlighter(code = code, language = language, plugins = plugins, theme = theme)
}
