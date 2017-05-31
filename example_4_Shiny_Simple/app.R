# http://www.buildingwidgets.com/blog/2017/2/7/super-simple-shiny-module-code

library(shiny)

# this will be our super simple module UI and server
# simple UI will be blank to keep it simple
simple_moduleUI <- tagList()
# simple server will return a new runif random number
#   every 1000 milliseconds
simple_module <- function(input, output, session) {
  rctv <- reactive({
    invalidateLater(1000)
    runif(1)
  })
}

# now let's write our app which will use our
#   simple module to fill our textOutput with the random number
# UI will be just a textOutput
ui <- textOutput("randomnum")

server <- function(input, output, session) {
  # server will call our simple_module with "simple" namespace
  rndnum <- callModule(simple_module, "simple")
  # fill textOutput with the random number
  #   returned as a reactive from our callModule
  output$randomnum <- renderText({
    rndnum()
  })
}

# run our app
# use shiny.trace = TRUE if you want to see how namespacing works
# options(shiny.trace = TRUE)
shinyApp(ui, server)