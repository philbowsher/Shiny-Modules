# https://monashbioinformaticsplatform.github.io/2016-11-03-r-shiny/tutorial.html#modules

# Define a trivial module

# In the UI, we use NS( ) to prefix all of the ids
mymodule_ui <- function(id) {
  ns <- NS(id)
  
  div(
    numericInput(ns("number"), "Number", 5),
    textOutput(ns("result")))
}

# callModule( ) will magically prefix ids for us in the server function
mymodule_server <- function(input, output, session, multiply_by) {
  output$result <- renderText({
    paste0(input$number, " times ", multiply_by, " is ", input$number * multiply_by) 
  })
}


# Use the module in an app

ui <- fluidPage(
  titlePanel("Demonstration of modules"),
  h2("Instance 1"),
  mymodule_ui("mod1"),
  h2("Instance 2"),
  mymodule_ui("mod2"))

server <- function(input, output, session) {
  callModule(mymodule_server, "mod1", multiply_by=3)
  callModule(mymodule_server, "mod2", multiply_by=7)
  
  #Debugging
  observe( print(reactiveValuesToList(input)) )
}

shinyApp(ui, server)