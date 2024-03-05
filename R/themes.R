#' Set Highlighter Theme
#' Sets the highlighter theme globally within the context of a Shiny App
#' @param theme A character. Indicating which theme will be used
#' @importFrom htmltools htmlDependency attachDependencies
#' @importFrom shiny insertUI tags
#' @importFrom digest digest
#' @export
set_highlighter_theme <- function(theme) {
  version <- digest(Sys.time())
  dep <- htmlDependency(
    name = sprintf("highlighter-css-%s-%s", theme, version),
    version = "0.1.0",
    package = "highlighter",
    src = "htmlwidgets",
    stylesheet = sprintf("lib/prism/css/%s?version=%s", get_theme(theme), version),
    all_files = FALSE
  )

  deps_container <- attachDependencies(
    tags$head(),
    dep
  )
  # Remove previous dependencies
  remove_css_dependencies()
  insertUI("head", ui = deps_container)
}

#' Remove Highlighter CSS dependencies in the browser
#' @noRd
remove_css_dependencies <- function() {
  session <- shiny::getDefaultReactiveDomain()
  session$sendCustomMessage("remove_css_dependencies", "")
}
