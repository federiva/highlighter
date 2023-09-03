available_languages <- readLines("inst/assets/languages")

#' List the available languages that can be used to highlight
#' @export
get_available_languages <- function() {
  available_languages
}

#' importFrom rlang abort
#' @noRd
assert_language_is_available <- function(language) {
  test <- language %in% available_languages
  if (!test) {
    rlang::abort(
      message = paste(language, "is not a valid language. Check get_available_languages() for the supported ones"),
      class = "languageNotAvailable"
    )
  }
  invisible()
}

assert_plugin_definitions <- function(plugins) {
  TRUE
}
