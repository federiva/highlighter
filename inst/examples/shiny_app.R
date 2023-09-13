library(shiny)
library(highlighter)
library(stringr)

ui <- fluidPage(
  selectizeInput(
    inputId = "file",
    label = "Select a file",
    choices = list.files(
      path.package(package = "highlighter"),
      recursive = TRUE
    ) |>
      str_subset(pattern = "docs", negate = TRUE) |>
      str_subset(pattern = ".css", negate = TRUE)
  ),
  checkboxInput(
    inputId = "autoguess",
    label = "Auto guess language?",
    value = TRUE
  ),
  selectizeInput(
    inputId = "language",
    label = "Select language",
    choices = highlighter::get_available_languages(),
    selected = "r"
  ),
  highlighterOutput("code")
)

server <- function(input, output, session) {

  output$code <- renderHighlighter({
    shiny::req(shiny::isTruthy(input$language))
    highlight_file(
      file_path = file.path(
        path.package(package = "highlighter"),
        input$file
      ),
      language = if (input$autoguess) NULL else input$language,
      theme = "solarized_light",
      plugins = list(
        line_number(
          use_line_number = TRUE,
          start_from = 3
        ),
        highlight(
          range = "7-10,13"
        )
      )
    )
  })
}

shinyApp(ui, server)
