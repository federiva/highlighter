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


#' Remove Highlighter CSS dependencies in the browser
#' @noRd
remove_css_dependencies <- function() {
  session <- shiny::getDefaultReactiveDomain()
  if (!is.null(session)) {
    session$sendCustomMessage("remove_css_dependencies", "")
  }
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
