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
      message = paste(
        language,
        "is not a valid language. Check get_available_languages() for the supported ones"
      ),
      class = "languageNotAvailable"
    )
  }
  invisible()
}

#' Assert that the plugins passed are available
#' @noRd
assert_plugin_definitions <- function(plugins) {
  all(names(plugins) %in% available_plugins)
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
