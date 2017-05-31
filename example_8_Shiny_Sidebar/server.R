library(shiny)

# Define server logic required to draw a histogram
function(input, output) {
  
  # Call callModule and save the reactive expression to an object "bins"
  bins <- callModule(module = sidebar, id = "one")
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should be automatically
  #     re-executed when inputs change
  #  2) Its output type is a plot
  
  output$distPlot <- renderPlot({
    
    # Old Faithful Geyser data
    x <- faithful[, 2]  
    
    # Access the reactive value by adding parentheses
    bins <- seq(min(x), max(x), length.out = bins() + 1)
    
    # Draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
  
}