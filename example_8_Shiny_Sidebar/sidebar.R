# Module UI function
sidebarUI <- function(id) {
  
  # All UI function bodies start with this statement
  # which creates a namespace function
  ns <- NS(id)
  
  # If you want to return multiple UI objects (not used in this example), 
  # wrap them in tagList() 
  tagList(
    
    # Sidebar with a slider input for number of bins
    sidebarPanel(
      
      # Wrap all input or output ID's in the UI body in ns()
      sliderInput(ns("bins"), 
                     "Number of bins:", 
                     min = 1, 
                     max = 50, 
                     value = 30)
    )
  )
}

# Module server function
sidebar <- function(input, output, session) {
  
  # Return reactive output from the slider as a 
  # reactive expression
  return(reactive(input$bins))

}