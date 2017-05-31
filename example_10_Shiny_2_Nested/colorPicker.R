# Module UI function
colorPickerInput <- function(id, label = "Coloring" ) {
  # Create a namespace function using the provided id
  ns <- NS(id)
  tagList(
    selectInput(ns("scheme"), label = label, choices = c("Dark2" = "Dark2", "Set1" = "Set1", "Set2" = "Set2"), selected = "Dark2"),
    checkboxInput(ns("reverse"), label = "Reverse scheme"),
    sliderInput(ns("transparency"), label = "Transparency", min = 0, max = 1, value = 1)
  )
}

# Module server function
colorPicker <- function(input, output, session, stringsAsFactors) {
  observe({
    msg <- paste("Color scheme was selected", input$scheme)
    cat(msg, "\n")
  })
  return(input)
}

