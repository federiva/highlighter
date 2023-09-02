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
  highlighterOutput("coso")
)

server <- function(input, output, session) {
  output$coso <- renderHighlighter({
    req(isTruthy(input$language))
    highlight_file(
      file_path = file.path(
        path.package(package = "highlighter"),
        input$file
      ),
      language = input$language
    )
  })
}

shinyApp(ui, server)
