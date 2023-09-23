available_plugins <- c("line_number", "highlight")

#' Line Number plugin
#'
#' @param use_line_number Logical
#' @param start_from A numeric indicating where to start to count from
#'
#' @return A list (named) with the name of the plugin, the class passed to the
#' render function and the line number in which the line numbers will start
#' from (optional).
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'   highlighter::highlighter(
#'     "print('Hello, world!')\ncat <- \"Aristofanes\"\nstr(some_variable)",
#'     language = "r",
#'     plugins = list(
#'       line_number(
#'         use_line_number = TRUE,
#'         start_from = 2
#'       )
#'     )
#'   )
#' }
#'
line_number <- function(use_line_number = TRUE, start_from = 1) {
  if (use_line_number) {
    list(
      plugin_name = "line_number",
      class = "line-numbers",
      `data-start` = start_from
    )
  } else {
    list(
      plugin_name = "line_number",
      class = "no-line-numbers"
    )
  }
}

#' Line highlight plugin
#'
#' @param range A character indicating the range to be used, for example 2-5
#' will highlight from 2 up to 5. Also you can highlight two or more ranges in
#' the following way 2-5,10-13,19.
#'
#' @return A list (named) with the name of the plugin and the range passed
#' by the function
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'   highlighter::highlighter(
#'     "print('Hello, world!')\ncat <- \"Aristofanes\"\nstr(some_variable)",
#'     language = "r",
#'     plugins = list(
#'       highlight(
#'         range = "1-2"
#'       )
#'     )
#'   )
#' }
#'
highlight <- function(range) {
  list(
    plugin_name = "highlight",
    `data-line` = range
  )
}
