#' Line Number plugin
#' @param use_line_number Logical
#' @param start_from A numeric indicating where to start to count from
#' @export
line_number = function(use_line_number = TRUE, start_from = 1) {
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

#' @export
plugins <- structure(
  class = "highlighterPlugins",
  list(
    line_number = line_number
  )
)
