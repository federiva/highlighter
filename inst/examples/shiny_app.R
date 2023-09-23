library(shiny)
library(highlighter)
library(stringr)

# Listing this package files
package_files <- list.files(
  path.package(package = "highlighter"),
  recursive = TRUE
) |>
  str_subset(pattern = "docs", negate = TRUE) |>
  str_subset(pattern = ".css", negate = TRUE)

ui <- fluidPage(
  h1("Highlighter example"),
  hr(),
  div(
    style = "padding: 1rem;",
    selectizeInput(
      inputId = "file",
      label = "Select a file",
      choices = package_files,
      selected = "inst/examples/shiny_app.R"
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
)

server <- function(input, output, session) {

  output$code <- renderHighlighter({
    shiny::req(shiny::isTruthy(input$language))
    highlight_file(
      file_path = file.path(
        path.package(package = "highlighter"),
        input$file
      ),
      # When language = NULL then highlighter will try to guess it by reading
      # its extension
      language = if (input$autoguess) NULL else input$language,
      theme = "tomorrow_night",
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
