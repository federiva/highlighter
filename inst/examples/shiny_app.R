library(shiny)
library(highlighter)

ui <- fluidPage(
  selectizeInput(
    inputId = "file",
    label = "Select a file",
    choices = list.files(path.package(package = "highlighter"), recursive = TRUE)
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
    req(isTruthy(input$language))
    highlight_file(
      file_path = file.path(
        path.package(package = "highlighter"),
        input$file
      ),
      language = input$language,
      plugins = list(
        plugins$line_number(
          use_line_number = TRUE,
          start_from = 5
        )
      )
    )
  })
}

shinyApp(ui, server)
