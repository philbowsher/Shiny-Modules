# http://zevross.com/blog/2016/04/19/r-powered-web-applications-with-shiny-a-tutorial-and-cheat-sheet-with-40-example-apps/#shiny-modules

library(ggplot2)

# MODULE UI
scatterUI <- function(id) {
  ns <- NS(id)
  
  list(
    div(sliderInput(ns("slider1"), label = "Limit points", min = 0, max = 60, value = 30)),
    div(style="display: inline-block; height:220px;", plotOutput(ns("plot1"))),
    div(style="display: inline-block; height:220px;", plotOutput(ns("plot2")))
  )
}

# MODULE Server
scatter <- function(input, output, session, datname, var1, var2, ptshape, col1, col2) {
  
  dat <- eval(as.name(datname))
  dat <- dat[order(dat[[var1]]),]
  
  resultdata <- reactive({
    dat[1:input$slider1,]
  })
  
  output$plot1 <- renderPlot({
    plot(1:10)
    ggplot(resultdata(), aes_string(var1, var2)) + geom_point(color=col1, shape=ptshape, size=3)+
      ggtitle(paste("Using the", datname, "data.frame"))
  }, width=200, height=200)
  
  output$plot2 <- renderPlot({
    plot(1:10)
    ggplot(resultdata(), aes_string(var1, var2)) + geom_point(color=col2, shape=ptshape, size=3) +
      ggtitle(paste("Using the", datname, "data.frame"))
  }, width=200, height=200)
}


# App ui
ui <- fluidPage(
  h3("The module creates two plots and a slider and is called twice below"),
  scatterUI("prefix"),
  scatterUI("prefix2")
)

# App server
server <- function(input, output,session){
  
  callModule(scatter, "prefix", "ToothGrowth", "len", "dose",  1, "red", "blue")
  callModule(scatter, "prefix2", "ToothGrowth", "dose", "len", 17, "forestgreen", "purple")
}

shinyApp(ui, server)