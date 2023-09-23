available_languages <- readLines("inst/assets/languages")

.available_themes <- c(
  "default", "dark", "funky", "coy", "okaidia", "solarized_light",
  "tomorrow_night", "twilight"
)

available_themes <- setNames(
  paste0("prism_", .available_themes, ".css"),
  .available_themes
)

#' @param theme A character indicating which is the theme to be chosen
#' @noRd
get_theme <- function(theme) {
  if (is.null(theme)) {
    theme <- "default"
  }
  available_themes[[theme]]
}

#' Get the default language
#' @param language A character indicating which is the input language
#' @noRd
get_default_language <- function(language) {
  if (is.null(language)) {
    "r"
  } else if (language == "") {
    "text"
  } else {
    language
  }
}

#' Auto-guess the language to be used by Prism
#'
#' @importFrom cli cli_alert_warning
#' @importFrom glue glue
#' @importFrom utils adist
#' @noRd
autoguess_language <- function(language) {
  input_language <- get_default_language(language)
  # Calculate distances between input language and available languages
  distances <- adist(
    x = input_language,
    y = available_languages,
    ignore.case = TRUE
  )
  index_language <- which(distances == min(distances))
  if (length(index_language) > 0) {
    result_language <- available_languages[index_language[1]]
  } else {
    result_language <- input_language
    cli_alert_warning(
      glue(
        "We weren't able to auto-guess the language as the language {language} was not found.",
        "Check the available languages using `get_available_languages()` and",
        "specify the language parameter accordingly."
      )
    )
  }
  result_language
}

#' Lists the current available Languages
#'
#' @description List the available languages that can be used to highlight
#'
#' @return A character vector that contains the programming languages available
#' to highlight.
#'
#' @export
get_available_languages <- function() {
  available_languages
}

#' Lists the current available themes
#'
#' @description List the available themes that can be used with highlighter
#'
#' @return A character vector with the names of the themes available.
#'
#' @export
get_available_themes <- function() {
  names(available_themes)
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

#' importFrom rlang abort
#' @noRd
assert_theme_is_available <- function(theme) {
  test <- theme %in% names(available_themes)
  if (!test) {
    rlang::abort(
      message = paste(
        theme,
        "is not a valid theme. Check get_available_themes() for the supported ones"
      ),
      class = "themeNotAvailable"
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
