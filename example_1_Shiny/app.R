# http://zevross.com/blog/2016/04/19/r-powered-web-applications-with-shiny-a-tutorial-and-cheat-sheet-with-40-example-apps/#shiny-modules

library(ggplot2)
# module UI
scatterUI <- function(id) {
  ns <- NS(id)
  
  list(
    plotOutput(ns("plot1"))
  )
}

# module server
scatter <- function(input, output, session, my_color) {
  
  output$plot1 <- renderPlot({
    ggplot(mtcars, aes(wt, mpg)) + geom_point(color=my_color, size=2)
  })
}

# app ui
ui <- fluidPage(
  
  h3("This is not part of the module but the plot below was created with a module"),
  scatterUI("prefix")
)

# app server
server <- function(input, output,session){
  
  callModule(scatter, "prefix", "purple")
  
}

shinyApp(ui, server)